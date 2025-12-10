import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/add_personnel_request.dart';
import '../../data/models/role_model.dart';
import '../../data/repository/personnel_repository.dart';
import '../../data/services/api_service.dart';

part 'add_personnel_event.dart';
part 'add_personnel_state.dart';

class AddPersonnelBloc extends Bloc<AddPersonnelEvent, AddPersonnelState> {
  AddPersonnelBloc({required PersonnelRepository personnelRepository})
    : _repository = personnelRepository,
      super(const AddPersonnelState()) {
    on<AddPersonnelStarted>(_onStarted);
    on<AddPersonnelRolesRetried>(_onRolesRetried);
    on<AddPersonnelFullNameChanged>(
      (event, emit) => emit(
        state.copyWith(
          fullName: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('fullName'),
        ),
      ),
    );
    on<AddPersonnelAddressChanged>(
      (event, emit) => emit(
        state.copyWith(
          address: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('address'),
        ),
      ),
    );
    on<AddPersonnelSuburbChanged>(
      (event, emit) => emit(
        state.copyWith(
          suburb: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('suburb'),
        ),
      ),
    );
    on<AddPersonnelStateChanged>(
      (event, emit) => emit(
        state.copyWith(
          stateName: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('state'),
        ),
      ),
    );
    on<AddPersonnelPostcodeChanged>(
      (event, emit) => emit(
        state.copyWith(
          postcode: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('postcode'),
        ),
      ),
    );
    on<AddPersonnelCountryChanged>(
      (event, emit) => emit(
        state.copyWith(
          country: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('country'),
        ),
      ),
    );
    on<AddPersonnelContactNumberChanged>(
      (event, emit) => emit(
        state.copyWith(
          contactNumber: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('contact'),
        ),
      ),
    );
    on<AddPersonnelLatitudeChanged>(
      (event, emit) => emit(
        state.copyWith(
          latitude: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('latitude'),
        ),
      ),
    );
    on<AddPersonnelLongitudeChanged>(
      (event, emit) => emit(
        state.copyWith(
          longitude: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('longitude'),
        ),
      ),
    );
    on<AddPersonnelRoleToggled>(_onRoleToggled);
    on<AddPersonnelAdditionalNotesChanged>(
      (event, emit) => emit(
        state.copyWith(
          additionalNotes: event.value,
          clearSubmissionError: true,
          errors: Map.of(state.errors)..remove('additionalNotes'),
        ),
      ),
    );
    on<AddPersonnelStatusToggled>(
      (event, emit) => emit(
        state.copyWith(isActive: event.isActive, clearSubmissionError: true),
      ),
    );
    on<AddPersonnelSubmitted>(_onSubmitted);
    on<AddPersonnelSubmissionHandled>(
      (event, emit) => emit(state.copyWith(submissionSuccess: false)),
    );
  }

  final PersonnelRepository _repository;

  Future<void> _onStarted(
    AddPersonnelStarted event,
    Emitter<AddPersonnelState> emit,
  ) async {
    await _loadRoles(emit);
  }

  Future<void> _onRolesRetried(
    AddPersonnelRolesRetried event,
    Emitter<AddPersonnelState> emit,
  ) async {
    await _loadRoles(emit);
  }

  void _onRoleToggled(
    AddPersonnelRoleToggled event,
    Emitter<AddPersonnelState> emit,
  ) {
    final currentRoles = List<int>.from(state.selectedRoleIds);
    if (event.isSelected) {
      if (!currentRoles.contains(event.roleId)) {
        currentRoles.add(event.roleId);
      }
    } else {
      currentRoles.remove(event.roleId);
    }

    emit(
      state.copyWith(selectedRoleIds: currentRoles, clearSubmissionError: true),
    );
  }

  Future<void> _loadRoles(Emitter<AddPersonnelState> emit) async {
    emit(
      state.copyWith(
        isLoadingRoles: true,
        rolesError: null,
        clearRolesError: true,
      ),
    );

    try {
      final roles = await _repository.fetchRoles();
      if (roles.isEmpty) {
        emit(
          state.copyWith(
            isLoadingRoles: false,
            roles: roles,
            selectedRoleIds: <int>[],
            rolesError: 'No roles available.',
            clearRolesError: false,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          isLoadingRoles: false,
          roles: roles,
          selectedRoleIds: <int>[],
          rolesError: null,
          clearRolesError: true,
        ),
      );
    } on ApiException catch (error) {
      emit(state.copyWith(isLoadingRoles: false, rolesError: error.message));
    } catch (_) {
      emit(
        state.copyWith(
          isLoadingRoles: false,
          rolesError: 'Unable to load roles. Please try again.',
        ),
      );
    }
  }

  Future<void> _onSubmitted(
    AddPersonnelSubmitted event,
    Emitter<AddPersonnelState> emit,
  ) async {
    final errors = _validate();
    if (errors.isNotEmpty) {
      emit(
        state.copyWith(
          submissionError: 'Please fix the errors above.',
          submissionSuccess: false,
          errors: errors,
        ),
      );
      return;
    }

    if (!state.canSubmit) {
      emit(
        state.copyWith(
          submissionError:
              'Please provide full name and select at least one role.',
          submissionSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        submissionError: null,
        submissionSuccess: false,
      ),
    );

    try {
      final request = AddPersonnelRequest(
        fullName: state.fullName.trim(),
        address: state.address.trim(),
        suburb: state.suburb.trim(),
        state: state.stateName.trim(),
        postcode: state.postcode.trim(),
        country: state.country.trim(),
        contactNumber: state.contactNumber.trim(),
        latitude: state.latitude.trim(),
        longitude: state.longitude.trim(),
        roleIds: state.selectedRoleIds,
        additionalNotes: state.additionalNotes.trim(),
        isActive: state.isActive,
      );

      await _repository.addPersonnel(request);

      emit(state.copyWith(isSubmitting: false, submissionSuccess: true));
    } on ApiException catch (error) {
      emit(state.copyWith(isSubmitting: false, submissionError: error.message));
    } catch (_) {
      emit(
        state.copyWith(
          isSubmitting: false,
          submissionError: 'Unable to save personnel. Please try again.',
        ),
      );
    }
  }

  Map<String, String> _validate() {
    final errors = <String, String>{};

    if (state.fullName.trim().isEmpty) {
      errors['fullName'] = 'Full name is required';
    } else if (state.fullName.trim().length < 2) {
      errors['fullName'] = 'Full name must be at least 2 characters';
    } else if (state.fullName.trim().length > 100) {
      errors['fullName'] = 'Full name must be less than 100 characters';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(state.fullName.trim())) {
      errors['fullName'] = 'Full name should only contain letters and spaces';
    }

    if (state.address.trim().isEmpty) {
      errors['address'] = 'Address is required';
    }

    if (state.suburb.trim().isEmpty) {
      errors['suburb'] = 'Suburb is required';
    }

    if (state.stateName.trim().isEmpty) {
      errors['state'] = 'State is required';
    }

    if (state.postcode.trim().isEmpty) {
      errors['postcode'] = 'Postcode is required';
    } else if (!RegExp(r'^\d{4,6}$').hasMatch(state.postcode.trim())) {
      errors['postcode'] = 'Enter valid postcode (4-6 digits)';
    }

    if (state.country.trim().isEmpty) {
      errors['country'] = 'Country is required';
    }

    if (state.contactNumber.trim().isEmpty) {
      errors['contact'] = 'Contact number is required';
    } else {
      final digitsOnly = state.contactNumber.replaceAll(RegExp(r'[^\d]'), '');
      if (digitsOnly.length < 10 || digitsOnly.length > 15) {
        errors['contact'] = 'Enter valid contact number (10-15 digits)';
      }
    }

    if (state.latitude.trim().isEmpty) {
      errors['latitude'] = 'Latitude is required';
    } else {
      final lat = double.tryParse(state.latitude.trim());
      if (lat == null) {
        errors['latitude'] = 'Enter valid latitude';
      } else if (lat < -90 || lat > 90) {
        errors['latitude'] = 'Latitude must be between -90 and 90';
      }
    }

    if (state.longitude.trim().isEmpty) {
      errors['longitude'] = 'Longitude is required';
    } else {
      final lng = double.tryParse(state.longitude.trim());
      if (lng == null) {
        errors['longitude'] = 'Enter valid longitude';
      } else if (lng < -180 || lng > 180) {
        errors['longitude'] = 'Longitude must be between -180 and 180';
      }
    }

    if (state.additionalNotes.trim().length > 500) {
      errors['additionalNotes'] =
          'Additional notes must be less than 500 characters';
    }

    return errors;
  }
}
