// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_link_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeLinkItemResponse _$RecipeLinkItemResponseFromJson(
        Map<String, dynamic> json) =>
    RecipeLinkItemResponse(
      json['id'] as int,
      json['name'] as String,
      json['link'] as String,
    );

Map<String, dynamic> _$RecipeLinkItemResponseToJson(
        RecipeLinkItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'link': instance.link,
    };
