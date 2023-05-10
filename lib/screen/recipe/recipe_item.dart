import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:paragony/model/domain/recipe.dart';

class RecipeItemWidget extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onEditClick;
  final VoidCallback onClick;

  const RecipeItemWidget(
      {Key? key,
      required this.recipe,
      required this.onEditClick,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: _itemInSlidable(),
        ),
        child: _layoutForItem());
  }

  Widget _layoutForItem() {
    return SizedBox(
      child: ListTile(
        title: Text(recipe.name, style: TextStyle(fontSize: 18.0)),
        onTap: onClick,
      ),
    );
  }

  List<SlidableAction> _itemInSlidable() {
    return [
      SlidableAction(
        onPressed: (context) {
          onEditClick();
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: Icons.edit_outlined,
        label: 'Edytuj',
      ),
    ];
  }
}
