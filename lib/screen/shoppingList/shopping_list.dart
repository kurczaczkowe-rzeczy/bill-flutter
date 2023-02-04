import 'package:flutter/material.dart';
import 'package:paragony/model/shopping_item.dart';
import 'package:paragony/model/shopping_list.dart';
import 'package:paragony/services/db_service.dart';

class ShoppingListWidget extends StatefulWidget {
  const ShoppingListWidget({Key? key}) : super(key: key);

  @override
  State<ShoppingListWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  Future<ShoppingList> _list = Future.value(ShoppingList(list: []));
  int listId = -1;

  @override
  Widget build(BuildContext context) {
    if (listId == -1) {
      listId = ModalRoute.of(context)?.settings.arguments as int? ?? -1;
      setState(() => {_list = DBService().getShoppingList(listId)});
    }

    return FutureBuilder(
      future: _list,
      initialData: ShoppingList(list: []),
      builder: (context, snapshot) {
        ShoppingList shoppingList = snapshot.data as ShoppingList;
        return Scaffold(
            body: ListView.builder(
                itemCount: shoppingList.list.length,
                itemBuilder: (context, index) {
                  ShoppingItem item = shoppingList.list[index];

                  return Text(item.name);
                }));
      },
    );
  }
}
