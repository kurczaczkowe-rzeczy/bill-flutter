class ShoppingListsItem {
  int id;
  String createAt;
  String date;
  String name;
  int productsAmount;

  ShoppingListsItem({
    required this.id,
    required this.createAt,
    required this.date,
    required this.name,
    required this.productsAmount,
});

  static ShoppingListsItem fromJson(Map<String, dynamic> json) =>
      ShoppingListsItem(
          id: json['id'] as int,
          createAt: json['created_at'] as String,
          date: json['date'] as String,
          name: json['name'] as String,
          productsAmount: json['products_amount'] as int
      );
}
