import 'dart:ui';

import 'package:paragony/shared/extentions.dart';

class Category{
  int id;
  String createdAt;
  String name;
  Color color;

  Category({required this.id, required this.createdAt, required this.name, required this.color});

  static Category fromJson(Map<String, dynamic> json) {
    String color = '#${json['color']}';

    return Category(
        id: json['id'] as int,
        createdAt: json['created_at'] as String,
        name: json['name'] as String,
        color: color.toColor()
    );
  }
}