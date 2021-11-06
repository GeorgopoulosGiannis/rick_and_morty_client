import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/domain/repositories/character_repository.dart';

import '../entities/characters_page.dart';

@lazySingleton
class GetCharacters extends UseCase<CharactersPage, int> {
  final CharacterRepository repo;

  GetCharacters(this.repo);
  @override
  Future<Either<Failure, CharactersPage>> call(int params) {
    return repo.getCharacterPage(params);
  }
}
