import 'package:flutter/material.dart';
import 'package:flutter_machine_task/core/constants/app_colors.dart';
import '../../../../data/models/personnel_model.dart';

class PersonnelDetailsDialog extends StatelessWidget {
  final PersonnelModel personnel;

  const PersonnelDetailsDialog({super.key, required this.personnel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with Image and Name
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.amber,
                child: const Icon(
                  Icons.groups_2_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                personnel.displayName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: personnel.isActive
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: personnel.isActive ? Colors.green : Colors.red,
                  ),
                ),
                child: Text(
                  personnel.statusLabel,
                  style: TextStyle(
                    color: personnel.isActive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Details Section
              _buildDetailRow(
                icon: Icons.work,
                label: 'Role',
                value: personnel.role?.name ?? 'No role linked',
              ),
              const Divider(),
              _buildDetailRow(
                icon: Icons.phone,
                label: 'Phone',
                value: personnel.contactNumber.isEmpty
                    ? 'Not provided'
                    : personnel.contactNumber,
              ),
              const Divider(),
              _buildDetailRow(
                icon: Icons.location_on,
                label: 'Address',
                value: personnel.fullAddress.isEmpty
                    ? 'Address not available'
                    : personnel.fullAddress,
              ),

              const SizedBox(height: 24),

              // Close Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
