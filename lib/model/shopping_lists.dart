import 'package:paragony/model/shopping_lists_item.dart';

class ShoppingLists {
  List<ShoppingListsItem> list;

  ShoppingLists({required this.list});

  static ShoppingLists fromJson(List<dynamic> json) => ShoppingLists(
      list: json
          .map((e) => ShoppingListsItem.fromJson(e as Map<String, dynamic>))
          .toList());
}
