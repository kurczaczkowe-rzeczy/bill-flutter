import 'package:paragony/model/category.dart';
import 'package:paragony/model/shopping_list.dart';
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

    ShoppingList elem = ShoppingList.fromJson(response);
    return elem;
  }

  Future<void> toggleProductInCart(int productId) async {
    return await supabase
        .rpc('toggle_product_in_cart', params: {'id_of_product': productId});
  }
}

List<Category> _convertToListOfCategory(List<dynamic> response) {
  return response.map((element) {
    final elem = element as Map<String, dynamic>;
    return Category.fromJson(elem);
  }).toList();
}
