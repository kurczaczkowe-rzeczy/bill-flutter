import 'dart:math';

import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/model/domain/shopping_item.dart';
import 'package:paragony/model/domain/shopping_list.dart';
import 'package:paragony/screen/shoppingList/shopping_list_header.dart';
import 'package:paragony/screen/shoppingList/shopping_list_item.dart';
import 'package:paragony/services/db_service.dart';
import 'package:paragony/shared/loading.dart';

class ShoppingListWidget extends StatefulWidget {
  const ShoppingListWidget({Key? key}) : super(key: key);

  @override
  State<ShoppingListWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  Future<ShoppingList> _list =
      Future.value(ShoppingList(productsGroupByCategory: {}));
  int listId = -1;

  void _onProductClicked(int productId) async {
    log(productId);
    await DBService().toggleProductInCart(productId);
    setState(() => {_list = DBService().getShoppingList(listId)});
  }

  void _onCategoryClicked(int categoryId) {}

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
          if(!snapshot.hasData){
            return Scaffold(
              body: Center(
                child: Text('Brak produktów', style: TextStyle(color: Colors.black12),),
              ),
            );
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Loading();
          }

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
                return ShoppingListItemWidget(
                    item: item, onPressed: _onProductClicked);
              },
              groupHeaderBuilder: (BuildContext context, int section) {
                Category category =
                    shoppingList.productsGroupByCategory.keys.toList()[section];
                return ShoppingListHeaderWidget(
                    category: category, onPressed: _onCategoryClicked);
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
