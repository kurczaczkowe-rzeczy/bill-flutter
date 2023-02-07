import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/model/domain/shopping_item.dart';

class ShoppingList {
  Map<Category, List<ShoppingItem>> productsGroupByCategory;

  ShoppingList({
    required this.productsGroupByCategory,
  });
}
