import 'package:json_annotation/json_annotation.dart';
import 'package:paragony/model/domain/unit.dart';
import 'package:paragony/model/dto/category_response.dart';

part 'shopping_list_item_response.g.dart';

@JsonSerializable()
class ShoppingListItemResponse {
  final int id;
  final DateTime createdAt;
  final double quantity;
  final Unit unit;
  final String name;
  final bool inCart;
  final CategoryResponse category;

  ShoppingListItemResponse(this.id, this.createdAt, this.quantity, this.unit,
      this.name, this.inCart, this.category);

  factory ShoppingListItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListItemResponseToJson(this);
}
