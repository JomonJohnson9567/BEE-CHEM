part of 'personnel_list_bloc.dart';

enum PersonnelListStatus { initial, loading, success, empty, failure }

class PersonnelListState extends Equatable {
  const PersonnelListState({
    this.status = PersonnelListStatus.initial,
    this.allPersonnel = const [],
    this.filteredPersonnel = const [],
    this.errorMessage,
    this.searchQuery = '',
  });

  final PersonnelListStatus status;
  final List<PersonnelModel> allPersonnel;
  final List<PersonnelModel> filteredPersonnel;
  final String? errorMessage;
  final String searchQuery;

  bool get hasSearchQuery => searchQuery.trim().isNotEmpty;

  PersonnelListState copyWith({
    PersonnelListStatus? status,
    List<PersonnelModel>? allPersonnel,
    List<PersonnelModel>? filteredPersonnel,
    String? errorMessage,
    bool clearError = false,
    String? searchQuery,
  }) {
    return PersonnelListState(
      status: status ?? this.status,
      allPersonnel: allPersonnel ?? this.allPersonnel,
      filteredPersonnel: filteredPersonnel ?? this.filteredPersonnel,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allPersonnel,
    filteredPersonnel,
    errorMessage,
    searchQuery,
  ];
}
