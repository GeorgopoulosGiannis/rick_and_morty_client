// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      json['created'] as String,
      OriginModel.fromJson(json['origin'] as Map<String, dynamic>),
      LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      const CharacterStatusConverter().fromJson(json['status'] as String),
      json['image'] as String,
      json['id'] as int,
      json['name'] as String,
      json['species'] as String,
      json['type'] as String,
      json['gender'] as String,
      (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      json['url'] as String,
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created,
      'origin': instance.originModel.toJson(),
      'location': instance.locationModel.toJson(),
      'status': const CharacterStatusConverter().toJson(instance.statusModel),
      'image': instance.image,
    };
