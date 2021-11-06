import 'package:json_annotation/json_annotation.dart';

import '../../../../core/domain/entities/page_info.dart';


part 'page_info_model.g.dart';

@JsonSerializable()
class PageInfoModel extends PageInfo {
  const PageInfoModel({
    required count,
    required pages,
    required next,
    required prev,
  }) : super(
          count: count,
          pages: pages,
          next: next,
          prev: prev,
        );

  factory PageInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PageInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoModelToJson(this);
}
