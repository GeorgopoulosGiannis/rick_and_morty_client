import 'package:either_dart/either.dart';
import 'package:rick_and_morty_client/src/core/domain/entities/character.dart';

import '../failures/failure.dart';
import '../../../features/characters_list/domain/entities/characters_page.dart';

abstract class CharacterRepository {
  Future<Either<Failure, CharactersPage>> getCharacterPage(int page);

  Future<Either<Failure, Character>> getCharacterForID(int id);
}
