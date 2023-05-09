import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:paragony/model/domain/edit_product.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/model/domain/new_product.dart';
import 'package:paragony/model/domain/new_recipe.dart';
import 'package:paragony/model/domain/recipe.dart';
import 'package:paragony/model/domain/shopping_item.dart';
import 'package:paragony/model/domain/shopping_list.dart';
import 'package:paragony/model/domain/shopping_lists.dart';
import 'package:paragony/model/domain/shopping_lists_item.dart';
import 'package:paragony/model/dto/category_list_response.dart';
import 'package:paragony/model/dto/shopping_list_item_response.dart';
import 'package:paragony/model/dto/shopping_list_response.dart';
import 'package:paragony/model/dto/shopping_lists_response.dart';
import 'package:paragony/shared/extentions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  static final DBService _singleton = DBService._internal();

  factory DBService() => _singleton;

  DBService._internal();

  final supabase = Supabase.instance.client;

  Future<ShoppingList> getShoppingList(int id) async {
    if (id == -1) {
      return ShoppingList(productsGroupByCategory: {});
    }

    final response = await supabase
        .rpc('get_shopping_list', params: {'shopping_list_id': id});

    Map<Category, List<ShoppingItem>> productsGroupByCategory = groupBy(
            ShoppingListResponse.fromJson(response).result,
            (ShoppingListItemResponse response) => response.category.id)
        .map((key, value) => MapEntry(
            Category(
                id: value.first.category.id,
                name: value.first.category.name,
                color: value.first.category.color.toColor()),
            value
                .map((element) => ShoppingItem(
                    id: element.id,
                    createAt: element.createdAt,
                    quantity: element.quantity,
                    unit: element.unit,
                    name: element.name,
                    inCart: element.inCart,
                    categoryId: element.category.id,
                    categoryName: element.category.name,
                    categoryColor: element.category.color.toColor()))
                .toList()));

    return ShoppingList(productsGroupByCategory: productsGroupByCategory);
  }

  Future<ShoppingLists> getShoppingLists() async {
    final response = await supabase.rpc('get_shopping_lists').select();

    List<ShoppingListsItem> list = ShoppingListsResponse.fromJson(response)
        .result
        .map((element) => ShoppingListsItem(
            id: element.id,
            createAt: element.createdAt,
            date: element.date,
            name: element.name,
            productsAmount: element.productAmount))
        .toList();

    return ShoppingLists(list: list);
  }

  Future<void> createShoppingList(String name, DateTime date) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return await supabase.rpc('create_shopping_list',
        params: {'name': name, 'date': dateFormat.format(date)});
  }

  Future<void> toggleProductInCart(int productId) async {
    return await supabase
        .rpc('toggle_product_in_cart', params: {'product_id': productId});
  }

  Future<void> createProduct(NewProduct product) async {
    return await supabase.rpc('add_product_to_shopping_list', params: product.toJson());
  }

  Future<void> removeProduct(int productId, int listId) async {
    return await supabase.rpc('remove_product_from_shopping_list',
        params: {'product_id': productId, 'shopping_list_id': listId});
  }

  Future<void> editProduct(EditProduct product) async {
    return await supabase.rpc('edit_product_in_shopping_list', params: product.toJson());
  }

  Future<List<Category>> getCategories() async {
    final response = await supabase.rpc('get_categories').select();

    return CategoryListResponse.fromJson(response)
        .result
        .map((e) =>
            Category(id: e.id, name: e.name, color: "#${e.color}".toColor()))
        .toList();
  }

  List<Recipe> recipes = [
    Recipe(id: 1, name: "Danie 1", url: "https://www.google.com/"),
    Recipe(id: 2, name: "Danie 2", url: "https://www.google.com/")
  ];

  Future<List<Recipe>> getRecipes() async {
    await Future.delayed(Duration(seconds: 1));
    return recipes;
  }

  Future<void> addRecipe(NewRecipe recipe) async {
    await Future.delayed(Duration(seconds: 1));

    recipes.add(Recipe(id: recipes.length, name: recipe.name, url: recipe.url));

    return;
  }
}
