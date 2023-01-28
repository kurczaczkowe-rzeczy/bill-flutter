class ShoppingListsItem {
  int id;
  DateTime createAt;
  DateTime date;
  String name;
  int productsAmount;

  ShoppingListsItem({
    required this.id,
    required this.createAt,
    required this.date,
    required this.name,
    required this.productsAmount,
});

  static ShoppingListsItem fromJson(Map<String, dynamic> json) {
    DateTime createAt = DateTime.parse(json['created_at'] as String);
    DateTime date = DateTime.parse(json['date'] as String);

    return ShoppingListsItem(
        id: json['id'] as int,
        createAt: createAt,
        date: date,
        name: json['name'] as String,
        productsAmount: json['products_amount'] as int
    );
  }
}
