import 'package:json_annotation/json_annotation.dart';

import 'short_shopping_list_info_details_response.dart';

part 'short_shopping_list_info_response.g.dart';

@JsonSerializable()
class ShortShoppingListInfoResponse {
  final ShortShoppingListInfoDetailsResponse result;

  ShortShoppingListInfoResponse(this.result);

  factory ShortShoppingListInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ShortShoppingListInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShortShoppingListInfoResponseToJson(this);
}
