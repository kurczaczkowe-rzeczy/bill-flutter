import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paragony/model/shopping_list.dart';
import 'package:paragony/services/db_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await _initEnv();
  await _initDBClient();

  runApp(const MyApp());
}

Future _initEnv() {
  return dotenv.load(fileName: "assets/.env");
}

Future _initDBClient() {
  return Supabase.initialize(
    url: dotenv.env['BASE_URL'] ?? '',
    anonKey: dotenv.env['API_KEY'] ?? '',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: TextButton(
            child: Text('click'),
            onPressed: () async {
              await DBService().getCategories();
              await DBService().getShoppingList(1);
            },
          ),
        ),
      ),
    );
  }
}
