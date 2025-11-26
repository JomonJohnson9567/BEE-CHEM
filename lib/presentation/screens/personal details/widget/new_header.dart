import 'package:flutter/material.dart';

class NewHeader extends StatelessWidget {
  const NewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 180,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Frame 18341.png'),
            fit: BoxFit.cover,
          ),
          color: Color(0xFFFBC02D),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.grid_view_rounded, size: 30),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.person, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Personnel Details List",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
