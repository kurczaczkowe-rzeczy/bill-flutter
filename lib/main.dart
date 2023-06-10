import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paragony/screen/addEditProduct/add_edit_product.dart';
import 'package:paragony/screen/categories/add_edit_category.dart';
import 'package:paragony/screen/categories/categories.dart';
import 'package:paragony/screen/createShoppingList/create_shopping_list.dart';
import 'package:paragony/screen/recipe/add_recipe.dart';
import 'package:paragony/screen/recipe/recipe.dart';
import 'package:paragony/screen/shoppingLists/shopping_lists.dart';
import 'package:paragony/shared/colors.dart';
import 'package:paragony/shared/constants.dart';
import 'package:paragony/shared/menu/menu.dart';
import 'package:paragony/shared/route_generator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'model/domain/environment_config.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  final envs = await _initEnv();
  await _initDBClient(envs.databaseURL, envs.anonKey);

  usePathUrlStrategy();

  runApp(const MyApp());
}

Future<EnvironmentConfig> _initEnv() async {
  const anonKey = String.fromEnvironment('API_KEY');
  const databaseURL = String.fromEnvironment('BASE_URL');

  if (anonKey != '' && databaseURL != '') {
    return Future.value(EnvironmentConfig(databaseURL: databaseURL, anonKey: anonKey));
  }

  await dotenv.load(fileName: "assets/.env");

  return Future.value(
      EnvironmentConfig(databaseURL: dotenv.env['BASE_URL'] ?? '', anonKey: dotenv.env['API_KEY'] ?? ''));
}

Future _initDBClient(String databaseURL, String anonKey) {
  return Supabase.initialize(url: databaseURL, anonKey: anonKey);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: background,
      ),
      title: 'Paragony',
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      routes: {
        Routes.home: (context) => MenuWidget(child: ShoppingListsWidget()),
        Routes.createList: (context) => CreateShoppingListWidget(),
        Routes.addEditProduct: (context) => AddEditProductWidget(),
        Routes.recipe: (context) => MenuWidget(child: RecipeWidget()),
        Routes.addRecipe: (context) => AddRecipeWidget(),
        Routes.editRecipe: (context) => AddRecipeWidget(),
        Routes.categories: (context) => MenuWidget(child: CategoriesWidget()),
        Routes.addCategory: (context) => AddEditCategoryWidget(),
        Routes.editCategory: (context) => AddEditCategoryWidget(),
      },
    );
  }
}
