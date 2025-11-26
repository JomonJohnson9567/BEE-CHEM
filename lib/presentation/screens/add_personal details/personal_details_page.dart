import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/controllers/app_controllers.dart';
import '../../../data/repository/personnel_repository.dart';
import '../../../logic/add_personnel/add_personnel_bloc.dart';
import 'widgets/header_widget.dart';

class AddPersonnelDetailsPage extends StatelessWidget {
  const AddPersonnelDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPersonnelBloc(
        personnelRepository: RepositoryProvider.of<PersonnelRepository>(
          context,
        ),
      )..add(const AddPersonnelStarted()),
      child: const _AddPersonnelView(),
    );
  }
}

class _AddPersonnelView extends StatefulWidget {
  const _AddPersonnelView();

  @override
  State<_AddPersonnelView> createState() => _AddPersonnelViewState();
}

class _AddPersonnelViewState extends State<_AddPersonnelView> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = AppControllers.createMultipleTextControllers([
      'fullName',
      'address',
      'suburb',
      'state',
      'postcode',
      'country',
      'contact',
      'latitude',
      'longitude',
      'additionalNotes',
    ]);
  }

  @override
  void dispose() {
    AppControllers.disposeMultipleControllers(_controllers);
    super.dispose();
  }

  void _submit() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    final state = context.read<AddPersonnelBloc>().state;

    if (!isFormValid) {
      return;
    }

    if (state.selectedRoleIds.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Please select at least one role'),
            backgroundColor: AppColors.snackbarError,
          ),
        );
      return;
    }

    context.read<AddPersonnelBloc>().add(const AddPersonnelSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPersonnelBloc, AddPersonnelState>(
      listener: (context, state) {
        if ((state.submissionError?.isNotEmpty ?? false)) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.submissionError!)));
        }

        if (state.submissionSuccess) {
          context.read<AddPersonnelBloc>().add(
            const AddPersonnelSubmissionHandled(),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Personnel saved successfully.')),
            );
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderSection(),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _controllers['fullName']!,
                    label: 'Full name',
                    onChanged: (value) => context.read<AddPersonnelBloc>().add(
                      AddPersonnelFullNameChanged(value),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Full name is required';
                      }
                      if (value.trim().length < 2) {
                        return 'Full name must be at least 2 characters';
                      }
                      if (value.trim().length > 100) {
                        return 'Full name must be less than 100 characters';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
                        return 'Full name should only contain letters and spaces';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: _controllers['address']!,
                    label: 'Address',
                    hint: 'Please type',
                    prefixIcon: Icons.location_on_outlined,
                    onChanged: (value) => context.read<AddPersonnelBloc>().add(
                      AddPersonnelAddressChanged(value),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Address is required'
                        : null,
                  ),
                  _buildTextField(
                    controller: _controllers['suburb']!,
                    label: 'Suburb',
                    onChanged: (value) => context.read<AddPersonnelBloc>().add(
                      AddPersonnelSuburbChanged(value),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Suburb is required'
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _controllers['state']!,
                            label: 'State',
                            compact: true,
                            onChanged: (value) => context
                                .read<AddPersonnelBloc>()
                                .add(AddPersonnelStateChanged(value)),
                            validator: (value) =>
                                (value == null || value.trim().isEmpty)
                                ? 'State is required'
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _controllers['postcode']!,
                            label: 'Postcode',
                            compact: true,
                            keyboardType: TextInputType.number,
                            onChanged: (value) => context
                                .read<AddPersonnelBloc>()
                                .add(AddPersonnelPostcodeChanged(value)),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Postcode is required';
                              }
                              if (!RegExp(
                                r'^\d{4,6}$',
                              ).hasMatch(value.trim())) {
                                return 'Enter valid postcode (4-6 digits)';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildTextField(
                    controller: _controllers['country']!,
                    label: 'Country',
                    onChanged: (value) => context.read<AddPersonnelBloc>().add(
                      AddPersonnelCountryChanged(value),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Country is required'
                        : null,
                  ),
                  _buildTextField(
                    controller: _controllers['contact']!,
                    label: 'Contact number',
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => context.read<AddPersonnelBloc>().add(
                      AddPersonnelContactNumberChanged(value),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Contact number is required';
                      }
                      // Remove all non-digit characters for validation
                      final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
                      if (digitsOnly.length < 10 || digitsOnly.length > 15) {
                        return 'Enter valid contact number (10-15 digits)';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _controllers['latitude']!,
                            label: 'Latitude',
                            compact: true,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                            onChanged: (value) => context
                                .read<AddPersonnelBloc>()
                                .add(AddPersonnelLatitudeChanged(value)),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Latitude is required';
                              }
                              final lat = double.tryParse(value.trim());
                              if (lat == null) {
                                return 'Enter valid latitude';
                              }
                              if (lat < -90 || lat > 90) {
                                return 'Latitude must be between -90 and 90';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _controllers['longitude']!,
                            label: 'Longitude',
                            compact: true,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                            onChanged: (value) => context
                                .read<AddPersonnelBloc>()
                                .add(AddPersonnelLongitudeChanged(value)),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Longitude is required';
                              }
                              final lng = double.tryParse(value.trim());
                              if (lng == null) {
                                return 'Enter valid longitude';
                              }
                              if (lng < -180 || lng > 180) {
                                return 'Longitude must be between -180 and 180';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    child: Text(
                      'Roles',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
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
                      child: state.isLoadingRoles
                          ? const SizedBox(
                              height: 56,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : state.rolesError != null
                          ? _RolesError(
                              message: state.rolesError!,
                              onRetry: () => context
                                  .read<AddPersonnelBloc>()
                                  .add(const AddPersonnelRolesRetried()),
                            )
                          : state.roles.isEmpty
                          ? const Text(
                              'No roles available',
                              style: TextStyle(color: AppColors.textSecondary),
                            )
                          : Column(
                              children: state.roles.map((role) {
                                final isSelected = state.selectedRoleIds
                                    .contains(role.id);
                                return CheckboxListTile(
                                  title: Text(role.name),
                                  value: isSelected,
                                  onChanged: (value) {
                                    context.read<AddPersonnelBloc>().add(
                                      AddPersonnelRoleToggled(
                                        role.id,
                                        value ?? false,
                                      ),
                                    );
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                );
                              }).toList(),
                            ),
                    ),
                  ),
                  // Roles validation error display
                  if (state.selectedRoleIds.isEmpty &&
                      state.submissionError != null)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: Text(
                        'Please select at least one role',
                        style: TextStyle(
                          color: AppColors.textError,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _controllers['additionalNotes']!,
                    label: 'Additional Notes',
                    hint: 'Enter any additional notes...',
                    onChanged: (value) => context.read<AddPersonnelBloc>().add(
                      AddPersonnelAdditionalNotesChanged(value),
                    ),
                    validator: (value) {
                      if (value != null && value.trim().length > 500) {
                        return 'Additional notes must be less than 500 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Switch(
                            value: state.isActive,
                            onChanged: (value) => context
                                .read<AddPersonnelBloc>()
                                .add(AddPersonnelStatusToggled(value)),
                            thumbColor: WidgetStatePropertyAll<Color>(
                              AppColors.switchThumb,
                            ),
                            trackColor: WidgetStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return AppColors.switchActive;
                              }
                              return AppColors.switchInactive;
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state.submissionError != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Text(
                        state.submissionError!,
                        style: const TextStyle(color: AppColors.textError),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.cardBackground,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: AppColors.buttonSecondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: state.isSubmitting
                                ? null
                                : () => _submit(),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.buttonText,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: state.isSubmitting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color:
                                          AppColors.loadingIndicatorSecondary,
                                    ),
                                  )
                                : const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  String? hint,
  IconData? prefixIcon,
  TextInputType? keyboardType,
  ValueChanged<String>? onChanged,
  String? Function(String?)? validator,
  bool compact = false,
}) {
  final field = TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint ?? 'Please type',
      border: InputBorder.none,
    ),
    keyboardType: keyboardType,
    onChanged: onChanged,
    validator: validator,
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: compact ? 0 : 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4, top: 8),
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [
              if (prefixIcon != null)
                Icon(prefixIcon, color: AppColors.iconGray),
              if (prefixIcon != null) const SizedBox(width: 10),
              Expanded(child: field),
            ],
          ),
        ),
      ],
    ),
  );
}

class _RolesError extends StatelessWidget {
  const _RolesError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
