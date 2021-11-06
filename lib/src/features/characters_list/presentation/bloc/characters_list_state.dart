part of 'characters_list_bloc.dart';

enum Status { loading, loaded, error }

class CharactersListState extends Equatable {
  final Status status;
  final List<Character> characters;
  final PageInfo? info;
  final String? errorMessage;

  const CharactersListState({
    required this.characters,
    required this.info,
    required this.status,
    this.errorMessage,
  });

  CharactersListState.initial()
      : status = Status.loading,
        characters = [],
        errorMessage = null,
        info = null;

  CharactersListState copyWith({
    Status? status,
    List<Character>? characters,
    PageInfo? info,
    String? errorMessage,
  }) =>
      CharactersListState(
        characters: characters ?? this.characters,
        info: info ?? this.info,
        status: status ?? this.status,
        errorMessage: errorMessage,
      );

  @override
  List<Object> get props => [
        characters,
        status,
      ];
}
