import 'package:flutter/material.dart';
import 'package:flutter_machine_task/core/constants/app_colors.dart';

class RememberMeRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onChanged;

  const RememberMeRow({
    super.key,
    required this.rememberMe,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: rememberMe,
                onChanged: onChanged,
                activeColor: AppColors.checkboxActive,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Remember me',
              style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            // Handle forgot password
          },
          child: const Text(
            'FORGOT PASSWORD?',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
