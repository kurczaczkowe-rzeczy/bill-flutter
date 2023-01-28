import 'dart:ui';

import 'package:paragony/shared/extentions.dart';

class Category{
  int id;
  DateTime createdAt;
  String name;
  Color color;

  Category({required this.id, required this.createdAt, required this.name, required this.color});

  static Category fromJson(Map<String, dynamic> json) {
    String color = '#${json['color']}';
    DateTime createdAt = DateTime.parse(json['created_at'] as String);

    return Category(
        id: json['id'] as int,
        createdAt: createdAt,
        name: json['name'] as String,
        color: color.toColor()
    );
  }
}