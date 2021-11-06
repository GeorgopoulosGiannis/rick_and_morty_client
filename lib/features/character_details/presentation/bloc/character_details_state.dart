part of 'character_details_bloc.dart';

abstract class CharacterDetailsState extends Equatable {
  const CharacterDetailsState();
  
  @override
  List<Object> get props => [];
}

class CharacterDetailsInitial extends CharacterDetailsState {}
