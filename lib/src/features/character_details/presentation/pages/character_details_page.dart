import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injector.dart';

import '../bloc/character_details_bloc.dart';
import '../widgets/detail_card.dart';

class CharacterDetailsPage extends StatelessWidget {
  final int charID;
  const CharacterDetailsPage({
    Key? key,
    required this.charID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterDetailsBloc>(
      create: (context) => sl<CharacterDetailsBloc>(
        param1: charID,
      )..add(const LoadEvent()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
                builder: (context, state) {
              if (state is Loaded) {
                return Text(state.char.name);
              }
              return Container();
            }),
          ),
          body: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
            builder: (context, state) {
              if (state is Error) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is Loaded) {
                return Center(
                  child: DetailCard(
                    char: state.char,
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DetailPageArguments {
  final int charID;

  const DetailPageArguments(this.charID);
}
