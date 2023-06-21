// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_shopping_list_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortShoppingListInfoResponse _$ShortShoppingListInfoResponseFromJson(
        Map<String, dynamic> json) =>
    ShortShoppingListInfoResponse(
      ShortShoppingListInfoDetailsResponse.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShortShoppingListInfoResponseToJson(
        ShortShoppingListInfoResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
