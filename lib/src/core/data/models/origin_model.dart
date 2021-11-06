import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/origin.dart';

part 'origin_model.g.dart';

@JsonSerializable()
class OriginModel extends Origin {
  const OriginModel({
   required String name,
   required String location,
  }) : super(name, location);

  factory OriginModel.fromJson(Map<String, dynamic> json) =>
      _$OriginModelFromJson(json);

  Map<String, dynamic> toJson() => _$OriginModelToJson(this);
}
