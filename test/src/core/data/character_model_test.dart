import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_client/src/core/data/models/character_model.dart';
import 'package:rick_and_morty_client/src/core/domain/entities/character.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tCharacterResponse = json.decode(fixture('single_character'));

  test(
    'Should parse response into model',
    () async {
      // act
      final tModel = CharacterModel.fromJson(tCharacterResponse);

      expect(tModel, isA<CharacterModel>());
    },
  );
  test(
    'Should be a subclass of Character entity',
    () async {
      // assert

      final tModel = CharacterModel.fromJson(tCharacterResponse);

      expect(tModel, isA<Character>());
    },
  );
}
