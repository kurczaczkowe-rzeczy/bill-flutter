import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paragony/screen/addEditProduct/add_edit_product.dart';
import 'package:paragony/screen/categories/add_edit_category.dart';
import 'package:paragony/screen/categories/categories.dart';
import 'package:paragony/screen/createShoppingList/create_shopping_list.dart';
import 'package:paragony/screen/diet/diet_weekly.dart';
import 'package:paragony/screen/recipe/add_recipe.dart';
import 'package:paragony/screen/recipe/recipe.dart';
import 'package:paragony/screen/shoppingList/shopping_list.dart';
import 'package:paragony/screen/shoppingLists/shopping_lists.dart';
import 'package:paragony/shared/colors.dart';
import 'package:paragony/shared/constants.dart';
import 'package:paragony/shared/menu/menu.dart';
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
      theme: ThemeData(
        backgroundColor: background,
      ),
      title: 'Paragony',
      routes: {
        Routes.home: (context) => MenuWidget(child: ShoppingListsWidget()),
        Routes.createList: (context) => CreateShoppingListWidget(),
        Routes.shoppingList: (context) =>
            MenuWidget(child: ShoppingListWidget()),
        Routes.addEditProduct: (context) => AddEditProductWidget(),
        Routes.recipe: (context) => MenuWidget(child: RecipeWidget()),
        Routes.addRecipe: (context) => AddRecipeWidget(),
        Routes.editRecipe: (context) => AddRecipeWidget(),
        Routes.categories: (context) => MenuWidget(child: CategoriesWidget()),
        Routes.addCategory: (context) => AddEditCategoryWidget(),
        Routes.editCategory: (context) => AddEditCategoryWidget(),
        Routes.dietWeek: (context) => MenuWidget(child: DietWeeklyWidget()),
      },
    );
  }
}
