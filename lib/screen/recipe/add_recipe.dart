import 'package:flutter/material.dart';
import 'package:paragony/model/domain/new_recipe.dart';
import 'package:paragony/services/db_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dodaj przepis")),
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
            decoration: textInputDecoration.copyWith(labelText: 'Link do przepis'),
            validator: (value) => value?.isEmpty == true ? "Musisz podać link do przepisu" : null,
            onChanged: (value) => setState(() => _url = value),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(onPressed: _onAddButtonClicked, child: Text('Zapisz'))
        ],
      ),
    );
  }

  void _onAddButtonClicked() async{
    if(_formKey.currentState?.validate() == true) {
      await DBService().addRecipe(NewRecipe(name: _name, url: _url))
          .whenComplete(() => _backWithSuccess());
    }
  }

  void _backWithSuccess() {
    Navigator.pop(context, {'addRecipe': true});
  }
}
