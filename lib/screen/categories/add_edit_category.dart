import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:paragony/model/domain/edit_category.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/model/domain/new_category.dart';
import 'package:paragony/services/shopping_list_service.dart';
import 'package:paragony/shared/constants.dart';
import 'package:paragony/shared/extentions.dart';
import 'package:paragony/shared/styles.dart';

class AddEditCategoryWidget extends StatefulWidget {
  const AddEditCategoryWidget({Key? key}) : super(key: key);

  @override
  State<AddEditCategoryWidget> createState() => _AddEditCategoryWidgetState();
}

class _AddEditCategoryWidgetState extends State<AddEditCategoryWidget> {
  final _formKey = GlobalKey<FormState>();
  int _categoryId = -1;
  Category? _category;
  String _name = "";
  Color _color = "#ff0000".toColor();
  String _titleToolbar = 'Stwórz nową kategorię';
  bool _isEdit = false;

  final TextEditingController _colorTextController = TextEditingController();
  CircleColorPickerController _colorController = CircleColorPickerController();

  @override
  Widget build(BuildContext context) {
    String route = ModalRoute.of(context)?.settings.name ?? "";

    if (route == Routes.editCategory && _categoryId == -1) {
      Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
      Category category = arguments['category'] as Category;

      _category = category;
      _name = _category?.name ?? '';
      _categoryId = _category?.id ?? -1;
      _color = _category?.color ?? _color;
      _colorTextController.text = "#${_color.toValue()}";
      _titleToolbar = 'Edytuj kategorię';
      _isEdit = true;
      _colorController = CircleColorPickerController(initialColor: _color);
    }

    if (_colorTextController.text.isEmpty) {
      _colorTextController.text = '#${_color.toValue()}';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(_titleToolbar),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: _form(_onCreateButtonClicked, _onEditButtonClicked),
        ));
  }

  Widget _form(VoidCallback onCreateClicked, VoidCallback onEditClicked) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: _name,
              decoration:
                  textInputDecoration.copyWith(labelText: 'Nazwa kategorii'),
              validator: (value) => value?.isEmpty == true
                  ? 'Musisz podać nazwę kategorii'
                  : null,
              onChanged: (value) => setState(() => _name = value),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _colorTextController,
              decoration:
                  textInputDecoration.copyWith(labelText: 'Kolor kategorii'),
              readOnly: true,
            ),
            SizedBox(height: 16.0),
            CircleColorPicker(
              controller: _colorController,
              onChanged: (value) => setState(() {
                _colorTextController.text = "#${value.toValue()}";
                _color = value;
              }),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () {
                  if (_isEdit) {
                    onEditClicked();
                    return;
                  }

                  log('create?');
                  onCreateClicked();
                },
                child: Text('Zapisz'))
          ],
        ));
  }

  void _onCreateButtonClicked() async {
    if (_formKey.currentState?.validate() == true) {
      await DBService()
          .createCategory(NewCategory(name: _name, color: _color))
          .whenComplete(() => Navigator.pop(context, {'addComplete': true}));
    }
  }

  void _onEditButtonClicked() async {
    if (_formKey.currentState?.validate() == true) {
      await DBService()
          .editCategory(
              EditCategory(id: _categoryId, name: _name, color: _color))
          .whenComplete(() => Navigator.pop(context, {'editComplete': true}));
    }
  }
}
