import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/auth_repository.dart';
import 'bootstrap_event.dart';
import 'bootstrap_state.dart';
 
class BootstrapBloc extends Bloc<BootstrapEvent, BootstrapState> {
  BootstrapBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const BootstrapState()) {
    on<BootstrapCheckAuthStatus>(_onCheckAuthStatus);
  }

  final AuthRepository _authRepository;

   
  Future<void> _onCheckAuthStatus(
    BootstrapCheckAuthStatus event,
    Emitter<BootstrapState> emit,
  ) async {
    // Start in checking state
    emit(state.copyWith(status: BootstrapStatus.checking));

    try {
      // Check if user should be auto-logged in
      final shouldAutoLogin = await _authRepository.shouldAutoLogin();

      // Emit appropriate state based on authentication status
      if (shouldAutoLogin) {
        emit(state.copyWith(status: BootstrapStatus.authenticated));
      } else {
        emit(state.copyWith(status: BootstrapStatus.unauthenticated));
      }
    } catch (error) {
      // If there's any error checking auth status, default to unauthenticated
      emit(state.copyWith(status: BootstrapStatus.unauthenticated));
    }
  }
}
