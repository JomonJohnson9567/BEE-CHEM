import 'role_model.dart';

String _stringValue(dynamic value) {
  if (value == null) return '';
  if (value is String) return value;
  return value.toString();
}

class PersonnelModel {
  const PersonnelModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.suburb,
    required this.state,
    required this.postcode,
    required this.country,
    required this.contactNumber,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.roleId,
    this.role,
  });

  factory PersonnelModel.fromJson(Map<String, dynamic> json) {
    return PersonnelModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      firstName: _stringValue(json['first_name']),
      lastName: _stringValue(json['last_name']),
      address: _stringValue(json['address']),
      suburb: _stringValue(json['suburb']),
      state: _stringValue(json['state']),
      postcode: _stringValue(json['postcode']),
      country: _stringValue(json['country']),
      contactNumber: _stringValue(json['contact_number']),
      latitude: _stringValue(json['latitude']),
      longitude: _stringValue(json['longitude']),
      status: json['status'] is bool
          ? ((json['status'] as bool) ? 1 : 0)
          : (int.tryParse(json['status'].toString()) ?? 0),
      roleId: int.tryParse(json['role_id'].toString()),
      role: json['role'] is Map<String, dynamic>
          ? RoleModel.fromJson(json['role'] as Map<String, dynamic>)
          : null,
    );
  }

  final int id;
  final String firstName;
  final String lastName;
  final String address;
  final String suburb;
  final String state;
  final String postcode;
  final String country;
  final String contactNumber;
  final String latitude;
  final String longitude;
  final int status;
  final int? roleId;
  final RoleModel? role;

  String get displayName {
    final parts = [
      firstName.trim(),
      lastName.trim(),
    ].where((value) => value.isNotEmpty).toList();
    final result = parts.join(' ');
    return result.isEmpty ? 'Unknown' : result;
  }

  String get fullAddress {
    final parts = <String>[
      address,
      suburb,
      state,
      postcode,
      country,
    ].where((part) => part.trim().isNotEmpty).toList();
    return parts.join(', ');
  }

  bool get isActive => status == 1;

  String get statusLabel => isActive ? 'Active' : 'Inactive';
}
