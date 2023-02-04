import 'package:flutter/material.dart';
import 'package:paragony/model/shopping_item.dart';

class ShoppingListItemWidget extends StatelessWidget {
  final ShoppingItem item;
  final ValueSetter<int> onPressed;

  const ShoppingListItemWidget({Key? key, required this.item, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 30.0),
      child: Text(
        item.name,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
