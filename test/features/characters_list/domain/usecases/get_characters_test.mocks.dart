// Mocks generated by Mockito 5.0.16 from annotations
// in rick_and_morty_client/test/features/characters_list/domain/usecases/get_characters_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:either_dart/either.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rick_and_morty_client/core/domain/failures/failure.dart' as _i5;
import 'package:rick_and_morty_client/core/domain/repositories/character_repository.dart'
    as _i3;
import 'package:rick_and_morty_client/features/characters_list/domain/entities/characters_page.dart'
    as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [CharacterRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCharacterRepository extends _i1.Mock
    implements _i3.CharacterRepository {
  MockCharacterRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.CharactersPage>> getCharacterPage(
          {int? page}) =>
      (super.noSuchMethod(
              Invocation.method(#getCharacterPage, [], {#page: page}),
              returnValue:
                  Future<_i2.Either<_i5.Failure, _i6.CharactersPage>>.value(
                      _FakeEither_0<_i5.Failure, _i6.CharactersPage>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.CharactersPage>>);
  @override
  String toString() => super.toString();
}
