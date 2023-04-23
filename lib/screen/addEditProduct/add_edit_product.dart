import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/model/domain/new_product.dart';
import 'package:paragony/model/domain/shopping_item.dart';
import 'package:paragony/model/domain/unit.dart';
import 'package:paragony/services/db_service.dart';
import 'package:paragony/shared/category_indicator.dart';
import 'package:paragony/shared/loading.dart';
import 'package:paragony/shared/styles.dart';

class AddEditProductWidget extends StatefulWidget {
  const AddEditProductWidget({Key? key}) : super(key: key);

  @override
  State<AddEditProductWidget> createState() => _AddEditProductWidgetState();
}

class _AddEditProductWidgetState extends State<AddEditProductWidget> {
  final _formKey = GlobalKey<FormState>();
  final _categoriesList = DBService().getCategories();
  int _listId = -1;
  bool _isEdit = false;

  _AddEditProductWidgetState();

  String _toolbarTitle = 'Dodaj nowy produkt';

  // form values
  String _name = '';
  double _amount = 0.0;
  Unit _unit = Unit.GRAM;
  Category? _category;

  void _onAcceptanceButtonClicked() {
    if (_isEdit) {
      _onEditButtonClicked();
    } else {
      _onAddButtonClicked();
    }
  }

  void _onAddButtonClicked() async {
    if (_formKey.currentState?.validate() == true) {
      await DBService().createProduct(NewProduct(
          shoppingListId: _listId,
          unit: _unit,
          productQuantity: _amount,
          productName: _name,
          categoryId: _category?.id ?? 1))
      .whenComplete(() => _backWithSuccess());
    }
  }

  void _onEditButtonClicked() async {
    if (_formKey.currentState?.validate() == true) {
      await DBService().createProduct(NewProduct(
          shoppingListId: _listId,
          unit: _unit,
          productQuantity: _amount,
          productName: _name,
          categoryId: _category?.id ?? 1))
      .whenComplete(() => _backWithSuccess());
    }
  }

  void _backWithSuccess(){
    Navigator.pop(context, {'addEditProduct': true});
  }

  @override
  Widget build(BuildContext context) {
    if (_listId == -1) {
      Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
      _listId = arguments['listId'] as int;
      ShoppingItem? item = arguments['product'] as ShoppingItem?;
      Category? category = arguments['category'] as Category?;

      log('category selected on init: ${category?.name}');

      _isEdit = item != null;
      _name = item?.name ?? _name;
      _amount = item?.quantity as double? ?? _amount;
      _unit = item?.unit ?? _unit;
      _category = category;
    }
    if (_isEdit) {
      _toolbarTitle = 'Edytuj produkt';
    }

    return FutureBuilder(
        initialData: [],
        future: _categoriesList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _showError();
          }
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                List<Category> categories = snapshot.data as List<Category>;
                log('category after fetch is null? ${_category == null}');
                _category = _category ?? categories.first;
                return Scaffold(
                    appBar: AppBar(
                      title: Text(_toolbarTitle),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: _formProduct(categories, _onAcceptanceButtonClicked),
                    ));
              }
            default:
              {
                return Loading();
              }
          }
        });
  }

  Widget _showError() {
    return Text('Nie można pobrać danych', style: TextStyle(color: Colors.red));
  }

  Widget _formProduct(
    List<Category> categories,
    VoidCallback onAcceptButtonClicked,
  ) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: _name,
              decoration:
                  textInputDecoration.copyWith(labelText: 'Nazwa produktu'),
              validator: (value) =>
                  value?.isEmpty == true ? 'Musisz podać nazwę produktu' : null,
              onChanged: (value) => setState(() => _name = value),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  initialValue: _amount.toString(),
                  decoration:
                      textInputDecoration.copyWith(labelText: 'Ilość produktu'),
                  validator: (value) => value?.isEmpty == true ||
                          double.tryParse(value ?? '') == null
                      ? 'Musisz wpisać liczbę odzielając ją znakime kropki'
                      : null,
                  onChanged: (value) =>
                      setState(() => _amount = double.tryParse(value) ?? 0.0),
                )),
                SizedBox(width: 16.0),
                SizedBox(
                  width: 100.0,
                  child: DropdownButtonFormField(
                    decoration:
                        textInputDecoration.copyWith(labelText: 'Jednostka'),
                    value: _unit,
                    items: _getUnitList(),
                    onChanged: (value) => setState(() => _unit = value as Unit),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                CategoryIndicator(
                  color: _category?.color ?? Colors.transparent,
                  size: 24.0,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: DropdownButtonFormField(
                    value: _category,
                    items: _getCategoryList(categories),
                    onChanged: (value) =>
                        setState(() => _category = value as Category?),
                    decoration: textInputDecoration.copyWith(
                        labelText: 'Nazwa kategoria'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: onAcceptButtonClicked, child: Text('Zapisz'))
          ],
        ));
  }

  List<DropdownMenuItem<Unit>> _getUnitList() {
    return Unit.values
        .map((e) => DropdownMenuItem(child: Text(e.shortName), value: e))
        .toList();
  }

  List<DropdownMenuItem<Category>> _getCategoryList(List<Category> categories) {
    return categories
        .map((e) => DropdownMenuItem(child: Text(e.name), value: e))
        .toList();
  }
}
