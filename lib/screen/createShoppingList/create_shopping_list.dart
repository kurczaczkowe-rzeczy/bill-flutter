import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paragony/services/db_service.dart';

class CreateShoppingList extends StatefulWidget {
  const CreateShoppingList({Key? key}) : super(key: key);

  @override
  State<CreateShoppingList> createState() => _CreateShoppingListState();
}

class _CreateShoppingListState extends State<CreateShoppingList> {
  final _formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  TextEditingController dateController = TextEditingController();
  String _listName = '';

  void _onSaveButtonClicked() async {
    Navigator.pop(context, {'addListComplete': true});
    if (_formKey.currentState?.validate() == true) {
      await DBService()
          .createShoppingList(_listName, dateFormat.parse(dateController.text))
          .whenComplete(() => Navigator.pop(context, {'addListComplete': true}));
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj nową listę zakupów'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _listName,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                  labelText: 'Nazwa listy',
                ),
                validator: (value) =>
                    value?.isEmpty == true ? 'Musisz podać nazwę listy' : null,
                onChanged: (value) => setState(() => _listName = value),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                  labelText: 'Data ważności listy',
                  hintText: 'dd-MM-yyyy',
                ),
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
