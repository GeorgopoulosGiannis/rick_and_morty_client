import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/characters_list_bloc.dart';
import '../widgets/list_card.dart';

class CharactersListPage extends StatelessWidget {
  const CharactersListPage({Key? key}) : super(key: key);

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
        centerTitle: true,
        title: const Text(
          'The Rick and Morty API',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<CharactersListBloc, CharactersListState>(
          builder: (context, state) {
            if (state.status == Status.error) {
              return Center(
                child: Text(state.errorMessage!),
              );
            }
            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == Status.loaded) {
              return ListView.builder(
                itemCount: state.characters.length,
                itemBuilder: (context, i) {
                  final character = state.characters[i];
                  return ListCard(char: character);
                },
              );
            }
            if (state.status == Status.empty) {
              return const Center(
                child: Text('Rick and Morty API'),
              );
            }
            return const Center(
              child: Text('list list list'),
            );
          },
        ),
      ),
    );
  }
}
