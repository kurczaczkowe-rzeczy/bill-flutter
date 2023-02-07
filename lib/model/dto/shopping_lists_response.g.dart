// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_lists_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListsResponse _$ShoppingListsResponseFromJson(
        Map<String, dynamic> json) =>
    ShoppingListsResponse(
      (json['result'] as List<dynamic>)
          .map((e) =>
              ShoppingListsItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShoppingListsResponseToJson(
        ShoppingListsResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
