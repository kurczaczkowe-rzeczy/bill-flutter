import 'package:json_annotation/json_annotation.dart';

part 'short_shopping_list_info_details_response.g.dart';

@JsonSerializable()
class ShortShoppingListInfoDetailsResponse {
  int id;
  String name;
  DateTime createdAt;
  DateTime date;

  ShortShoppingListInfoDetailsResponse(
      this.id, this.date, this.name, this.createdAt);

  factory ShortShoppingListInfoDetailsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ShortShoppingListInfoDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ShortShoppingListInfoDetailsResponseToJson(this);
}
