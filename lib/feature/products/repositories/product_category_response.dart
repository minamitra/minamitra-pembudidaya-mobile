import 'dart:convert';

class ProductCategoryResponse {
  final List<ProductCategoryData>? data;

  ProductCategoryResponse({
    this.data,
  });

  factory ProductCategoryResponse.fromJson(String str) =>
      ProductCategoryResponse.fromMap(json.decode(str));

  factory ProductCategoryResponse.fromMap(Map<String, dynamic> json) =>
      ProductCategoryResponse(
        data: json["data"] == null
            ? []
            : List<ProductCategoryData>.from(
                json["data"]!.map((x) => ProductCategoryData.fromMap(x))),
      );
}

class ProductCategoryData {
  String? id;
  String? parId;
  String? name;
  bool? activeBool;
  String? productCount;

  ProductCategoryData({
    this.id,
    this.parId,
    this.name,
    this.activeBool,
    this.productCount,
  });

  factory ProductCategoryData.fromJson(String str) =>
      ProductCategoryData.fromMap(json.decode(str));

  factory ProductCategoryData.fromMap(Map<String, dynamic> json) =>
      ProductCategoryData(
        id: json["id"],
        parId: json["par_id"],
        name: json["name"],
        activeBool: json["active_bool"],
        productCount: json["product_count"],
      );
}
