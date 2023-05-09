import 'package:json_annotation/json_annotation.dart';
import 'package:paragony/model/dto/product_suggestion_response.dart';

part 'product_suggestion_list_response.g.dart';

@JsonSerializable()
class ProductSuggestionListResponse {
  final List<ProductSuggestionResponse> result;

  ProductSuggestionListResponse(this.result);

  factory ProductSuggestionListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductSuggestionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSuggestionListResponseToJson(this);
}