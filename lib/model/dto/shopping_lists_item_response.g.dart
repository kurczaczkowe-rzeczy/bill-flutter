// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_lists_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListsItemResponse _$ShoppingListsItemResponseFromJson(
        Map<String, dynamic> json) =>
    ShoppingListsItemResponse(
      json['id'] as int,
      DateTime.parse(json['date'] as String),
      json['name'] as String,
      DateTime.parse(json['createdAt'] as String),
      json['productAmount'] as int,
    );

Map<String, dynamic> _$ShoppingListsItemResponseToJson(
        ShoppingListsItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'productAmount': instance.productAmount,
    };
