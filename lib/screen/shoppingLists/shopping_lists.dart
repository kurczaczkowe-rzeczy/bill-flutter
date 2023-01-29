import 'package:flutter/material.dart';
import 'package:paragony/model/shopping_lists.dart';
import 'package:paragony/model/shopping_lists_item.dart';
import 'package:paragony/screen/shoppingLists/shopping_lists_item.dart';
import 'package:paragony/services/db_service.dart';

class ShoppingListsWidget extends StatefulWidget {
  const ShoppingListsWidget({Key? key}) : super(key: key);

  @override
  State<ShoppingListsWidget> createState() => _ShoppingListsState();
}

class _ShoppingListsState extends State<ShoppingListsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ShoppingLists>(
      future: DBService().getShoppingLists(),
      initialData: ShoppingLists(list: []),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                  onPressed: () {},
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
          return Container();
        }
      },
    );
  }
}
