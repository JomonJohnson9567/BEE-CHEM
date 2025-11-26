import 'package:flutter/material.dart';
import 'package:flutter_machine_task/presentation/screens/add_personal%20details/widgets/single_checkbox_items.dart';

class RoleSelection extends StatelessWidget {
  const RoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          RoleCheckItem("Colony Owner"),
          RoleCheckItem("Chem Applicator"),
          RoleCheckItem("Land Owner"),
        ],
      ),
    );
  }
}
