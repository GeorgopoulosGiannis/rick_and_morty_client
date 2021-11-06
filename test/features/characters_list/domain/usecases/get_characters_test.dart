import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_client/core/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_client/features/characters_list/data/models/characters_page_model.dart';
import 'package:rick_and_morty_client/features/characters_list/domain/usecases/get_characters.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'get_characters_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  late final MockCharacterRepository mockRepo;
  late final GetCharacters usecase;
  final tCharacterPage2 = CharactersPageModel.fromJson(
    json.decode(
      fixture('characters_2'),
    ),
  );

  setUp(() async {
    mockRepo = MockCharacterRepository();
    usecase = GetCharacters(mockRepo);
  });

  test(
    'Should get characters for given page from the repository',
    () async {
      // arrange
      when(mockRepo.getCharacterPage(page: 2))
          .thenAnswer((_) async => Right(tCharacterPage2));
      // act
      final result = await usecase(2);

      // assert
      expect(result.right, tCharacterPage2);
      verify(mockRepo.getCharacterPage(page: 2)).called(1);
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
