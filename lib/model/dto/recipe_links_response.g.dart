// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_links_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeLinksResponse _$RecipeLinksResponseFromJson(Map<String, dynamic> json) =>
    RecipeLinksResponse(
      (json['result'] as List<dynamic>)
          .map(
              (e) => RecipeLinkItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeLinksResponseToJson(
        RecipeLinksResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
