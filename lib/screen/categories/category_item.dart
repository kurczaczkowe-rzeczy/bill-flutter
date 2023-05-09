import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/shared/category_indicator.dart';

class CategoryItemWidget extends StatelessWidget {
  final Category category;
  final bool isPreMade;
  final ValueSetter<int> onRemoveClick;
  final ValueSetter<Category> onEditClick;

  const CategoryItemWidget({
    Key? key,
    required this.category,
    required this.isPreMade,
    required this.onRemoveClick,
    required this.onEditClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPreMade) {
      return _layoutForItem();
    }

    return Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: _itemInSlidable(),
        ),
        child: _layoutForItem());
  }

  Widget _layoutForItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 58.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CategoryIndicator(color: category.color),
            ),
            Text(
              category.name,
              style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700),
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
          onRemoveClick(category.id);
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: Icons.delete_outline,
        label: 'Usuń',
      ),
      SlidableAction(
        onPressed: (context) {
          onEditClick(category);
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: Icons.edit_outlined,
        label: 'Edytuj',
      ),
    ];
  }
}
