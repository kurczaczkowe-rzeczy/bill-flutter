class EditRecipe {
  final int id;
  final String name;
  final String url;

  EditRecipe({required this.id, required this.name, required this.url});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'link': url,
    };
  }
}
