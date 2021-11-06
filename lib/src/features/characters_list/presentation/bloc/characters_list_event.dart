part of 'characters_list_bloc.dart';

abstract class CharactersListEvent extends Equatable {
  const CharactersListEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends CharactersListEvent {
  final int page;
  const LoadEvent(this.page);
}

class LoadMoreEvent extends CharactersListEvent {
  const LoadMoreEvent();
}
