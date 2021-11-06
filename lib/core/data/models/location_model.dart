import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/location.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel extends Location {
  final String url;
  const LocationModel({
    required this.url,
    required String name,
  }) : super(
          lastKnown: url,
          name: name,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
