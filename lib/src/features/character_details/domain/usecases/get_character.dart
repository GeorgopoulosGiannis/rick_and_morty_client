import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty_client/src/core/domain/repositories/character_repository.dart';

import '../../../../core/domain/entities/character.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/usecases/usecase.dart';

@lazySingleton
class GetCharacter extends UseCase<Character, int> {
  final CharacterRepository repo;

  GetCharacter(this.repo);
  @override
  Future<Either<Failure, Character>> call(int params) {
    return repo.getCharacterForID(params);
  }
}
