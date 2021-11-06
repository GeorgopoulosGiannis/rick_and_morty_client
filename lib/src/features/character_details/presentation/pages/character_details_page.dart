import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_client/src/core/injector.dart';
import 'package:rick_and_morty_client/src/features/character_details/presentation/widgets/detail_card.dart';

import '../bloc/character_details_bloc.dart';

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
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
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
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is Error) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is Loaded) {
                return Center(child: DetailCard(char: state.char));
              }
              return const Center(
                child: Text('Should not be in this state'),
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
