part of 'logout_bloc.dart';

enum LogoutStatus { initial, loading, success, failure }

class LogoutState extends Equatable {
  const LogoutState({
    this.status = LogoutStatus.initial,
    this.errorMessage,
    this.userEmail,
  });

  final LogoutStatus status;
  final String? errorMessage;
  final String? userEmail;

  LogoutState copyWith({
    LogoutStatus? status,
    String? errorMessage,
    String? userEmail,
    bool clearError = false,
  }) {
    return LogoutState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      userEmail: userEmail ?? this.userEmail,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, userEmail];
}
