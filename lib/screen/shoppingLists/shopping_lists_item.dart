import 'package:flutter/material.dart';
import 'package:paragony/model/shopping_lists_item.dart';

class ShoppingListsItemWidget extends StatelessWidget {
  final ShoppingListsItem item;
  final ValueSetter<int> onPressed;

  const ShoppingListsItemWidget(
      {Key? key, required this.item, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.name,
        style: TextStyle(fontSize: 18.0),
      ),
      subtitle: Text('${item.productsAmount} produktów'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        onPressed(item.id);
      },
    );
  }
}
