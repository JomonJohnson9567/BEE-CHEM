import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_machine_task/data/repository/auth_repository.dart';
import 'package:flutter_machine_task/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_machine_task/presentation/bloc/login/login_event.dart';
import 'package:flutter_machine_task/presentation/screens/login_page/widgets/divider_widget.dart';
import 'package:flutter_machine_task/presentation/screens/login_page/widgets/honeycomb_header.dart';
import 'package:flutter_machine_task/presentation/screens/login_page/widgets/login_form.dart';
import 'package:flutter_machine_task/presentation/screens/login_page/widgets/register_account.dart';
import 'package:flutter_machine_task/presentation/screens/login_page/widgets/welcom_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      )..add(const LoginStarted()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: const [
              HoneycombHeader(),
              SizedBox(height: 60),
              WelcomeText(),
              SizedBox(height: 40),
              LoginForm(),
              SizedBox(height: 30),
              OrDivider(),
              SizedBox(height: 20),
              RegisterPrompt(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
