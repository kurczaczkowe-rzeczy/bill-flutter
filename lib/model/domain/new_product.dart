import 'package:paragony/model/domain/unit.dart';

class NewProduct {
  int shoppingListId;
  Unit unit;
  num productQuantity;
  String productName;
  int categoryId;

  NewProduct({
    required this.shoppingListId,
    required this.unit,
    required this.productQuantity,
    required this.productName,
    required this.categoryId,
  });

  Map<String, dynamic> toJson(){
    return {
      'shopping_list_id': shoppingListId,
      'product_unit': unit.name,
      'product_quantity': productQuantity,
      'product_name': productName,
      'category_id': categoryId,
    };
  }
}
