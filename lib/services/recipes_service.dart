import 'package:paragony/model/domain/edit_recipe.dart';
import 'package:paragony/model/domain/new_recipe.dart';
import 'package:paragony/model/domain/recipe.dart';
import 'package:paragony/model/dto/recipe_links_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeService {
  static final RecipeService _singleton = RecipeService._internal();

  factory RecipeService() => _singleton;

  RecipeService._internal();

  final supabase = Supabase.instance.client;

  Future<List<Recipe>> getRecipes() async {
    final response = await supabase.rpc('get_receipe_links').select();

    List<Recipe> result = RecipeLinksResponse.fromJson(response)
        .result
        .map((e) => Recipe(id: e.id, name: e.name, url: e.link))
        .toList();

    return result;
  }

  Future<void> addRecipe(NewRecipe recipe) async {
    return;
  }

  Future<void> editRecipe(EditRecipe recipe) async {
    return await supabase.rpc('edit_receipe_link', params: recipe.toJson());
  }
}
