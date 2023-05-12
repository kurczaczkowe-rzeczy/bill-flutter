class NewRecipe{
  final String name;
  final String url;

  NewRecipe({required this.name, required this.url});

  Map<String, dynamic> toJson() {
    return {
      'link': url,
      'name': name,
    };
  }
}