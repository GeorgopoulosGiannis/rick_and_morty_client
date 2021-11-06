import 'package:json_annotation/json_annotation.dart';

import '../../../../core/data/models/character_model.dart';
import '../../domain/entities/characters_page.dart';

import 'page_info_model.dart';

part 'characters_page_model.g.dart';

@JsonSerializable()
class CharactersPageModel extends CharactersPage {
  @JsonKey(name: 'info')
  final PageInfoModel pageInfoModel;

  @JsonKey(name: 'results')
  final List<CharacterModel> charactersModels;

  const CharactersPageModel({
    required this.pageInfoModel,
    required this.charactersModels,
  }) : super(
          info: pageInfoModel,
          characters: charactersModels,
        );

  factory CharactersPageModel.fromJson(Map<String, dynamic> json) =>
      _$CharactersPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersPageModelToJson(this);
}
