import 'package:json_annotation/json_annotation.dart';

part 'recipe_link_item_response.g.dart';

@JsonSerializable()
class RecipeLinkItemResponse {
  final int id;
  final String name;
  final String link;

  RecipeLinkItemResponse(this.id, this.name, this.link);

  factory RecipeLinkItemResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeLinkItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeLinkItemResponseToJson(this);
}
