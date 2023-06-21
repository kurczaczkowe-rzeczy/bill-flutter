import 'package:json_annotation/json_annotation.dart';
import 'package:paragony/model/domain/unit.dart';

part 'product_suggestion_response.g.dart';

@JsonSerializable()
class ProductSuggestionResponse {
  final int id;
  final String name;
  final Unit unit;
  final DateTime createdAt;

  ProductSuggestionResponse(this.id, this.name, this.unit, this.createdAt);

  factory ProductSuggestionResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductSuggestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSuggestionResponseToJson(this);
}
