class EditList {
  int listId;
  String name;
  DateTime date;

  EditList({required this.listId, required this.name, required this.date});

  Map<String, dynamic> toJson() {
    return {
      'id': listId,
      'name': name,
      'date': date.toIso8601String(),
    };
  }
}
