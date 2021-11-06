// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../features/character_details/domain/usecases/get_character.dart'
    as _i6;
import '../features/character_details/presentation/bloc/character_details_bloc.dart'
    as _i8;
import '../features/characters_list/domain/usecases/get_characters.dart' as _i7;
import '../features/characters_list/presentation/bloc/characters_list_bloc.dart'
    as _i9;
import 'data/repositories/character_repository_impl.dart' as _i5;
import 'domain/repositories/character_repository.dart' as _i4;
import 'injector.dart' as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.Client>(() => registerModule.client);
  gh.lazySingleton<_i4.CharacterRepository>(
      () => _i5.CharacterRepositoryImpl(get<_i3.Client>()));
  gh.lazySingleton<_i6.GetCharacter>(
      () => _i6.GetCharacter(get<_i4.CharacterRepository>()));
  gh.lazySingleton<_i7.GetCharacters>(
      () => _i7.GetCharacters(get<_i4.CharacterRepository>()));
  gh.factoryParam<_i8.CharacterDetailsBloc, int?, dynamic>((charID, _) =>
      _i8.CharacterDetailsBloc(get<_i6.GetCharacter>(), charID: charID));
  gh.factory<_i9.CharactersListBloc>(
      () => _i9.CharactersListBloc(get<_i7.GetCharacters>()));
  return get;
}

class _$RegisterModule extends _i10.RegisterModule {}
