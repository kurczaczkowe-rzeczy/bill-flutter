import 'dart:ui';

import 'package:paragony/shared/extentions.dart';

class Category{
  int id;
  String name;
  Color color;

  Category({this.id = -1, required this.name, required this.color});

  static Category fromJson(Map<String, dynamic> json) {
    String color = '#${json['color']}';

    return Category(
        id: json['id'] as int,
        name: json['name'] as String,
        color: color.toColor()
    );
  }
}