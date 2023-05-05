import 'package:json_annotation/json_annotation.dart';

part 'product_suggestion_response.g.dart';

@JsonSerializable()
class ProductSuggestionResponse {
  final int id;
  final String name;
  final String color;
  final DateTime createdAt;

  ProductSuggestionResponse(this.id, this.name, this.color, this.createdAt);

  factory ProductSuggestionResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductSuggestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSuggestionResponseToJson(this);
}