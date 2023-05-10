import 'package:json_annotation/json_annotation.dart';
import 'package:paragony/model/dto/recipe_link_item_response.dart';

part 'recipe_links_response.g.dart';

@JsonSerializable()
class RecipeLinksResponse {
  final List<RecipeLinkItemResponse> result;

  RecipeLinksResponse(this.result);

  factory RecipeLinksResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeLinksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeLinksResponseToJson(this);
}
