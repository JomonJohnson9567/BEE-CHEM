import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_machine_task/core/constants/app_colors.dart';
import 'package:flutter_machine_task/core/controllers/app_controllers.dart';
import 'package:flutter_machine_task/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_machine_task/presentation/bloc/login/login_event.dart';
import 'package:flutter_machine_task/presentation/bloc/login/login_state.dart';
import 'package:flutter_machine_task/presentation/screens/login_page/widgets/login_button.dart';
import 'package:flutter_machine_task/presentation/screens/login_page/widgets/login_textfield.dart';
import 'package:flutter_machine_task/presentation/screens/login_page/widgets/remember_me_checkbox.dart';
import 'package:flutter_machine_task/presentation/screens/personal%20details/personal_details.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _controllers = AppControllers.createMultipleTextControllers([
      'email',
      'password',
    ]);
  }

  @override
  void dispose() {
    AppControllers.disposeMultipleControllers(_controllers);
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(const LoginSubmitted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.shouldAutofillEmail) {
          _controllers['email']!.setTextAndCursor(state.email);
          _controllers['password']!.text = state.password;
          context.read<LoginBloc>().add(const LoginPrefillHandled());
        }

        if (state.status == LoginStatus.failure &&
            (state.errorMessage?.isNotEmpty ?? false)) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        if (state.status == LoginStatus.success) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const PersonnelListScreen()),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _controllers['email']!,
                  hintText: 'Email address',
                  prefixIcon: Icons.email_outlined,
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) =>
                      context.read<LoginBloc>().add(LoginEmailChanged(value)),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _controllers['password']!,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  validator: _validatePassword,
                  onChanged: (value) => context.read<LoginBloc>().add(
                    LoginPasswordChanged(value),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                RememberMeRow(
                  rememberMe: state.rememberMe,
                  onChanged: (value) {
                    context.read<LoginBloc>().add(
                      LoginRememberMeToggled(value ?? false),
                    );
                  },
                ),
                const SizedBox(height: 24),
                LoginButton(
                  isLoading: state.status == LoginStatus.loading,
                  onPressed: state.status == LoginStatus.loading
                      ? null
                      : () => _handleLogin(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (value != value.trim()) {
      return 'Email cannot have leading or trailing spaces';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value != value.trim()) {
      return 'Password cannot have leading or trailing spaces';
    }
    if (value.replaceAll(' ', '').isEmpty) {
      return 'Password cannot be only spaces';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
