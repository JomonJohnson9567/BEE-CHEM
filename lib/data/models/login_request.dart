class LoginRequest {
  const LoginRequest({
    required this.email,
    required this.password,
    this.isMobileUser = true,
  });

  final String email;
  final String password;
  final bool isMobileUser;

  Map<String, String> toFormData() {
    return {
      'email': email.trim(),
      'password': password,
      'mob_user': isMobileUser ? '1' : '0',
    };
  }
}
