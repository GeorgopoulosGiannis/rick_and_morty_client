part of 'character_details_bloc.dart';

abstract class CharacterDetailsEvent extends Equatable {
  const CharacterDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends CharacterDetailsEvent {
  const LoadEvent();
}
