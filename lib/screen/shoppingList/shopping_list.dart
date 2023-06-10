import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/model/domain/shopping_item.dart';
import 'package:paragony/model/domain/shopping_list.dart';
import 'package:paragony/screen/shoppingList/shopping_list_header.dart';
import 'package:paragony/screen/shoppingList/shopping_list_item.dart';
import 'package:paragony/services/db_service.dart';
import 'package:paragony/shared/constants.dart';
import 'package:paragony/shared/loading.dart';

class ShoppingListWidget extends StatefulWidget {
  final int id;
  const ShoppingListWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<ShoppingListWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  Future<ShoppingList> _list = Future.value(ShoppingList(productsGroupByCategory: {}));
  int listId = -1;

  @override
  void initState() {
    super.initState();
    listId = widget.id;
    _list = DBService().getShoppingList(listId);
  }

  void _onProductClicked(int productId) async {
    await DBService().toggleProductInCart(productId);
    setState(() => {_list = DBService().getShoppingList(listId)});
  }

  void _onProductRemoveClicked(int productId) async {
    await DBService().removeProduct(productId, listId);
    setState(() => {_list = DBService().getShoppingList(listId)});
  }

  void _onCategoryClicked(int categoryId) {}

  void _onAddEditProductClicked(ShoppingItem? product, Category? category) async {
    dynamic result = await Navigator.pushNamed(
      context,
      Routes.addEditProduct,
      arguments: {
        'listId': listId,
        'product': product,
        'category': category,
      },
    );

    bool isAddEditProductSuccess = result['addEditProduct'] as bool? ?? false;

    if (isAddEditProductSuccess) {
      setState(() => {_list = DBService().getShoppingList(listId)});
    }
  }

  @override
  Widget build(BuildContext context) {
    double essentialShoppingItemLayoutSize = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      body: FutureBuilder(
          future: _list,
          initialData: ShoppingList(productsGroupByCategory: {}),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'Brak produktów',
                  style: TextStyle(color: Colors.black12),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }

            ShoppingList shoppingList = snapshot.data as ShoppingList;

            return Material(
                child: Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: GroupListView(
                shrinkWrap: true,
                sectionsCount: shoppingList.productsGroupByCategory.keys.length,
                countOfItemInSection: (int section) {
                  return shoppingList.productsGroupByCategory.values.toList()[section].length;
                },
                itemBuilder: (context, index) {
                  ShoppingItem item = shoppingList.productsGroupByCategory.values.toList()[index.section][index.index];
                  Category category = shoppingList.productsGroupByCategory.keys.toList()[index.section];

                  return ShoppingListItemWidget(
                    item: item,
                    essentialLayoutSize: essentialShoppingItemLayoutSize,
                    onPressed: _onProductClicked,
                    onRemoveClick: _onProductRemoveClicked,
                    onEditClick: (item) {
                      _onAddEditProductClicked(item, category);
                    },
                  );
                },
                groupHeaderBuilder: (BuildContext context, int section) {
                  Category category = shoppingList.productsGroupByCategory.keys.toList()[section];
                  return ShoppingListHeaderWidget(category: category, onPressed: _onCategoryClicked);
                },
                separatorBuilder: (context, index) =>
                    Divider(thickness: 1, color: Colors.grey.withAlpha(30), indent: 16, endIndent: 16),
              ),
            ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddEditProductClicked(null, null),
        child: Icon(Icons.add),
      ),
    );
  }
}
