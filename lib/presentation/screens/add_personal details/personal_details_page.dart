import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/repository/personnel_repository.dart';
import '../../bloc/add_personnel/add_personnel_bloc.dart';
import 'widgets/action_buttons.dart';
import 'widgets/checkbox.dart';
import 'widgets/double_text_field_row.dart';
import 'widgets/header_widget.dart';
import 'widgets/input_field.dart';
import 'widgets/status_switch.dart';

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

class _AddPersonnelView extends StatelessWidget {
  const _AddPersonnelView();

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
          body: Column(
            children: [
              const HeaderSection(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      CustomTextField(
                        value: state.fullName,
                        label: 'Full name',
                        errorText: state.errors['fullName'],
                        onChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelFullNameChanged(value)),
                      ),
                      CustomTextField(
                        value: state.address,
                        label: 'Address',
                        hint: 'Please type',
                        prefixIcon: Icons.location_on_outlined,
                        errorText: state.errors['address'],
                        onChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelAddressChanged(value)),
                      ),
                      CustomTextField(
                        value: state.suburb,
                        label: 'Suburb',
                        errorText: state.errors['suburb'],
                        onChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelSuburbChanged(value)),
                      ),
                      DoubleTextFieldRow(
                        leftValue: state.stateName,
                        leftLabel: 'State',
                        leftError: state.errors['state'],
                        onLeftChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelStateChanged(value)),
                        rightValue: state.postcode,
                        rightLabel: 'Postcode',
                        rightError: state.errors['postcode'],
                        onRightChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelPostcodeChanged(value)),
                        rightKeyboardType: TextInputType.number,
                      ),
                      CustomTextField(
                        value: state.country,
                        label: 'Country',
                        errorText: state.errors['country'],
                        onChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelCountryChanged(value)),
                      ),
                      CustomTextField(
                        value: state.contactNumber,
                        label: 'Contact number',
                        keyboardType: TextInputType.phone,
                        errorText: state.errors['contact'],
                        onChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelContactNumberChanged(value)),
                      ),
                      DoubleTextFieldRow(
                        leftValue: state.latitude,
                        leftLabel: 'Latitude',
                        leftError: state.errors['latitude'],
                        onLeftChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelLatitudeChanged(value)),
                        leftKeyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                        rightValue: state.longitude,
                        rightLabel: 'Longitude',
                        rightError: state.errors['longitude'],
                        onRightChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelLongitudeChanged(value)),
                        rightKeyboardType:
                            const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                      ),
                      const SizedBox(height: 10),
                      RoleSelectionSection(
                        isLoading: state.isLoadingRoles,
                        error: state.rolesError,
                        roles: state.roles,
                        selectedRoleIds: state.selectedRoleIds,
                        submissionError: state.submissionError,
                        onRetry: () => context.read<AddPersonnelBloc>().add(
                          const AddPersonnelRolesRetried(),
                        ),
                        onToggle: (roleId, isSelected) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelRoleToggled(roleId, isSelected)),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        value: state.additionalNotes,
                        label: 'Additional Notes',
                        hint: 'Enter any additional notes...',
                        errorText: state.errors['additionalNotes'],
                        onChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelAdditionalNotesChanged(value)),
                      ),
                      const SizedBox(height: 20),
                      StatusSwitch(
                        isActive: state.isActive,
                        onChanged: (value) => context
                            .read<AddPersonnelBloc>()
                            .add(AddPersonnelStatusToggled(value)),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ActionButtons(
                isSubmitting: state.isSubmitting,
                onCancel: () => Navigator.pop(context),
                onSave: () {
                  context.read<AddPersonnelBloc>().add(
                    const AddPersonnelSubmitted(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
