import 'package:flutter/material.dart';
import 'package:flutter_machine_task/presentation/screens/add_personal%20details/widgets/circle_icon.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.asset(
            'assets/images/Frame_18341.png',
            fit: BoxFit.cover,
          ),
        ),

        Positioned.fill(
          top: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CircleIcon(icon: Icons.grid_view_outlined),
                Text(
                  "Personnel Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                CircleIcon(icon: Icons.person_outline),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
