import 'package:flutter/material.dart';
import 'package:flutter_machine_task/core/constants/app_colors.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  // ignore: use_super_parameters
  const LoginButton({Key? key, required this.onPressed, this.isLoading = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.loadingIndicator,
                  ),
                ),
              )
            : const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.buttonText,
                  letterSpacing: 1,
                ),
              ),
      ),
    );
  }
}
