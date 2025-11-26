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
        state.copyWith(fullName: event.value, clearSubmissionError: true),
      ),
    );
    on<AddPersonnelAddressChanged>(
      (event, emit) => emit(
        state.copyWith(address: event.value, clearSubmissionError: true),
      ),
    );
    on<AddPersonnelSuburbChanged>(
      (event, emit) =>
          emit(state.copyWith(suburb: event.value, clearSubmissionError: true)),
    );
    on<AddPersonnelStateChanged>(
      (event, emit) => emit(
        state.copyWith(stateName: event.value, clearSubmissionError: true),
      ),
    );
    on<AddPersonnelPostcodeChanged>(
      (event, emit) => emit(
        state.copyWith(postcode: event.value, clearSubmissionError: true),
      ),
    );
    on<AddPersonnelCountryChanged>(
      (event, emit) => emit(
        state.copyWith(country: event.value, clearSubmissionError: true),
      ),
    );
    on<AddPersonnelContactNumberChanged>(
      (event, emit) => emit(
        state.copyWith(contactNumber: event.value, clearSubmissionError: true),
      ),
    );
    on<AddPersonnelLatitudeChanged>(
      (event, emit) => emit(
        state.copyWith(latitude: event.value, clearSubmissionError: true),
      ),
    );
    on<AddPersonnelLongitudeChanged>(
      (event, emit) => emit(
        state.copyWith(longitude: event.value, clearSubmissionError: true),
      ),
    );
    on<AddPersonnelRoleToggled>(_onRoleToggled);
    on<AddPersonnelAdditionalNotesChanged>(
      (event, emit) => emit(
        state.copyWith(
          additionalNotes: event.value,
          clearSubmissionError: true,
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
}
