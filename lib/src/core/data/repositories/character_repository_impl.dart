import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';


import '../../../features/characters_list/data/models/characters_page_model.dart';
import '../../../features/characters_list/domain/entities/characters_page.dart';
import '../../domain/failures/app_failure.dart';
import '../../domain/failures/server_failure.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/entities/character.dart';
import '../../domain/failures/failure.dart';
import '../models/character_model.dart';

const baseUrl = 'rickandmortyapi.com';
const path = 'api/character';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl extends CharacterRepository {
  final http.Client client;

  CharacterRepositoryImpl(this.client);
  @override
  Future<Either<Failure, CharactersPage>> getCharacterPage(int page) async {
    try {
      final uri = getUriForPage(page);
      final response = await client.get(uri);

      return getJsonOrServerFailure(response).fold(
        (left) => Left(left),
        (json) => Right(CharactersPageModel.fromJson(json)),
      );
    } catch (e) {
      return Left(
        ApplicationFailure(
          e.toString(),
        ),
      );
    }
  }

  @visibleForTesting
  Uri getUriForPage(int page) {
    final queryParams = {
      'page': page.toString(),
    };

    return Uri.https(baseUrl, path, queryParams);
  }

  @override
  Future<Either<Failure, Character>> getCharacterForID(int id) async {
    try {
      final uri = getUriForCharacter(id);
      final response = await client.get(uri);
      return getJsonOrServerFailure(response).fold(
        (left) => Left(left),
        (json) => Right(CharacterModel.fromJson(json)),
      );
    } catch (e) {
      return Left(
        ApplicationFailure(
          e.toString(),
        ),
      );
    }
  }

  @visibleForTesting
  Uri getUriForCharacter(int id) {
    return Uri.https(baseUrl, '$path/$id');
  }

  @visibleForTesting
  Either<ServerFailure, Map<String, dynamic>> getJsonOrServerFailure(
    http.Response response,
  ) {
    final body = json.decode(response.body);

    if (response.statusCode != 200) {
      return Left(
        ServerFailure(
          body['error'],
          response.statusCode,
        ),
      );
    }
    return Right(body);
  }
}
