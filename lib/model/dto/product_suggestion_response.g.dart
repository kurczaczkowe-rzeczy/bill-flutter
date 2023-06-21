// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_suggestion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSuggestionResponse _$ProductSuggestionResponseFromJson(
        Map<String, dynamic> json) =>
    ProductSuggestionResponse(
      json['id'] as int,
      json['name'] as String,
      $enumDecode(_$UnitEnumMap, json['unit']),
      DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ProductSuggestionResponseToJson(
        ProductSuggestionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': _$UnitEnumMap[instance.unit]!,
      'createdAt': instance.createdAt.toIso8601String(),
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
