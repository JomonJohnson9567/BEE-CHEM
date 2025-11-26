import 'package:flutter/material.dart';

class StatusSwitch extends StatelessWidget {
  const StatusSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Status",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            // Only UI — no state
            Switch(
              value: true,
              onChanged: null, // UI only (Stateless)
              thumbColor: WidgetStatePropertyAll<Color>(Colors.white),
              trackColor: WidgetStatePropertyAll<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
