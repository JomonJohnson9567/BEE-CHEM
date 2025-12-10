part of 'add_personnel_bloc.dart';

abstract class AddPersonnelEvent extends Equatable {
  const AddPersonnelEvent();

  @override
  List<Object?> get props => [];
}

class AddPersonnelStarted extends AddPersonnelEvent {
  const AddPersonnelStarted();
}

class AddPersonnelRolesRetried extends AddPersonnelEvent {
  const AddPersonnelRolesRetried();
}

class AddPersonnelFullNameChanged extends AddPersonnelEvent {
  const AddPersonnelFullNameChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelAddressChanged extends AddPersonnelEvent {
  const AddPersonnelAddressChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelSuburbChanged extends AddPersonnelEvent {
  const AddPersonnelSuburbChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelStateChanged extends AddPersonnelEvent {
  const AddPersonnelStateChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelPostcodeChanged extends AddPersonnelEvent {
  const AddPersonnelPostcodeChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelCountryChanged extends AddPersonnelEvent {
  const AddPersonnelCountryChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelContactNumberChanged extends AddPersonnelEvent {
  const AddPersonnelContactNumberChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelLatitudeChanged extends AddPersonnelEvent {
  const AddPersonnelLatitudeChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelLongitudeChanged extends AddPersonnelEvent {
  const AddPersonnelLongitudeChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelRoleToggled extends AddPersonnelEvent {
  const AddPersonnelRoleToggled(this.roleId, this.isSelected);
  final int roleId;
  final bool isSelected;

  @override
  List<Object?> get props => [roleId, isSelected];
}

class AddPersonnelAdditionalNotesChanged extends AddPersonnelEvent {
  const AddPersonnelAdditionalNotesChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class AddPersonnelStatusToggled extends AddPersonnelEvent {
  const AddPersonnelStatusToggled(this.isActive);
  final bool isActive;

  @override
  List<Object?> get props => [isActive];
}

class AddPersonnelSubmitted extends AddPersonnelEvent {
  const AddPersonnelSubmitted();
}

class AddPersonnelSubmissionHandled extends AddPersonnelEvent {
  const AddPersonnelSubmissionHandled();
}
