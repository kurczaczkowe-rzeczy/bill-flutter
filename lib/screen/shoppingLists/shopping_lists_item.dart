import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:paragony/model/domain/shopping_lists_item.dart';

class ShoppingListsItemWidget extends StatelessWidget {
  final ShoppingListsItem item;
  final ValueSetter<int> onPressed;
  final ValueSetter<int> onRemoveClick;
  final ValueSetter<ShoppingListsItem> onEditClick;

  const ShoppingListsItemWidget({
    Key? key,
    required this.item,
    required this.onPressed,
    required this.onRemoveClick,
    required this.onEditClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: _itemWidget(),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: _itemInSlidable(),
      ),
    );
  }

  Widget _itemWidget() {
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

  List<SlidableAction> _itemInSlidable() {
    return [
      SlidableAction(
        onPressed: (context) {
          onRemoveClick(item.id);
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: Icons.delete_outline,
        label: 'Usuń',
      ),
      SlidableAction(
        onPressed: (context) {
          onEditClick(item);
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: Icons.edit_outlined,
        label: 'Edytuj',
      ),
    ];
  }
}
