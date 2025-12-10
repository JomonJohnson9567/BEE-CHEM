import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginStarted extends LoginEvent {
  const LoginStarted();
}

class LoginPrefillHandled extends LoginEvent {
  const LoginPrefillHandled();
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

class LoginRememberMeToggled extends LoginEvent {
  const LoginRememberMeToggled(this.rememberMe);

  final bool rememberMe;

  @override
  List<Object?> get props => [rememberMe];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
