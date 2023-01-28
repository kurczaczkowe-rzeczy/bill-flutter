import 'dart:developer';

import 'package:paragony/model/shopping_item.dart';

class ShoppingList{
  List<ShoppingItem> list;

  ShoppingList({
    required this.list,
});

  static ShoppingList fromJson(List<dynamic> json) => ShoppingList(
     list: json.map((e) {
       return ShoppingItem.fromJson(e as Map<String, dynamic>);
     }).toList()
  );
}