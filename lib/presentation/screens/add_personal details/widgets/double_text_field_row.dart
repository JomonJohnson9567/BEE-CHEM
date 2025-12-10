import 'package:flutter/material.dart';
import 'input_field.dart';

class DoubleTextFieldRow extends StatelessWidget {
  final String leftValue;
  final String leftLabel;
  final String? leftError;
  final ValueChanged<String> onLeftChanged;
  final TextInputType? leftKeyboardType;

  final String rightValue;
  final String rightLabel;
  final String? rightError;
  final ValueChanged<String> onRightChanged;
  final TextInputType? rightKeyboardType;

  const DoubleTextFieldRow({
    super.key,
    required this.leftValue,
    required this.leftLabel,
    this.leftError,
    required this.onLeftChanged,
    this.leftKeyboardType,
    required this.rightValue,
    required this.rightLabel,
    this.rightError,
    required this.onRightChanged,
    this.rightKeyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextField(
              value: leftValue,
              label: leftLabel,
              compact: true,
              errorText: leftError,
              onChanged: onLeftChanged,
              keyboardType: leftKeyboardType,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomTextField(
              value: rightValue,
              label: rightLabel,
              compact: true,
              errorText: rightError,
              onChanged: onRightChanged,
              keyboardType: rightKeyboardType,
            ),
          ),
        ],
      ),
    );
  }
}
