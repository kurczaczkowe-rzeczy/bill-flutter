import 'package:flutter/material.dart';
import 'package:paragony/model/domain/shopping_lists.dart';
import 'package:paragony/model/domain/shopping_lists_item.dart';
import 'package:paragony/screen/shoppingLists/shopping_lists_item.dart';
import 'package:paragony/services/shopping_list_service.dart';
import 'package:paragony/shared/constants.dart';
import 'package:paragony/shared/loading.dart';

class ShoppingListsWidget extends StatefulWidget {
  const ShoppingListsWidget({Key? key}) : super(key: key);

  @override
  State<ShoppingListsWidget> createState() => _ShoppingListsState();
}

class _ShoppingListsState extends State<ShoppingListsWidget> {
  Future<ShoppingLists> _list = DBService().getShoppingLists();

  void _onCreateListButtonClicked() async {
    await Navigator.pushNamed(
      context,
      "${Routes.shoppingList}/${RoutesAddition.create}",
    );

    if (mounted) {
      setState(() => _list = DBService().getShoppingLists());
    }
  }

  void _onEditListClick(ShoppingListsItem list) async {
    await Navigator.pushNamed(
      context,
      "${Routes.shoppingList}/${list.id}/${RoutesAddition.edit}",
    );

    if (mounted) {
      setState(() => _list = DBService().getShoppingLists());
    }
  }

  void _onShoppingListClicked(int listID) {
    Navigator.pushNamed(
      context,
      "${Routes.shoppingList}/$listID",
      arguments: listID,
    );
  }

  void _onListRemoveClick(int listID) async {
    await DBService().removeList(listID);
    setState(() => _list = DBService().getShoppingLists());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ShoppingLists>(
      future: _list,
      initialData: ShoppingLists(list: []),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Nie można pobrać danych',
              style: TextStyle(color: Colors.red));
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<ShoppingListsItem> list = snapshot.data?.list ?? [];

          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: FloatingActionButton.extended(
                  label: Text('Stwórz listę zakupów'),
                  onPressed: _onCreateListButtonClicked,
                ),
              ),
            ),
            body: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  ShoppingListsItem item = list[index];
                  return ShoppingListsItemWidget(
                    item: item,
                    onPressed: (listId) {
                      _onShoppingListClicked(listId);
                    },
                    onRemoveClick: _onListRemoveClick,
                    onEditClick: _onEditListClick,
                  );
                }),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
