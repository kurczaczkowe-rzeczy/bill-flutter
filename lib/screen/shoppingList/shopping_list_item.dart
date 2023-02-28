import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:paragony/model/domain/shopping_item.dart';

class ShoppingListItemWidget extends StatelessWidget {
  final ShoppingItem item;
  final ValueSetter<int> onPressed;
  final ValueSetter<int> onRemoveClick;
  final double essentialLayoutSize;

  const ShoppingListItemWidget({Key? key,
    required this.item,
    required this.onPressed,
    required this.onRemoveClick,
    required this.essentialLayoutSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        child: _itemWidget(),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: _itemInSlidable(),
        ));
  }

  Widget _itemWidget() {
    return GestureDetector(
      onTap: () => onPressed(item.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: essentialLayoutSize,
              child: Row(
                children: [
                  Checkbox(
                    value: item.inCart,
                    onChanged: (_) => onPressed(item.id),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  ),
                  Expanded(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: item.inCart ? Colors.black12 : Colors.black,
                        decoration: item.inCart
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              '${item.quantity} ${item.unit.shortName}',
              style: TextStyle(color: Colors.black45),
            )
          ],
        ),
      ),
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
    ];
  }
}
