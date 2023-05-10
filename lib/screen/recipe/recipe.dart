import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paragony/model/domain/recipe.dart';
import 'package:paragony/screen/recipe/recipe_item.dart';
import 'package:paragony/services/recipes_service.dart';
import 'package:paragony/shared/constants.dart';
import 'package:paragony/shared/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeWidget extends StatefulWidget {
  const RecipeWidget({Key? key}) : super(key: key);

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  Future<List<Recipe>> _recipes = Future.value([]);

  @override
  Widget build(BuildContext context) {
    setState(() => {_recipes = RecipeService().getRecipes()});

    return Scaffold(
      body: FutureBuilder(
        future: _recipes,
        initialData: [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Brak przepisów',
                style: TextStyle(color: Colors.black12),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }

          List<Recipe> list = snapshot.data as List<Recipe>;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                Recipe recipe = list[index];
                return RecipeItemWidget(
                  recipe: recipe,
                  onEditClick: () {
                    _onEditRecipeClicked(recipe);
                  },
                  onClick: () {
                    _openUrl(recipe.url);
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddRecipeClicked,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onAddRecipeClicked() async {
    dynamic result = await Navigator.pushNamed(
      context,
      Routes.addRecipe,
    );

    bool isSuccess = result['addRecipe'] as bool? ?? false;

    if (isSuccess) {
      setState(() => {_recipes = RecipeService().getRecipes()});
    }
  }

  void _onEditRecipeClicked(Recipe recipe) async {
    dynamic result = await Navigator.pushNamed(context, Routes.editRecipe,
        arguments: {'recipe': recipe});

    bool isSuccess = result['editRecipe'] as bool? ?? false;

    if (isSuccess) {
      setState(() => {_recipes = RecipeService().getRecipes()});
    }
  }

  void _openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      log("Nie można otworzyć adresu: $url");
    }
  }
}
