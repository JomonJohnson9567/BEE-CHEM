import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const LogoutState()) {
    on<LogoutStarted>(_onLogoutStarted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository _authRepository;

  Future<void> _onLogoutStarted(
    LogoutStarted event,
    Emitter<LogoutState> emit,
  ) async {
    final userEmail = await _authRepository.getCurrentUserEmail();
    emit(state.copyWith(userEmail: userEmail));
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LogoutState> emit,
  ) async {
    emit(state.copyWith(status: LogoutStatus.loading));

    try {
      await _authRepository.logout();
      emit(state.copyWith(status: LogoutStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: LogoutStatus.failure,
          errorMessage: 'Failed to logout. Please try again.',
        ),
      );
    }
  }
}
