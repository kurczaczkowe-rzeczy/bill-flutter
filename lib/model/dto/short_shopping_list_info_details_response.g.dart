// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_shopping_list_info_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortShoppingListInfoDetailsResponse
    _$ShortShoppingListInfoDetailsResponseFromJson(Map<String, dynamic> json) =>
        ShortShoppingListInfoDetailsResponse(
          json['id'] as int,
          DateTime.parse(json['date'] as String),
          json['name'] as String,
          DateTime.parse(json['createdAt'] as String),
        );

Map<String, dynamic> _$ShortShoppingListInfoDetailsResponseToJson(
        ShortShoppingListInfoDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'date': instance.date.toIso8601String(),
    };
