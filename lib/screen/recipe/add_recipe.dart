import 'package:flutter/material.dart';
import 'package:paragony/model/domain/edit_recipe.dart';
import 'package:paragony/model/domain/new_recipe.dart';
import 'package:paragony/model/domain/recipe.dart';
import 'package:paragony/services/recipes_service.dart';
import 'package:paragony/shared/constants.dart';
import 'package:paragony/shared/styles.dart';

class AddRecipeWidget extends StatefulWidget {
  const AddRecipeWidget({Key? key}) : super(key: key);

  @override
  State<AddRecipeWidget> createState() => _AddRecipeWidgetState();
}

class _AddRecipeWidgetState extends State<AddRecipeWidget> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _url = '';

  Recipe? _recipe;
  int _recipeId = -1;
  bool _isEdit = false;

  String _toolbarTitle = 'Dodaj przepis';

  @override
  Widget build(BuildContext context) {
    String route = ModalRoute.of(context)?.settings.name ?? "";

    if (route == Routes.editRecipe && _recipeId == -1) {
      Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
      Recipe recipe = arguments['recipe'] as Recipe;

      _recipe = recipe;
      _recipeId = _recipe?.id ?? _recipeId;
      _isEdit = true;
      _toolbarTitle = 'Edytuj przepis';

      _name = _recipe?.name ?? _name;
      _url = _recipe?.url ?? _url;
    }

    return Scaffold(
      appBar: AppBar(title: Text(_toolbarTitle)),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: _form(),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: _name,
            decoration: textInputDecoration.copyWith(labelText: 'Nazwa przepisu'),
            validator: (value) => value?.isEmpty == true ? "Musisz podać nazwę przepisu" : null,
            onChanged: (value) => setState(() => _name = value),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            initialValue: _url,
            decoration:
                textInputDecoration.copyWith(labelText: 'Link do przepis'),
            validator: (value) =>
                value?.isEmpty == true ? "Musisz podać link do przepisu" : null,
            onChanged: (value) => setState(() => _url = value),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
              onPressed: _onAcceptButtonClicked, child: Text('Zapisz'))
        ],
      ),
    );
  }

  void _onAcceptButtonClicked() {
    if (_isEdit) {
      _onEditButtonClicked();
      return;
    }

    _onAddButtonClicked();
  }

  void _onAddButtonClicked() async {
    if (_formKey.currentState?.validate() == true) {
      await RecipeService()
          .addRecipe(NewRecipe(name: _name, url: _url))
          .whenComplete(() => Navigator.pop(context, {'addRecipe': true}));
    }
  }

  void _onEditButtonClicked() async {
    if (_formKey.currentState?.validate() == true) {
      await RecipeService()
          .editRecipe(EditRecipe(id: _recipeId, name: _name, url: _url))
          .whenComplete(() => Navigator.pop(context, {'editRecipe': true}));
    }
  }
}
