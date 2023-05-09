import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paragony/model/domain/recipe.dart';
import 'package:paragony/services/db_service.dart';
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
    setState(() => {_recipes = DBService().getRecipes()});

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
                return ListTile(
                  title: Text(recipe.name, style: TextStyle(fontSize: 18.0)),
                  onTap: () {
                    _openUrl(recipe.url);
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddRecipeClicked(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _onAddRecipeClicked() async {
    dynamic result = await Navigator.pushNamed(
      context,
      Routes.addRecipe,
    );

    bool isAddRecipeSuccess = result['addRecipe'] as bool? ?? false;

    if (isAddRecipeSuccess) {
      setState(() => {_recipes = DBService().getRecipes()});
    }
  }

  void _openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      log("Nie można otworzyć adresu: $url");
    }
  }
}
