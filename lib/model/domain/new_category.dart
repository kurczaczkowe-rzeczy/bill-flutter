import 'dart:ui';

class NewCategory {
  String name;
  Color color;

  NewCategory({required this.name, required this.color});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color,
    };
  }
}
