import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_machine_task/presentation/widgets/shimmer_loading.dart';

import '../../../data/models/personnel_model.dart';
import '../../../data/repository/personnel_repository.dart';
import '../../../logic/personnel_list/personnel_list_bloc.dart';
import '../add_personal details/personal_details_page.dart';
import 'widget/header_widget.dart';
import 'widget/personnal_card.dart';
import 'widget/personnel_details_dialog.dart';
import 'widget/searchbar_go_button.dart';

class PersonnelListScreen extends StatelessWidget {
  const PersonnelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonnelListBloc(
        personnelRepository: RepositoryProvider.of<PersonnelRepository>(
          context,
        ),
      )..add(const PersonnelListRequested()),
      child: const _PersonnelListView(),
    );
  }
}

class _PersonnelListView extends StatelessWidget {
  const _PersonnelListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32, color: Colors.black),
        onPressed: () {
          Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPersonnelDetailsPage(),
            ),
          ).then((shouldRefresh) {
            if (!context.mounted) return;
            if (shouldRefresh == true) {
              context.read<PersonnelListBloc>().add(
                const PersonnelListRefreshRequested(),
              );
            }
          });
        },
      ),
      body: Column(
        children: [
          const HeaderSection(),
          const SizedBox(height: 10),
          const SearchBarSection(),
          const SizedBox(height: 10),
          Expanded(
            child: BlocConsumer<PersonnelListBloc, PersonnelListState>(
              listener: (context, state) {
                if (state.status == PersonnelListStatus.failure &&
                    (state.errorMessage?.isNotEmpty ?? false)) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text(state.errorMessage!)),
                    );
                }
              },
              builder: (context, state) {
                switch (state.status) {
                  case PersonnelListStatus.loading:
                  case PersonnelListStatus.initial:
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: 6,
                      itemBuilder: (_, __) =>
                          const ShimmerPersonnelPlaceholder(),
                    );

                  case PersonnelListStatus.failure:
                    return _ErrorView(
                      message:
                          state.errorMessage ??
                          'Unable to load personnel. Please try again.',
                      onRetry: () {
                        context.read<PersonnelListBloc>().add(
                          const PersonnelListRequested(),
                        );
                      },
                    );

                  case PersonnelListStatus.empty:
                    final description = state.hasSearchQuery
                        ? 'No personnel matched "${state.searchQuery}".'
                        : 'No personnel found.';
                    return _EmptyView(description: description);

                  case PersonnelListStatus.success:
                    return _PersonnelList(personnel: state.filteredPersonnel);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonnelList extends StatelessWidget {
  const _PersonnelList({required this.personnel});

  final List<PersonnelModel> personnel;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PersonnelListBloc>().add(
          const PersonnelListRefreshRequested(),
        );
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: personnel.length,
        separatorBuilder: (_, __) => const SizedBox(height: 4),
        itemBuilder: (context, index) {
          final person = personnel[index];
          return PersonnelCard(
            name: person.displayName,
            role: person.role?.name ?? 'No role linked',
            phone: person.contactNumber.isEmpty
                ? 'Not provided'
                : person.contactNumber,
            address: person.fullAddress.isEmpty
                ? 'Address not available'
                : person.fullAddress,
            status: person.statusLabel,
            statusColor: person.isActive ? Colors.green : Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => PersonnelDetailsDialog(personnel: person),
              );
            },
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
