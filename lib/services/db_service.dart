import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:paragony/model/category.dart';
import 'package:paragony/model/new_product.dart';
import 'package:paragony/model/shopping_list.dart';
import 'package:paragony/model/shopping_lists.dart';
import 'package:paragony/model/shopping_lists_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  static final DBService _singleton = DBService._internal();

  factory DBService() => _singleton;

  DBService._internal();

  final supabase = Supabase.instance.client;

  Future<List<Category>> getCategories() async {
    final response = await supabase.rpc('get_categories').select();

    return _convertToListOfCategory(response).toList();
  }

  Future<ShoppingList> getShoppingList(int id) async {
    final response = await supabase
        .rpc('get_shopping_list', params: {'shopping_list_id': id});

    return ShoppingList.fromJson(response);
  }

  Future<ShoppingLists> getShoppingLists() async {
    final response = await supabase.rpc('get_shopping_lists').select();

    return ShoppingLists.fromJson(response);
    return ShoppingLists(list: [
      ShoppingListsItem(id: 0, createAt: DateTime.now(), date: DateTime.now(), name: "Nazwa listy", productsAmount: 5),
      ShoppingListsItem(id: 1, createAt: DateTime.now(), date: DateTime.now(), name: "Nazwa listy 2", productsAmount: 5),
      ShoppingListsItem(id: 3, createAt: DateTime.now(), date: DateTime.now(), name: "Nazwa listy 3", productsAmount: 0),
      ShoppingListsItem(id: 4, createAt: DateTime.now(), date: DateTime.now(), name: "Zakupki", productsAmount: 8),
    ]);
  }
  
  Future<void> createShoppingList(String name, DateTime date) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return await supabase.rpc('create_shopping_list', params: {'name': name, 'date': dateFormat.format(date)});
  }

  Future<void> toggleProductInCart(int productId) async {
    return await supabase
        .rpc('toggle_product_in_cart', params: {'product_id': productId});
  }

  Future<void> createProduct(NewProduct product) async {
    return await supabase.rpc('create_product', params: product.toJson());
  }
}

List<Category> _convertToListOfCategory(List<dynamic> response) {
  return response.map((element) {
    final elem = element as Map<String, dynamic>;
    return Category.fromJson(elem);
  }).toList();
}
