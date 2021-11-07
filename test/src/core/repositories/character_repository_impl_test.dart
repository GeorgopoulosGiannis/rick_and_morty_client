

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_client/src/core/data/models/character_model.dart';
import 'package:rick_and_morty_client/src/core/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty_client/src/core/domain/failures/app_failure.dart';
import 'package:rick_and_morty_client/src/core/domain/failures/server_failure.dart';
import 'package:rick_and_morty_client/src/features/characters_list/data/models/characters_page_model.dart';

import '../../../fixtures/fixture_reader.dart';
import 'character_repository_impl_test.mocks.dart';

@GenerateMocks([http.Client, http.Response])
void main() {
  late MockClient mockClient;
  late MockResponse mockResponse;
  late CharacterRepositoryImpl repo;

  

  const tCharactersUrl = 'https://rickandmortyapi.com/api/character?page=2';
  final tCharactersResponsePage2 = fixture('characters_2');


  final tCharResponse = fixture('single_character');

  setUp(
    () {
      mockClient = MockClient();
      mockResponse = MockResponse();

      repo = CharacterRepositoryImpl(mockClient);
    },
  );

  group('getUriForPage', () {
    test(
      'Should create correct uri for given page',
      () async {
        // act
        final uri = repo.getUriForPage(2);

        // assert
        expect(uri.toString(), tCharactersUrl);
      },
    );
  });

  group(
    'getCharacterPage',
    () {
      test(
        'Should return Right<CharactersPageModel> when everything goes well ',
        () async {
          // arrange
          const pageNo = 1;
          final uri = repo.getUriForPage(pageNo);

          when(mockClient.get(uri)).thenAnswer((_) async => mockResponse);
          when(mockResponse.statusCode).thenReturn(200);
          when(mockResponse.body).thenReturn(tCharactersResponsePage2);
          // act
          final result = await repo.getCharacterPage(pageNo);
          // assert
          expect(result, isA<Right>());
          expect(result.right, isA<CharactersPageModel>());
        },
      );

      test(
        'Should return Left<ServerFailure> when server response is not 200 ',
        () async {
          // arrange
          const pageNo = 10000000;
          final uri = repo.getUriForPage(10000000);

          when(mockClient.get(uri)).thenAnswer((_) async => mockResponse);
          when(mockResponse.statusCode).thenReturn(404);
          when(mockResponse.body).thenReturn('{"error":"Not Found" }');
          // act
          final result = await repo.getCharacterPage(pageNo);
          // assert
          expect(result, isA<Left>());
          expect(result.left, isA<ServerFailure>());
          expect(result.left.code, 404);
          expect(result.left.message, 'Not Found');
        },
      );

      test(
        'Should return Left<ApplicationFailure> when something goes wrong with parsing response',
        () async {
          // arrange
          const pageNo = 10000000;
          final uri = repo.getUriForPage(10000000);

          when(mockClient.get(uri)).thenAnswer((_) async => mockResponse);
          when(mockResponse.statusCode).thenReturn(200);
          when(mockResponse.body).thenReturn('');
          // act
          final result = await repo.getCharacterPage(pageNo);
          // assert
          expect(result, isA<Left>());
          expect(result.left, isA<ApplicationFailure>());
          expect(result.left.code, 0);
        },
      );
    },
  );

  group(
    'getCharacterForID',
    () {
      test(
        'Should return Right<CharacterModel> when everything goes well ',
        () async {
          // arrange
          const charID = 1;
          final uri = repo.getUriForCharacter(charID);

          when(mockClient.get(uri)).thenAnswer((_) async => mockResponse);
          when(mockResponse.statusCode).thenReturn(200);
          when(mockResponse.body).thenReturn(tCharResponse);
          // act
          final result = await repo.getCharacterForID(charID);
          // assert
          expect(result, isA<Right>());
          expect(result.right, isA<CharacterModel>());
        },
      );

      test(
        'Should return Left<ApplicationFailure> when something goes wrong with parsing response',
        () async {
          // arrange
          const pageNo = 10000000;
          final uri = repo.getUriForCharacter(10000000);

          when(mockClient.get(uri)).thenAnswer((_) async => mockResponse);
          when(mockResponse.statusCode).thenReturn(200);
          when(mockResponse.body).thenReturn('');
          // act
          final result = await repo.getCharacterForID(pageNo);
          // assert
          expect(result, isA<Left>());
          expect(result.left, isA<ApplicationFailure>());
          expect(result.left.code, 0);
        },
      );
    },
  );
}
