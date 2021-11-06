import 'package:either_dart/either.dart';


import '../failures/failure.dart';
import '../entities/character.dart';
import '../../../features/characters_list/domain/entities/characters_page.dart';

abstract class CharacterRepository {
  Future<Either<Failure, CharactersPage>> getCharacterPage(int page);

  Future<Either<Failure, Character>> getCharacterForID(int id);
}
