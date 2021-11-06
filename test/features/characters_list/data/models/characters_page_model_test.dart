import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:rick_and_morty_client/features/characters_list/data/models/characters_page_model.dart';
import 'package:rick_and_morty_client/features/characters_list/domain/entities/characters_page.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tCharacterResponse = json.decode(fixture('characters'));

  test(
    'Should parse response into model',
    () async {
      // act
      final tModel = CharactersPageModel.fromJson(tCharacterResponse);

      expect(tModel, isA<CharactersPageModel>());
    },
  );
  test(
    'Should be a subclass of CharacterPage entity',
    () async {
      // assert

      final tModel = CharactersPageModel.fromJson(tCharacterResponse);

      expect(tModel, isA<CharactersPage>());
    },
  );
}
