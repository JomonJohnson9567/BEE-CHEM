import 'package:flutter/material.dart';

class PersonnelCard extends StatelessWidget {
  final String name;
  final String role;
  final String phone;
  final String address;
  final String status;
  final Color statusColor;

  const PersonnelCard({
    super.key,
    required this.name,
    required this.role,
    required this.phone,
    required this.address,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            // Main content column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.groups_2_rounded,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Role and Phone in same row
                          Row(
                            children: [
                              const Icon(Icons.person, size: 16),
                              const SizedBox(width: 4),
                              Text(role, style: const TextStyle(fontSize: 14)),
                              const SizedBox(width: 12),
                              const Icon(Icons.phone, size: 16),
                              const SizedBox(width: 4),
                              Text(phone, style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 20),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Status badge positioned at top-right
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: statusColor.withValues(alpha: 0.1),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
