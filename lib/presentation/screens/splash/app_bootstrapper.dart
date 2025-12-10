import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_machine_task/presentation/screens/personal%20details/personal_details.dart';

import '../../../data/repository/auth_repository.dart';
import '../../bloc/bootstrap/bootstrap_bloc.dart';
import '../../bloc/bootstrap/bootstrap_event.dart';
import '../../bloc/bootstrap/bootstrap_state.dart';
import '../login_page/login.dart';

class AppBootstrapper extends StatelessWidget {
  const AppBootstrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BootstrapBloc(authRepository: context.read<AuthRepository>())
            ..add(const BootstrapCheckAuthStatus()),
      child: const _AppBootstrapperView(),
    );
  }
}

class _AppBootstrapperView extends StatelessWidget {
  const _AppBootstrapperView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BootstrapBloc, BootstrapState>(
      builder: (context, state) {
        // Show loading indicator while checking authentication
        if (state.isChecking) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Navigate to appropriate screen based on authentication status
        if (state.isAuthenticated) {
          return const PersonnelListScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
