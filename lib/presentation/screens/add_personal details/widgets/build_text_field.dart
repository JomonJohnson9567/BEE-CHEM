  import 'package:flutter/material.dart';
import 'package:flutter_machine_task/core/constants/app_colors.dart';

Widget buildTextField({
    required String value,
    required String label,
    String? hint,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
    bool compact = false,
  }) {
    final field = TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        hintText: hint ?? 'Please type',
        border: InputBorder.none,
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );

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
                Expanded(child: field),
              ],
            ),
          ),
        ],
      ),
    );
  }