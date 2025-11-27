import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/personnel_model.dart';
import '../../data/repository/personnel_repository.dart';
import '../../data/services/api_service.dart';

part 'personnel_list_event.dart';
part 'personnel_list_state.dart';

class PersonnelListBloc extends Bloc<PersonnelListEvent, PersonnelListState> {
  PersonnelListBloc({required PersonnelRepository personnelRepository})
    : _repository = personnelRepository,
      super(const PersonnelListState()) {
    on<PersonnelListRequested>(_onRequested);
    on<PersonnelListRefreshRequested>(_onRefreshRequested);
    on<PersonnelListSearchSubmitted>(_onSearchSubmitted);
  }

  final PersonnelRepository _repository;

  Future<void> _onRequested(
    PersonnelListRequested event,
    Emitter<PersonnelListState> emit,
  ) async {
    await _fetchPersonnel(emit, resetSearch: true);
  }

  Future<void> _onRefreshRequested(
    PersonnelListRefreshRequested event,
    Emitter<PersonnelListState> emit,
  ) async {
    await _fetchPersonnel(emit, resetSearch: false);
  }

  Future<void> _fetchPersonnel(
    Emitter<PersonnelListState> emit, {
    required bool resetSearch,
  }) async {
    emit(
      state.copyWith(
        status: PersonnelListStatus.loading,
        errorMessage: null,
        searchQuery: resetSearch ? '' : state.searchQuery,
      ),
    );

    try {
      final personnel = await _repository.fetchPersonnel();
      final filtered = _applySearch(
        resetSearch ? '' : state.searchQuery,
        personnel,
      );

      if (personnel.isEmpty) {
        emit(
          state.copyWith(
            status: PersonnelListStatus.empty,
            allPersonnel: personnel,
            filteredPersonnel: filtered,
          ),
        );
        return;
      }

      final status = filtered.isEmpty && state.searchQuery.isNotEmpty
          ? PersonnelListStatus.empty
          : PersonnelListStatus.success;

      emit(
        state.copyWith(
          status: status,
          allPersonnel: personnel,
          filteredPersonnel: resetSearch ? personnel : filtered,
          searchQuery: resetSearch ? '' : state.searchQuery,
        ),
      );
    } on ApiException catch (error) {
      print('[PersonnelListBloc] ApiException: ${error.message}');
      emit(
        state.copyWith(
          status: PersonnelListStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (e, stackTrace) {
      print('[PersonnelListBloc] Unexpected error: $e');
      print(stackTrace);
      emit(
        state.copyWith(
          status: PersonnelListStatus.failure,
          errorMessage: 'Unable to load personnel. Please try again.',
        ),
      );
    }
  }

  void _onSearchSubmitted(
    PersonnelListSearchSubmitted event,
    Emitter<PersonnelListState> emit,
  ) {
    final query = event.query.trim();
    final filtered = _applySearch(query, state.allPersonnel);
    final status = filtered.isEmpty
        ? PersonnelListStatus.empty
        : PersonnelListStatus.success;

    emit(
      state.copyWith(
        searchQuery: query,
        filteredPersonnel: filtered,
        status: status,
      ),
    );
  }

  List<PersonnelModel> _applySearch(String query, List<PersonnelModel> source) {
    if (query.isEmpty) {
      return source;
    }

    final lowerQuery = query.toLowerCase();
    return source
        .where(
          (person) => person.displayName.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }
}
