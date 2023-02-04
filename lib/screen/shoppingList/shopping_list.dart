import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:paragony/model/model_category.dart';
import 'package:paragony/model/shopping_item.dart';
import 'package:paragony/model/shopping_list.dart';
import 'package:paragony/services/db_service.dart';

class ShoppingListWidget extends StatefulWidget {
  const ShoppingListWidget({Key? key}) : super(key: key);

  @override
  State<ShoppingListWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  Future<ShoppingList> _list =
      Future.value(ShoppingList(productsGroupByCategory: {}));
  int listId = -1;

  @override
  Widget build(BuildContext context) {
    if (listId == -1) {
      listId = ModalRoute.of(context)?.settings.arguments as int? ?? -1;
      setState(() => {_list = DBService().getShoppingList(listId)});
    }

    return FutureBuilder(
        future: _list,
        initialData: ShoppingList(productsGroupByCategory: {}),
        builder: (context, snapshot) {
          ShoppingList shoppingList = snapshot.data as ShoppingList;

          return Scaffold(
            body: GroupListView(
              sectionsCount: shoppingList.productsGroupByCategory.keys.length,
              countOfItemInSection: (int section) {
                return shoppingList.productsGroupByCategory.values
                    .toList()[section]
                    .length;
              },
              itemBuilder: (context, index) {
                ShoppingItem item = shoppingList.productsGroupByCategory.values
                    .toList()[index.section][index.index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 30.0),
                  child: Text(
                    item.name,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              },
              groupHeaderBuilder: (BuildContext context, int section) {
                Category category =
                    shoppingList.productsGroupByCategory.keys.toList()[section];
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                            color: category.color,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4.0)),
                      ),
                    ),
                    Text(
                      category.name,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  color: Colors.grey.withAlpha(30),
                  indent: 16,
                  endIndent: 16),
            ),
          );
        });
  }
}
