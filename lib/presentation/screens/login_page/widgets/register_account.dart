import 'package:flutter/material.dart';

class RegisterPrompt extends StatelessWidget {
  // ignore: use_super_parameters
  const RegisterPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        TextButton(
          onPressed: () {
            // Navigate to register screen
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'REGISTER',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF4D03F),
            ),
          ),
        ),
      ],
    );
  }
}
