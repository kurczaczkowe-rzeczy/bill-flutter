import 'package:paragony/model/unit.dart';

class ShoppingItem {
  int id;
  String createAt;
  num? quantity;
  Unit unit;
  String name;
  bool inCart;
  int categoryId;
  String categoryName;

  ShoppingItem({
    required this.id,
    required this.createAt,
    required this.quantity,
    required this.unit,
    required this.name,
    required this.inCart,
    required this.categoryId,
    required this.categoryName,
  });

  static ShoppingItem fromJson(Map<String, dynamic> json) {
    String unitName = json['unit'];
    Unit unit = Unit.getValue(unitName);

    return ShoppingItem(
        id: json['product_id'] as int,
        createAt: json['created_at'] as String,
        quantity: json['quantity'] as num?,
        unit: unit,
        name: json['product_name'] as String,
        inCart: json['in_cart'] as bool,
        categoryId: json['category_id'] as int,
        categoryName: json['category_name'] as String);
  }
}
