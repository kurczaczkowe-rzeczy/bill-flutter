import 'dart:ui';

import 'package:paragony/shared/extentions.dart';

class EditCategory {
  int id;
  String name;
  Color color;

  EditCategory({required this.id, required this.name, required this.color});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.toValue(),
    };
  }
}
