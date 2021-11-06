import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_client/src/features/characters_list/data/models/characters_page_model.dart';

import 'package:rick_and_morty_client/src/features/characters_list/domain/usecases/get_characters.dart';
import 'package:rick_and_morty_client/src/features/characters_list/presentation/bloc/characters_list_bloc.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'characters_list_bloc_test.mocks.dart';

@GenerateMocks([GetCharacters])
void main() {
  final tCharacterPageResponse =
      CharactersPageModel.fromJson(json.decode(fixture('characters_only_one')));

  late MockGetCharacters mockGetCharacters;

  final loadedFirstPageState = CharactersListState(
    characters: tCharacterPageResponse.characters.take(1).toList(),
    info: tCharacterPageResponse.info,
    status: Status.loaded,
  );

  setUp(() {
    mockGetCharacters = MockGetCharacters();
  });

  blocTest<CharactersListBloc, CharactersListState>(
    '''emits [CharactersListState.initial()],
       and then adds LoadEvent and emits CharactersListState(status:Status.loaded
                                    characters:characters,
                                    info:info),
     ''',
    setUp: () {
      when(mockGetCharacters.call(1)).thenAnswer(
        (_) async => Right(
          tCharacterPageResponse,
        ),
      );
    },
    build: () => CharactersListBloc(mockGetCharacters),
    //act: (bloc) => bloc..add(const LoadEvent(1)),
    expect: () => [
      CharactersListState.initial(),
      CharactersListState.initial().copyWith(
        characters: tCharacterPageResponse.characters,
        info: tCharacterPageResponse.info,
        status: Status.loaded,
      ),
    ],
  );

  blocTest<CharactersListBloc, CharactersListState>(
    '''emits [CharactersListState(state:Status.loading)],
       and then emits CharactersListState(status:Status.loaded
                                    characters:characters,
                                    info:info),
        on LoadMoreEvent.
     ''',
    setUp: () {
      when(mockGetCharacters.call(2)).thenAnswer(
        (_) async => Right(
          tCharacterPageResponse,
        ),
      );
    },
    seed: () => loadedFirstPageState,
    build: () => CharactersListBloc(mockGetCharacters),
    act: (bloc) => bloc..add(const LoadEvent(2)),
    expect: () => [
      loadedFirstPageState.copyWith(status: Status.loading),
      loadedFirstPageState.copyWith(characters: [
        ...loadedFirstPageState.characters,
        ...loadedFirstPageState.characters
      ]),
    ],
  );
}
