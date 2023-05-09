// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_suggestion_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSuggestionListResponse _$ProductSuggestionListResponseFromJson(
        Map<String, dynamic> json) =>
    ProductSuggestionListResponse(
      (json['result'] as List<dynamic>)
          .map((e) =>
              ProductSuggestionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductSuggestionListResponseToJson(
        ProductSuggestionListResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
