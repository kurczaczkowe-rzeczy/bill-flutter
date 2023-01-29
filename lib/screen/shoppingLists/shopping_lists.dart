import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paragony/model/shopping_lists.dart';
import 'package:paragony/model/shopping_lists_item.dart';
import 'package:paragony/screen/shoppingLists/shopping_lists_item.dart';
import 'package:paragony/services/db_service.dart';
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
    dynamic result = await Navigator.pushNamed(context, Routes.createList);
    bool isCreateSuccess = result['addListComplete'] as bool;

    if (isCreateSuccess) {
      setState(() => {_list = DBService().getShoppingLists()});
    }
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
                  return ShoppingListsItemWidget(item: list[index]);
                }),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
