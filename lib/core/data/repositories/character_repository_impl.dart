import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty_client/core/domain/failures/failure.dart';

import 'package:either_dart/either.dart';
import 'package:rick_and_morty_client/core/domain/failures/server_failure.dart';
import 'package:rick_and_morty_client/core/domain/repositories/character_repository.dart';
import 'package:rick_and_morty_client/features/characters_list/data/models/characters_page_model.dart';
import 'package:rick_and_morty_client/features/characters_list/domain/entities/characters_page.dart';

const baseUrl = 'rickandmortyapi.com';
const path = 'api/character';
const pageexample = 'https://rickandmortyapi.com/api/character/?page:2';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl extends CharacterRepository {
  final http.Client client;

  CharacterRepositoryImpl(this.client);
  @override
  Future<Either<Failure, CharactersPage>> getCharacterPage({int? page}) async {
    try {
      final queryParams = {
        'page': page.toString(),
      };
      final uri = Uri.https(baseUrl, path, queryParams);
      final response = await client.get(uri);

      if (response.statusCode != 200) {
        return Left(ServerFailure('', 0));
      }
      final pageModel =
          CharactersPageModel.fromJson(json.decode(response.body));
      return Right(pageModel);
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
          0,
        ),
      );
    }
  }
}
