import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String value;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool compact;

  const CustomTextField({
    super.key,
    required this.value,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
    this.errorText,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: compact ? 0 : 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4, top: 8),
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                if (prefixIcon != null)
                  Icon(prefixIcon, color: AppColors.iconGray),
                if (prefixIcon != null) const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: value,
                    decoration: InputDecoration(
                      hintText: hint ?? 'Please type',
                      border: InputBorder.none,
                      errorText: errorText,
                    ),
                    keyboardType: keyboardType,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
