import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRepository {
  AuthRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const _baseUrl = 'https://beechem.ishtech.live/api';
  static const _tokenKey = 'auth_token';
  static const _currentUserEmailKey = 'current_user_email';
  static const _rememberEmailKey = 'remembered_email';
  static const _rememberPasswordKey = 'remembered_password';
  static const _rememberFlagKey = 'remember_me_enabled';

  Future<LoginResponse> login(LoginRequest request) async {
    final uri = Uri.parse('$_baseUrl/login');
    final response = await _client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: request.toFormData(),
    );

    print('[AuthRepository] Login response status: ${response.statusCode}');
    print('[AuthRepository] Login response body: ${response.body}');

    if (response.statusCode != 200) {
      throw AuthException('Unable to reach login service.');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final loginResponse = LoginResponse.fromJson(decoded);

    print('[AuthRepository] Login status: ${loginResponse.status}');
    print(
      '[AuthRepository] Access token present: ${loginResponse.accessToken?.isNotEmpty == true}',
    );

    if (!loginResponse.status || (loginResponse.accessToken?.isEmpty ?? true)) {
      throw AuthException(
        loginResponse.message ?? 'The login credentials are incorrect.',
      );
    }

    print('[AuthRepository] Login successful, token will be persisted');
    return loginResponse;
  }

  Future<void> persistToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    print(
      '[AuthRepository] Token persisted to SharedPreferences (${token.length} chars)',
    );
  }

  Future<void> persistCurrentUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserEmailKey, email);
  }

  Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserEmailKey);
  }

  Future<void> rememberCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_rememberEmailKey, email);
    await prefs.setString(_rememberPasswordKey, password);
    await prefs.setBool(_rememberFlagKey, true);
  }

  Future<void> clearRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_rememberEmailKey);
    await prefs.remove(_rememberPasswordKey);
    await prefs.setBool(_rememberFlagKey, false);
  }

  Future<RememberedCredentials?> loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMeEnabled = prefs.getBool(_rememberFlagKey) ?? false;
    final email = prefs.getString(_rememberEmailKey);
    final password = prefs.getString(_rememberPasswordKey);

    if (!rememberMeEnabled || email == null || password == null) {
      return null;
    }

    return RememberedCredentials(email: email, password: password);
  }

  Future<bool> hasValidSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Checks if the user should be automatically logged in.
  /// Returns true only if both a valid token exists AND remember-me is enabled.
  Future<bool> shouldAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final rememberMeEnabled = prefs.getBool(_rememberFlagKey) ?? false;

    return token != null && token.isNotEmpty && rememberMeEnabled;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_currentUserEmailKey);
    await clearRememberedCredentials();
  }
}

class RememberedCredentials {
  const RememberedCredentials({required this.email, required this.password});

  final String email;
  final String password;
}

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException: $message';
}
