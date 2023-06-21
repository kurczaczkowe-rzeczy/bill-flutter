import 'package:paragony/model/domain/unit.dart';

class ProductSuggestion {
  int id;
  String name;
  Unit unit;

  ProductSuggestion({required this.id, required this.name, required this.unit});
}
