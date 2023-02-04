import 'package:flutter/material.dart';
import 'package:paragony/model/unit.dart';
import 'package:paragony/shared/extentions.dart';

class ShoppingItem {
  int id;
  DateTime createAt;
  num quantity;
  Unit unit;
  String name;
  bool inCart;
  int categoryId;
  String categoryName;
  Color categoryColor;

  ShoppingItem({
    required this.id,
    required this.createAt,
    required this.quantity,
    required this.unit,
    required this.name,
    required this.inCart,
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
  });

  static ShoppingItem fromJson(Map<String, dynamic> json) {
    Unit unit = Unit.getValue(json['unit'] as String);
    String color = '#${json['category_color']}';
    DateTime createAt = DateTime.parse(json['created_at'] as String);

    return ShoppingItem(
        id: json['product_id'] as int,
        createAt: createAt,
        quantity: json['quantity'] as num,
        unit: unit,
        name: json['product_name'] as String,
        inCart: json['in_cart'] as bool,
        categoryId: json['category_id'] as int,
        categoryName: json['category_name'] as String,
        categoryColor: color.toColor());
  }
}
