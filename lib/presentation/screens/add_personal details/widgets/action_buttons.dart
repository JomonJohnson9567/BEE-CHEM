import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ActionButtons extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ActionButtons({
    super.key,
    required this.isSubmitting,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.cardBackground,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.buttonSecondary),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: isSubmitting ? null : onSave,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.buttonText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.loadingIndicatorSecondary,
                      ),
                    )
                  : const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
