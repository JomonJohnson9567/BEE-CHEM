import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/personnel_list/personnel_list_bloc.dart';

class SearchBarSection extends StatefulWidget {
  const SearchBarSection({super.key});

  @override
  State<SearchBarSection> createState() => _SearchBarSectionState();
}

class _SearchBarSectionState extends State<SearchBarSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final query = context.read<PersonnelListBloc>().state.searchQuery;
    _controller = TextEditingController(text: query)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitSearch() {
    context.read<PersonnelListBloc>().add(
      PersonnelListSearchSubmitted(_controller.text),
    );
  }

  void _syncWithState(String query) {
    _controller
      ..text = query
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonnelListBloc, PersonnelListState>(
      listenWhen: (previous, current) =>
          previous.searchQuery != current.searchQuery &&
          current.searchQuery.isEmpty,
      listener: (_, state) => _syncWithState(state.searchQuery),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.black54),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Search by name',
                            border: InputBorder.none,
                          ),
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            context.read<PersonnelListBloc>().add(
                              PersonnelListSearchChanged(value),
                            );
                          },
                          onSubmitted: (_) => _submitSearch(),
                        ),
                      ),
                      if (_controller.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () {
                            _syncWithState('');
                            context.read<PersonnelListBloc>().add(
                              const PersonnelListSearchSubmitted(''),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _submitSearch,
              child: CircleAvatar(
                backgroundColor: Colors.yellow[700],
                radius: 24,
                child: const Text(
                  'GO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
