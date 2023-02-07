import 'package:json_annotation/json_annotation.dart';
import 'package:paragony/model/dto/shopping_lists_item_response.dart';

part 'shopping_lists_response.g.dart';

@JsonSerializable()
class ShoppingListsResponse {
  final List<ShoppingListsItemResponse> result;

  ShoppingListsResponse(this.result);

  factory ShoppingListsResponse.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListsResponseToJson(this);
}
