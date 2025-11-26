import 'package:flutter/material.dart';

class RoleCheckItem extends StatelessWidget {
  final String label;
  const RoleCheckItem(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (_) {}),
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
