import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paragony/model/domain/edit_list.dart';
import 'package:paragony/model/domain/shopping_lists_item.dart';
import 'package:paragony/services/db_service.dart';
import 'package:paragony/shared/styles.dart';

class CreateShoppingListWidget extends StatefulWidget {
  const CreateShoppingListWidget({Key? key}) : super(key: key);

  @override
  State<CreateShoppingListWidget> createState() =>
      _CreateShoppingListWidgetState();
}

class _CreateShoppingListWidgetState extends State<CreateShoppingListWidget> {
  final _formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  bool _isEdit = false;
  int _listId = -1;
  String _toolbarTitle = 'Dodaj nową listę zakupów';

  TextEditingController dateController = TextEditingController();
  String _listName = '';

  void _onSaveButtonClicked() async {
    if (_formKey.currentState?.validate() == true) {
      if (_isEdit) {
        await DBService()
            .editList(EditList(
                listId: _listId,
                name: _listName,
                date: dateFormat.parse(dateController.text)))
            .whenComplete(
                () => Navigator.pop(context, {'editListComplete': true}));
        return;
      }

      await DBService()
          .createShoppingList(_listName, dateFormat.parse(dateController.text))
          .whenComplete(
              () => Navigator.pop(context, {'addListComplete': true}));
    }
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      setState(() => dateController.text = dateFormat.format(pickedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    Map? arguments = ModalRoute.of(context)?.settings?.arguments as Map?;
    _listId = arguments?['listId'] as int? ?? _listId;
    _isEdit = _listId != -1;

    if (_isEdit && arguments != null) {
      _toolbarTitle = 'Edytuj listę zakupów';
      ShoppingListsItem item = arguments['list'] as ShoppingListsItem;
      _listName = _listName.isEmpty ? item.name : _listName;
      dateController.text = dateController.text.isEmpty
          ? dateFormat.format(item.date)
          : dateController.text;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_toolbarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _listName,
                decoration:
                    textInputDecoration.copyWith(labelText: 'Nazwa listy'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Musisz podać nazwę listy' : null,
                onChanged: (value) => setState(() => _listName = value),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: dateController,
                decoration: textInputDecoration.copyWith(
                    labelText: 'Data ważności listy', hintText: 'dd-MM-yyyy'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Musisz podać datę' : null,
                onTap: _showDatePicker,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  onPressed: _onSaveButtonClicked,
                  child: Text('Zapisz'))
            ],
          ),
        ),
      ),
    );
  }
}
