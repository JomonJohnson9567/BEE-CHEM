import '../models/add_personnel_request.dart';
import '../models/personnel_model.dart';
import '../models/role_model.dart';
import '../services/api_service.dart';

class PersonnelRepository {
  PersonnelRepository({required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  Future<List<PersonnelModel>> fetchPersonnel() async {
    try {
      final response = await _apiService.get('/personnel-details');

      print('[PersonnelRepository] fetchPersonnel response: $response');

      if (response is Map<String, dynamic>) {
        final status = response['status'];
        if (status is bool && !status) {
          throw ApiException(
            response['message'] ?? 'Unable to load personnel.',
          );
        }
        final data = response['data'];
        if (data == null) {
          return [];
        }
        if (data is List) {
          return data
              .whereType<Map<String, dynamic>>()
              .map(PersonnelModel.fromJson)
              .toList();
        }
      }

      if (response is List) {
        // Handle case where API returns array directly
        return response
            .whereType<Map<String, dynamic>>()
            .map(PersonnelModel.fromJson)
            .toList();
      }

      throw ApiException('Unexpected response format: $response');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        'Failed to load personnel. Please check your connection and try again.',
      );
    }
  }

  Future<List<RoleModel>> fetchRoles() async {
    final response = await _apiService.get('/roles/apiary-roles');

    if (response is List) {
      return response
          .whereType<Map<String, dynamic>>()
          .map(RoleModel.fromJson)
          .toList();
    }

    if (response is Map<String, dynamic>) {
      final data = response['data'];
      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map(RoleModel.fromJson)
            .toList();
      }
      if ((response['status'] as bool?) == false) {
        throw ApiException(response['message'] ?? 'Unable to load roles.');
      }
    }

    throw ApiException('Unexpected response while loading roles.');
  }

  Future<void> addPersonnel(AddPersonnelRequest request) async {
    final response = await _apiService.post(
      '/personnel-details/add',
      body: request.toBody(),
    );

    if (response is Map<String, dynamic>) {
      final status = response['status'] as bool? ?? false;
      if (!status) {
        throw ApiException(
          response['message'] ?? 'Unable to save personnel details.',
        );
      }
      return;
    }

    throw ApiException('Unexpected response while saving personnel details.');
  }
}
