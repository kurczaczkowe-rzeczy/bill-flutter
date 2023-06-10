import 'dart:js_interop';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paragony/screen/shoppingList/shopping_list.dart';
import 'package:paragony/screen/shoppingLists/shopping_lists.dart';
import 'package:paragony/shared/constants.dart';
import 'package:paragony/shared/loading.dart';
import 'package:paragony/shared/menu/menu.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final name = settings.name;

    if (name == null) {
      return MaterialPageRoute(settings: settings, builder: (context) => MenuWidget(child: ShoppingListsWidget()));
    }

    List<String> urlParts = name.split('/');

    switch ('/${urlParts[1]}') {
      case Routes.shoppingList:
        {
          if (urlParts.length <= 2 || int.tryParse(urlParts[2]).isNull) {
            return MaterialPageRoute(settings: settings, builder: (context) => Loading());
          }

          return MaterialPageRoute(
              settings: settings,
              builder: (context) => MenuWidget(child: ShoppingListWidget(id: int.parse(urlParts[2]))));
        }
      default:
        {
          return MaterialPageRoute(settings: settings, builder: (context) => MenuWidget(child: ShoppingListsWidget()));
        }
    }
  }
}
