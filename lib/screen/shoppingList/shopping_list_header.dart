import 'package:flutter/material.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/shared/category_indicator.dart';

class ShoppingListHeaderWidget extends StatelessWidget {
  final Category category;
  final ValueSetter<int> onPressed;

  const ShoppingListHeaderWidget({Key? key, required this.category, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(category.id);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CategoryIndicator(color: category.color),
          ),
          Text(
            category.name,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
