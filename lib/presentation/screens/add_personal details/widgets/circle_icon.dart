import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  const CircleIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.white,
      child: Icon(icon, color: Colors.black),
    );
  }
}
