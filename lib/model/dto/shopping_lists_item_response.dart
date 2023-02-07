import 'package:json_annotation/json_annotation.dart';

part 'shopping_lists_item_response.g.dart';

@JsonSerializable()
class ShoppingListsItemResponse {
  int id;
  DateTime date;
  String name;
  DateTime createdAt;
  int productAmount;

  ShoppingListsItemResponse(
      this.id, this.date, this.name, this.createdAt, this.productAmount);

  factory ShoppingListsItemResponse.fromJson(Map<String, dynamic> json) => _$ShoppingListsItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListsItemResponseToJson(this);
}
