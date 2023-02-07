// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListItemResponse _$ShoppingListItemResponseFromJson(
        Map<String, dynamic> json) =>
    ShoppingListItemResponse(
      json['id'] as int,
      DateTime.parse(json['createdAt'] as String),
      json['quantity'] as int,
      $enumDecode(_$UnitEnumMap, json['unit']),
      json['name'] as String,
      json['inCart'] as bool,
      CategoryResponse.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShoppingListItemResponseToJson(
        ShoppingListItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'quantity': instance.quantity,
      'unit': _$UnitEnumMap[instance.unit]!,
      'name': instance.name,
      'inCart': instance.inCart,
      'category': instance.category,
    };

const _$UnitEnumMap = {
  Unit.METER: 'METER',
  Unit.CENTIMETER: 'CENTIMETER',
  Unit.LITER: 'LITER',
  Unit.MILLILITER: 'MILLILITER',
  Unit.KILOGRAM: 'KILOGRAM',
  Unit.GRAM: 'GRAM',
  Unit.QUANTITY: 'QUANTITY',
  Unit.PACK: 'PACK',
};
