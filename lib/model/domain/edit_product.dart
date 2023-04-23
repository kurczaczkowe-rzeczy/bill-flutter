import 'package:paragony/model/domain/unit.dart';

class EditProduct {
  int productId;
  int shoppingListId;
  int categoryId;
  String productName;
  num productQuantity;
  Unit unit;

  EditProduct({
    required this.productId,
    required this.shoppingListId,
    required this.categoryId,
    required this.productName,
    required this.productQuantity,
    required this.unit,
  });

  Map<String, dynamic> toJson(){
    return {
      'id': productId,
      'shopping_list_id': shoppingListId,
      'category_id': categoryId,
      'name': productName,
      'quantity': productQuantity,
      'unit': unit.name
    };
  }
}