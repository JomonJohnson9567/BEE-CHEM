class LoginResponse {
  const LoginResponse({
    required this.status,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.expiresInSeconds,
    this.user,
  });

  final bool status;
  final String? message;
  final String? accessToken;
  final String? refreshToken;
  final double? expiresInSeconds;
  final LoginUser? user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] == true,
      message: json['message'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      expiresInSeconds: _parseDouble(json['expires_in_sec']),
      user: json['user'] == null
          ? null
          : LoginUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}

class LoginUser {
  const LoginUser({
    required this.id,
    this.roleId,
    this.role,
    this.firstName,
    this.lastName,
    this.profileImageUrl,
  });

  final int id;
  final int? roleId;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? profileImageUrl;

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      id: _parseInt(json['id']) ?? 0,
      roleId: _parseInt(json['role_id']),
      role: json['role'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
