import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/route_generator.dart';

import '../../../character_details/presentation/pages/character_details_page.dart';

import '../bloc/characters_list_bloc.dart';

import '../widgets/list_card.dart';
import '../widgets/list_scream.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({Key? key}) : super(key: key);

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.read<CharactersListBloc>().add(const LoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'The Rick and Morty API',
          ),
        ),
        body: BlocBuilder<CharactersListBloc, CharactersListState>(
            builder: (context, state) {
          if (state.status == Status.error) {
            return Center(
              child: Text(state.errorMessage!),
            );
          }
          return Loader(
            enabled: state.status == Status.loading,
            child: ListView.builder(
              key: const Key('CharactersListKey'),
              controller: _scrollController,
              itemCount: state.characters.length,
              itemBuilder: (context, i) {
                final character = state.characters[i];
                return ListCard(
                  key: Key('ListItemKey-$i'),
                  char: character,
                  onTap: () {
                    // could directly pass character and avoid second http call
                    Navigator.of(context).pushNamed(
                      Pages.detail,
                      arguments: DetailPageArguments(
                        character.id,
                      ),
                    );
                  },
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
