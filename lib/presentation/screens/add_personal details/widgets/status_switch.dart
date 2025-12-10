import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class StatusSwitch extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const StatusSwitch({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Switch(
              value: isActive,
              onChanged: onChanged,
              thumbColor: WidgetStatePropertyAll<Color>(AppColors.switchThumb),
              trackColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.switchActive;
                }
                return AppColors.switchInactive;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
