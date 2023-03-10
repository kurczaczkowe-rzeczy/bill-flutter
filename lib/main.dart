import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paragony/screen/createShoppingList/create_shopping_list.dart';
import 'package:paragony/screen/shoppingList/shopping_list.dart';
import 'package:paragony/screen/shoppingLists/shopping_lists.dart';
import 'package:paragony/shared/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await _initEnv();
  await _initDBClient();

  runApp(const MyApp());
}

Future _initEnv() {
  return dotenv.load(fileName: "assets/.env");
}

Future _initDBClient() {
  return Supabase.initialize(
    url: dotenv.env['BASE_URL'] ?? '',
    anonKey: dotenv.env['API_KEY'] ?? '',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paragony',
      routes: {
        Routes.home: (context) => ShoppingListsWidget(),
        Routes.createList: (context) => CreateShoppingListWidget(),
        Routes.shoppingList: (context) => ShoppingListWidget(),
      },
    );
  }
}
