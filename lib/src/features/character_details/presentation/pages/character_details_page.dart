import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/character_details_bloc.dart';
import '../widgets/detail_card.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: const Key('CharacterDetailsPage'),
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
    );
  }
}

class DetailPageArguments {
  final int charID;

  const DetailPageArguments(this.charID);
}
