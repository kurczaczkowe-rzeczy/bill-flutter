// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListResponse _$ShoppingListResponseFromJson(
        Map<String, dynamic> json) =>
    ShoppingListResponse(
      (json['result'] as List<dynamic>)
          .map((e) =>
              ShoppingListItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShoppingListResponseToJson(
        ShoppingListResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
