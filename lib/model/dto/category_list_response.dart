import 'package:json_annotation/json_annotation.dart';
import 'package:paragony/model/dto/category_response.dart';

part 'category_list_response.g.dart';

@JsonSerializable()
class CategoryListResponse {
  final List<CategoryResponse> result;

  CategoryListResponse(this.result);

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListResponseToJson(this);
}