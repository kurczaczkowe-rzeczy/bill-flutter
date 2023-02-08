import 'package:flutter/material.dart';
import 'package:paragony/model/domain/shopping_item.dart';

class ShoppingListItemWidget extends StatelessWidget {
  final ShoppingItem item;
  final ValueSetter<int> onPressed;
  final double essentialLayoutSize;

  const ShoppingListItemWidget(
      {Key? key,
      required this.item,
      required this.onPressed,
      required this.essentialLayoutSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () => onPressed(item.id),
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
}
