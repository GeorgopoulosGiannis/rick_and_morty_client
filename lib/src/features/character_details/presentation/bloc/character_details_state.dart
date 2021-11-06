part of 'character_details_bloc.dart';

abstract class CharacterDetailsState extends Equatable {
  const CharacterDetailsState();

  @override
  List<Object> get props => [];
}

class Empty extends CharacterDetailsState {}

class Loading extends CharacterDetailsState {}

class Loaded extends CharacterDetailsState {
  final Character char;

  const Loaded(this.char);

  @override
  List<Object> get props => [char];
}

class Error extends CharacterDetailsState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
