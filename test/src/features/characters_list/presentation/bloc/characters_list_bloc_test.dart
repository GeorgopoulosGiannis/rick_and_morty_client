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
  late MockGetCharacters mockGetCharacters;
  final tCharacterPageResponse =
      CharactersPageModel.fromJson(json.decode(fixture('characters_only_one')));

  final loadedFirstPageState = CharactersListState(
    characters: tCharacterPageResponse.characters.take(1).toList(),
    info: tCharacterPageResponse.info,
    status: Status.loaded,
  );

  setUp(() {
    mockGetCharacters = MockGetCharacters();
  });
  test(
    'should extract correct page when page number is single digit',
    () {
      // arrange

      const tUrl = 'https://rickandmortyapi.com/api/character?page=2';
      final bloc = CharactersListBloc(mockGetCharacters);
      // act

      final result = bloc.extractNextPageFromUrl(tUrl);
      // assert

      expect(result, 2);
    },
  );

  test(
    'should extract correct page when page number is two digits',
    () {
      // arrange
      const tUrl = 'https://rickandmortyapi.com/api/character?page=20';
      final bloc = CharactersListBloc(mockGetCharacters);
      // act
      final result = bloc.extractNextPageFromUrl(tUrl);
      // assert

      expect(result, 20);
    },
  );

  blocTest<CharactersListBloc, CharactersListState>(
    '''emits nothing,
       when no events are added,
     ''',
    build: () => CharactersListBloc(mockGetCharacters),
    expect: () => [],
  );

  test(
    '''bloc state is  CharactersListState.initial(),
       when no events are added,
     ''',
    () {
      final bloc = CharactersListBloc(mockGetCharacters);
      expect(bloc.state, CharactersListState.initial());
    },
  );

  blocTest<CharactersListBloc, CharactersListState>(
    '''emits [
              CharactersListState.initial().copyWith(status: Status.loading),
              loadedFirstPageState
              ],
       when LoadEvent(1) is added
     ''',
    setUp: () {
      when(mockGetCharacters.call(1)).thenAnswer(
        (_) async => Right(
          tCharacterPageResponse,
        ),
      );
    },
    build: () => CharactersListBloc(mockGetCharacters),
    act: (bloc) => bloc..add(const LoadEvent(1)),
    expect: () => [
      CharactersListState.initial().copyWith(status: Status.loading),
      loadedFirstPageState,
    ],
  );

  blocTest<CharactersListBloc, CharactersListState>(
    '''emits previous state with Status.loading,
        and then adds new characters and emits state with Status.loaded
       when LoadMoreEvent is added
     ''',
    setUp: () {
      when(mockGetCharacters.call(any)).thenAnswer(
        (_) async => Right(
          tCharacterPageResponse,
        ),
      );
    },
    build: () => CharactersListBloc(mockGetCharacters),
    seed: () => loadedFirstPageState,
    act: (bloc) => bloc..add(const LoadMoreEvent()),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      loadedFirstPageState.copyWith(status: Status.loading),
      loadedFirstPageState.copyWith(
        characters: [
          ...loadedFirstPageState.characters,
          ...tCharacterPageResponse.characters,
        ],
      ),
    ],
  );
}
