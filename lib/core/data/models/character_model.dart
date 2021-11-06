import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/character.dart';
import '../../domain/entities/character_status.dart';

import 'location_model.dart';
import 'origin_model.dart';

part 'character_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterModel extends Character {
  final String created;

  @JsonKey(name: 'origin')
  final OriginModel originModel;
  @JsonKey(name: 'location')
  final LocationModel locationModel;

  @JsonKey(name: 'status')
  @CharacterStatusConverter()
  final CharacterStatus statusModel;

  final String image;

  const CharacterModel(
    this.created,
    this.originModel,
    this.locationModel,
    this.statusModel,
    this.image,
    int id,
    String name,
    String species,
    String type,
    String gender,
    List<String> episode,
    String url,
  ) : super(
          id: id,
          name: name,
          status: statusModel,
          species: species,
          type: type,
          gender: gender,
          origin: originModel,
          location: locationModel,
          imageUrl: image,
          episode: episode,
          url: url,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}

class CharacterStatusConverter extends JsonConverter<CharacterStatus, String> {
  const CharacterStatusConverter();

  @override
  CharacterStatus fromJson(String json) {
    for (var value in CharacterStatus.values) {
      if (value.text == json) {
        return value;
      }
    }
    return CharacterStatus.unknown;
  }

  @override
  String toJson(CharacterStatus object) {
    return object.text;
  }
}
