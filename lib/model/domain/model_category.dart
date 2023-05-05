import 'dart:ui';

class Category{
  int id;
  String name;
  Color color;

  Category({required this.id, required this.name, required this.color});

  bool operator ==(dynamic other) =>
      other != null && other is Category && this.id == other.id && this.name == other.name && this.color == other.color;

  @override
  int get hashCode => super.hashCode;
}