import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paragony/model/dto/shopping_list_item_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shopping_list_response.g.dart';

@JsonSerializable()
class ShoppingListResponse {
  final List<ShoppingListItemResponse> result;

  ShoppingListResponse(this.result);

  factory ShoppingListResponse.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListResponseToJson(this);
}
