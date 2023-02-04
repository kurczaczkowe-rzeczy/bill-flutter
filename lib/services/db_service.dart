import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:paragony/model/model_category.dart';
import 'package:paragony/model/new_product.dart';
import 'package:paragony/model/shopping_list.dart';
import 'package:paragony/model/shopping_lists.dart';
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
    // if (id == -1) {
    //   return ShoppingList(list: []);
    // }

    // final response = await supabase
    //     .rpc('get_shopping_list', params: {'shopping_list_id': id});

    List<dynamic> response = [
      {"product_id":7,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Banan","in_cart":false,"category_id":4,"category_name":"Warzywa i owoce","category_color":"3DC753"},
      {"product_id":8,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Banan 2","in_cart":false,"category_id":6,"category_name":"Warzywa i owoce","category_color":"3DC753"},
      {"product_id":9,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko","in_cart":true,"category_id":4,"category_name":"Pieczywo","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":6,"category_name":"Pieczywo","category_color":"222222"},
      {"product_id":9,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko","in_cart":true,"category_id":2,"category_name":"Pieczywo 1","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":2,"category_name":"Pieczywo 1","category_color":"222222"},
      {"product_id":9,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko","in_cart":true,"category_id":1,"category_name":"Pieczywo 2","category_color":"222222"},
      {"product_id":9,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko","in_cart":true,"category_id":1,"category_name":"Pieczywo 2","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":3,"category_name":"Pieczywo 3","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":3,"category_name":"Pieczywo 3","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":5,"category_name":"Pieczywo 4","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":5,"category_name":"Pieczywo 4","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":7,"category_name":"Pieczywo 5","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":7,"category_name":"Pieczywo 5","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":8,"category_name":"Pieczywo 8","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":8,"category_name":"Pieczywo 8","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":8,"category_name":"Pieczywo 8","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
      {"product_id":10,"created_at":"2023-01-31T15:45:42.286935","quantity":1,"unit":"KILOGRAM","product_name":"Jabłko2","in_cart":false,"category_id":9,"category_name":"Pieczywo 9","category_color":"222222"},
    ];

    log('response: $response');

    return ShoppingList.fromJson(response);
  }

  Future<ShoppingLists> getShoppingLists() async {
    final response = await supabase.rpc('get_shopping_lists').select();

    log('response: $response');

    return ShoppingLists.fromJson(response);
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
    return await supabase.rpc('create_product', params: product.toJson());
  }
}

List<Category> _convertToListOfCategory(List<dynamic> response) {
  return response.map((element) {
    final elem = element as Map<String, dynamic>;
    return Category.fromJson(elem);
  }).toList();
}
