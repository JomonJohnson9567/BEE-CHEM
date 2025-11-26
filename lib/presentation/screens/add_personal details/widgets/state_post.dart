import 'package:flutter/material.dart';
import 'package:flutter_machine_task/presentation/screens/add_personal%20details/widgets/header_text.dart';
import 'package:flutter_machine_task/presentation/screens/add_personal%20details/widgets/input_field.dart';

class StatePostCodeRow extends StatelessWidget {
  const StatePostCodeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: const [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelText("State"),
                CustomInputField(hint: "Please type"),
              ],
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelText("Post code"),
                CustomInputField(
                  hint: "Please type",
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
