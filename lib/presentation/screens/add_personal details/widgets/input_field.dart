import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int maxLines;
  final TextInputType? keyboardType;

  const CustomInputField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            if (prefixIcon != null) Icon(prefixIcon, color: Colors.grey[700]),

            if (prefixIcon != null) const SizedBox(width: 10),

            Expanded(
              child: TextField(
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                ),
              ),
            ),

            if (suffixIcon != null) Icon(suffixIcon, color: Colors.grey[700]),
          ],
        ),
      ),
    );
  }
}
