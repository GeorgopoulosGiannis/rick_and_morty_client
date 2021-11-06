// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageInfoModel _$PageInfoModelFromJson(Map<String, dynamic> json) =>
    PageInfoModel(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );

Map<String, dynamic> _$PageInfoModelToJson(PageInfoModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
