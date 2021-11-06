// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharactersPageModel _$CharactersPageModelFromJson(Map<String, dynamic> json) =>
    CharactersPageModel(
      pageInfoModel:
          PageInfoModel.fromJson(json['info'] as Map<String, dynamic>),
      charactersModels: (json['results'] as List<dynamic>)
          .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharactersPageModelToJson(
        CharactersPageModel instance) =>
    <String, dynamic>{
      'info': instance.pageInfoModel,
      'results': instance.charactersModels,
    };
