import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = true,
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.shouldAutofillEmail = false,
  });

  final String email;
  final String password;
  final bool rememberMe;
  final LoginStatus status;
  final String? errorMessage;
  final bool shouldAutofillEmail;

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    LoginStatus? status,
    String? errorMessage,
    bool? shouldAutofillEmail,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      status: status ?? this.status,
      errorMessage: errorMessage,
      shouldAutofillEmail: shouldAutofillEmail ?? this.shouldAutofillEmail,
    );
  }

  bool get canSubmit =>
      email.trim().isNotEmpty &&
      password.isNotEmpty &&
      password.length >= 6 &&
      status != LoginStatus.loading;

  @override
  List<Object?> get props => [
    email,
    password,
    rememberMe,
    status,
    errorMessage,
    shouldAutofillEmail,
  ];
}
