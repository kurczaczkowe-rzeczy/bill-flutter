import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:paragony/model/model_category.dart';
import 'package:paragony/model/shopping_item.dart';

class ShoppingList {
  Map<Category, List<ShoppingItem>> productsGroupByCategory;

  ShoppingList({
    required this.productsGroupByCategory,
  });

  static ShoppingList fromJson(List<dynamic> json) {
    List<ShoppingItem> list = json
        .map((e) => ShoppingItem.fromJson(e as Map<String, dynamic>))
        .toList();
    
    Map<Category, List<ShoppingItem>> map =
        groupBy(list, (ShoppingItem p0) => p0.categoryId).map((key, value) =>
            MapEntry(
                Category(
                    id: key,
                    name: value.first.categoryName,
                    color: value.first.categoryColor),
                value));

    return ShoppingList(productsGroupByCategory: map);
  }
}
