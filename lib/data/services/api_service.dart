import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String _baseUrl = 'https://beechem.ishtech.live/api';
  static const String _tokenKey = 'auth_token';

  final http.Client _client;

  Future<dynamic> get(String endpoint) async {
    try {
      final uri = _buildUri(endpoint);
      final headers = await _buildHeaders();

      print('[ApiService.get] Making request to: $uri');
      print('[ApiService.get] Headers: $headers');

      final response = await _client.get(uri, headers: headers);

      print('[ApiService.get] Response status: ${response.statusCode}');

      return _handleResponse(response);
    } on SocketException {
      throw ApiException(
        'No internet connection. Please check your network and try again.',
      );
    } on FormatException {
      throw ApiException('Invalid server response format.');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Network error occurred. Please try again later.');
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final headers = await _buildHeaders();

      // Add Content-Type for form data
      if (body != null) {
        headers['Content-Type'] = 'application/x-www-form-urlencoded';
      }

      final response = await _client.post(
        _buildUri(endpoint),
        headers: headers,
        body: body != null ? _encodeFormData(body) : null,
      );
      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection. Please try again later.');
    } on FormatException {
      throw ApiException('Unable to process the server response.');
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Network error occurred. Please try again later.');
    }
  }

  Uri _buildUri(String endpoint) {
    if (endpoint.startsWith('http')) {
      return Uri.parse(endpoint);
    }
    final trimmed = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    return Uri.parse('$_baseUrl/$trimmed');
  }

  Future<Map<String, String>> _buildHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final headers = <String, String>{'Accept': 'application/json'};

    print(
      '[ApiService] Token from SharedPreferences: ${token?.isNotEmpty == true ? 'Present (${token!.length} chars)' : 'NOT FOUND'}',
    );

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
      print('[ApiService] Authorization header added');
    } else {
      print(
        '[ApiService] WARNING: No token found! User may need to login again.',
      );
    }

    return headers;
  }

  String _encodeFormData(Map<String, dynamic> data) {
    return data.entries
        .map(
          (entry) =>
              '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}',
        )
        .join('&');
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode == 401) {
      throw ApiException(
        'Session expired. Please login again.',
        statusCode: 401,
      );
    }

    if (statusCode == 403) {
      throw ApiException(
        'Access denied. You do not have permission to access this resource.',
        statusCode: 403,
      );
    }

    if (statusCode == 404) {
      throw ApiException(
        'The requested resource was not found.',
        statusCode: 404,
      );
    }

    if (statusCode >= 500) {
      throw ApiException(
        'Server error occurred. Please try again later.',
        statusCode: statusCode,
      );
    }

    if (statusCode < 200 || statusCode >= 300) {
      final message =
          _extractMessage(response.body) ??
          'Request failed with status $statusCode. Please try again.';
      throw ApiException(message, statusCode: statusCode);
    }

    if (response.body.isEmpty) {
      return null;
    }

    try {
      return jsonDecode(response.body);
    } catch (e) {
      throw ApiException('Invalid response format from server.');
    }
  }

  String? _extractMessage(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        return decoded['message'] as String?;
      }
    } catch (_) {
      return null;
    }
    return null;
  }
}

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}
