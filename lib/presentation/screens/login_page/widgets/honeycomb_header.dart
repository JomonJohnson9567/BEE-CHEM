import 'package:flutter/material.dart';

class HoneycombHeader extends StatelessWidget {
  const HoneycombHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background frame
              Image.asset('assets/images/Frame_18338.png', fit: BoxFit.cover),

              // Main bee container
              Positioned(
                top: 130, // adjust if needed for perfect alignment
                child: SizedBox(
                  width: 70,
                  height: 100,

                  child: Image.asset(
                    'assets/images/Vector.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // 'BEE CHEM' text below the image, inside the same stack
              Positioned(
                top: 230, // adjust as needed
                child: const Text(
                  'BEE CHEM',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,

                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
