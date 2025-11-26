import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_machine_task/presentation/screens/personal%20details/personal_details.dart';

import '../../../data/repository/auth_repository.dart';
import '../login_page/login.dart';

class AppBootstrapper extends StatefulWidget {
  const AppBootstrapper({super.key});

  @override
  State<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  late final Future<bool> _hasSessionFuture;

  @override
  void initState() {
    super.initState();
    _hasSessionFuture = context.read<AuthRepository>().hasValidSession();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasSessionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final isLoggedIn = snapshot.data ?? false;
        return isLoggedIn ? const PersonnelListScreen() : const LoginScreen();
      },
    );
  }
}
