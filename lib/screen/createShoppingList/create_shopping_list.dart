import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paragony/model/domain/edit_list.dart';
import 'package:paragony/model/domain/shopping_lists_item.dart';
import 'package:paragony/services/shopping_list_service.dart';
import 'package:paragony/shared/loading.dart';
import 'package:paragony/shared/styles.dart';

class ModifyShoppingListWidget extends StatefulWidget {
  final int? listId;

  const ModifyShoppingListWidget({Key? key, this.listId}) : super(key: key);

  @override
  State<ModifyShoppingListWidget> createState() =>
      _ModifyShoppingListWidgetState();
}

class _ModifyShoppingListWidgetState extends State<ModifyShoppingListWidget> {
  final _formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  bool _isEdit = false;
  late int _listId;
  String _toolbarTitle = 'Dodaj nową listę zakupów';

  TextEditingController dateController = TextEditingController();
  String _listName = '';

  bool _isLoader = false;

  @override
  void initState() {
    super.initState();

    int? listId = widget.listId;

    if (listId != null) {
      _isLoader = true;
      _isEdit = true;
      _listId = listId;
      _toolbarTitle = 'Edytuj listę zakupów';

      DBService().getShoppingListInfo(listId).then((list) {
        setState(() {
          _isLoader = false;

          _listName = list.name;
          dateController.text = dateController.text.isEmpty
              ? dateFormat.format(list.date)
              : dateController.text;
        });
      });
    }
  }

  void _onSaveButtonClicked() async {
    if (_formKey.currentState?.validate() == true) {
      if (_isEdit) {
        _onEditClicked();
        return;
      }

      _onAddClicked();
    }
  }

  void _onAddClicked() {
    DBService()
        .createShoppingList(_listName, dateFormat.parse(dateController.text))
        .whenComplete(() => Navigator.pop(context));
  }

  void _onEditClicked() {
    DBService()
        .editList(EditList(
            listId: _listId,
            name: _listName,
            date: dateFormat.parse(dateController.text)))
        .whenComplete(() => Navigator.pop(context));
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
    if (_isLoader) {
      return Loading();
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
