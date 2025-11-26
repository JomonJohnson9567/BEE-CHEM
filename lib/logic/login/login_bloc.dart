import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/login_request.dart';
import '../../data/repository/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const LoginState()) {
    on<LoginStarted>(_onStarted);
    on<LoginPrefillHandled>(_onPrefillHandled);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginRememberMeToggled>(_onRememberMeChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  Future<void> _onStarted(LoginStarted event, Emitter<LoginState> emit) async {
    final remembered = await _authRepository.loadRememberedCredentials();
    if (remembered != null) {
      emit(
        state.copyWith(
          email: remembered.email,
          password: remembered.password,
          rememberMe: true,
          shouldAutofillEmail: true,
        ),
      );
    }
  }

  void _onPrefillHandled(LoginPrefillHandled event, Emitter<LoginState> emit) {
    if (state.shouldAutofillEmail) {
      emit(state.copyWith(shouldAutofillEmail: false));
    }
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email, errorMessage: null));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password, errorMessage: null));
  }

  Future<void> _onRememberMeChanged(
    LoginRememberMeToggled event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(rememberMe: event.rememberMe));
    if (!event.rememberMe) {
      await _authRepository.clearRememberedCredentials();
    }
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.canSubmit) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Please enter a valid email and password.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));

    try {
      final response = await _authRepository.login(
        LoginRequest(email: state.email, password: state.password),
      );
      await _authRepository.persistToken(response.accessToken!);

      if (state.rememberMe) {
        await _authRepository.rememberCredentials(state.email, state.password);
      } else {
        await _authRepository.clearRememberedCredentials();
      }

      emit(state.copyWith(status: LoginStatus.success, errorMessage: null));
    } on AuthException catch (error) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }
}
