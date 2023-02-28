import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paragony/model/domain/model_category.dart';
import 'package:paragony/model/domain/new_product.dart';
import 'package:paragony/model/domain/unit.dart';
import 'package:paragony/services/db_service.dart';
import 'package:paragony/shared/category_indicator.dart';
import 'package:paragony/shared/loading.dart';
import 'package:paragony/shared/styles.dart';

class AddProductWidget extends StatefulWidget {
  final VoidCallback onAddSuccess;
  final int listId;

  const AddProductWidget(
      {Key? key, required this.onAddSuccess, required this.listId})
      : super(key: key);

  @override
  State<AddProductWidget> createState() =>
      _AddProductWidgetState(onAddSuccess, listId);
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final _formKey = GlobalKey<FormState>();
  final _categoriesList = DBService().getCategories();
  final VoidCallback callback;
  final int listId;

  _AddProductWidgetState(this.callback, this.listId);

  // form values
  String _name = '';
  double _amount = 0.0;
  Unit _unit = Unit.GRAM;
  Category? _category;

  void _onSaveButtonClicked() async {
    if (_formKey.currentState?.validate() == true) {
      await DBService()
          .createProduct(
          NewProduct(shoppingListId: listId,
              unit: _unit,
              productQuantity: _amount,
              productName: _name,
              categoryId: _category?.id ?? 1)
      ).whenComplete(() => callback());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                _category = _category ?? categories.first;
                return _addProductToList(categories);
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

  Widget _addProductToList(List<Category> categories) {
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
                    onChanged: (value) => setState(() => _category = value as Category),
                    decoration: textInputDecoration.copyWith(
                        labelText: 'Nazwa kategoria'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: _onSaveButtonClicked, child: Text('Zapisz'))
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
