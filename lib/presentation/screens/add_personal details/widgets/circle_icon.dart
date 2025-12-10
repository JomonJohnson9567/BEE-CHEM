import 'package:flutter/material.dart';
import 'package:flutter_machine_task/core/constants/app_colors.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  const CircleIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: AppColors.buttonTextSecondary,
      child: Icon(icon, color: AppColors.buttonText),
    );
  }
}
