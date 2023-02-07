import 'package:flutter/material.dart';
import 'package:paragony/model/domain/unit.dart';
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
}
