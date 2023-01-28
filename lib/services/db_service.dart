import 'package:paragony/model/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  static final DBService _singleton = DBService._internal();

  factory DBService() => _singleton;

  DBService._internal();

  final supabase = Supabase.instance.client;

  Future<List<Category>> getCategories() async {
    final response = await supabase.rpc('get_categories').select();

    final categories = response as List<dynamic>;
    return categories.map((element) {
      final elem = element as Map<String, dynamic>;
      return Category.fromJson(elem);
    }).toList();
  }
}
