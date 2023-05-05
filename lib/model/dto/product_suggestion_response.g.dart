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
      json['color'] as String,
      DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ProductSuggestionResponseToJson(
        ProductSuggestionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'createdAt': instance.createdAt.toIso8601String(),
    };
