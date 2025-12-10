part of 'personnel_list_bloc.dart';

abstract class PersonnelListEvent extends Equatable {
  const PersonnelListEvent();

  @override
  List<Object?> get props => [];
}

class PersonnelListRequested extends PersonnelListEvent {
  const PersonnelListRequested();
}

class PersonnelListRefreshRequested extends PersonnelListEvent {
  const PersonnelListRefreshRequested();
}

class PersonnelListSearchSubmitted extends PersonnelListEvent {
  const PersonnelListSearchSubmitted(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class PersonnelListSearchChanged extends PersonnelListEvent {
  const PersonnelListSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
