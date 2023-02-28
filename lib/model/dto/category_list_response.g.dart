// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryListResponse _$CategoryListResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryListResponse(
      (json['result'] as List<dynamic>)
          .map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryListResponseToJson(
        CategoryListResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
