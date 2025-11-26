part of 'add_personnel_bloc.dart';

class AddPersonnelState extends Equatable {
  const AddPersonnelState({
    this.fullName = '',
    this.address = '',
    this.suburb = '',
    this.stateName = '',
    this.postcode = '',
    this.country = '',
    this.contactNumber = '',
    this.latitude = '',
    this.longitude = '',
    this.isActive = true,
    this.roles = const [],
    this.selectedRoleIds = const [],
    this.additionalNotes = '',
    this.isLoadingRoles = false,
    this.rolesError,
    this.isSubmitting = false,
    this.submissionError,
    this.submissionSuccess = false,
  });

  final String fullName;
  final String address;
  final String suburb;
  final String stateName;
  final String postcode;
  final String country;
  final String contactNumber;
  final String latitude;
  final String longitude;
  final bool isActive;
  final List<RoleModel> roles;
  final List<int> selectedRoleIds;
  final String additionalNotes;
  final bool isLoadingRoles;
  final String? rolesError;
  final bool isSubmitting;
  final String? submissionError;
  final bool submissionSuccess;

  bool get canSubmit =>
      fullName.trim().isNotEmpty && selectedRoleIds.isNotEmpty;

  AddPersonnelState copyWith({
    String? fullName,
    String? address,
    String? suburb,
    String? stateName,
    String? postcode,
    String? country,
    String? contactNumber,
    String? latitude,
    String? longitude,
    bool? isActive,
    List<RoleModel>? roles,
    List<int>? selectedRoleIds,
    String? additionalNotes,
    bool? isLoadingRoles,
    String? rolesError,
    bool clearRolesError = false,
    bool? isSubmitting,
    String? submissionError,
    bool clearSubmissionError = false,
    bool? submissionSuccess,
  }) {
    return AddPersonnelState(
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      suburb: suburb ?? this.suburb,
      stateName: stateName ?? this.stateName,
      postcode: postcode ?? this.postcode,
      country: country ?? this.country,
      contactNumber: contactNumber ?? this.contactNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isActive: isActive ?? this.isActive,
      roles: roles ?? this.roles,
      selectedRoleIds: selectedRoleIds ?? this.selectedRoleIds,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      isLoadingRoles: isLoadingRoles ?? this.isLoadingRoles,
      rolesError: clearRolesError ? null : (rolesError ?? this.rolesError),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submissionError: clearSubmissionError
          ? null
          : (submissionError ?? this.submissionError),
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    address,
    suburb,
    stateName,
    postcode,
    country,
    contactNumber,
    latitude,
    longitude,
    isActive,
    roles,
    selectedRoleIds,
    additionalNotes,
    isLoadingRoles,
    rolesError,
    isSubmitting,
    submissionError,
    submissionSuccess,
  ];
}
