import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/role_model.dart';
import 'roles_error.dart';

class RoleSelectionSection extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final List<RoleModel> roles;
  final List<int> selectedRoleIds;
  final VoidCallback onRetry;
  final void Function(int roleId, bool isSelected) onToggle;
  final String? submissionError;

  const RoleSelectionSection({
    super.key,
    required this.isLoading,
    this.error,
    required this.roles,
    required this.selectedRoleIds,
    required this.onRetry,
    required this.onToggle,
    this.submissionError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: Text(
            'Roles',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 56,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : error != null
                ? RolesError(message: error!, onRetry: onRetry)
                : roles.isEmpty
                ? const Text(
                    'No roles available',
                    style: TextStyle(color: AppColors.textSecondary),
                  )
                : Column(
                    children: roles.map((role) {
                      final isSelected = selectedRoleIds.contains(role.id);
                      return CheckboxListTile(
                        title: Text(role.name),
                        value: isSelected,
                        onChanged: (value) => onToggle(role.id, value ?? false),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
          ),
        ),
        if (selectedRoleIds.isEmpty && submissionError != null)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              'Please select at least one role',
              style: TextStyle(color: AppColors.textError, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
