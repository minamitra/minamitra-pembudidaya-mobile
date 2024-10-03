import 'dart:convert';

class ProductsResponse {
  final List<ProductsResponseData>? data;

  ProductsResponse({
    this.data,
  });

  factory ProductsResponse.fromJson(String str) =>
      ProductsResponse.fromMap(json.decode(str));

  factory ProductsResponse.fromMap(Map<String, dynamic> json) =>
      ProductsResponse(
        data: json["data"] == null
            ? []
            : List<ProductsResponseData>.from(
                json["data"]!.map((x) => ProductsResponseData.fromMap(x))),
      );
}

class ProductsResponseData {
  String? id;
  String? code;
  String? name;
  String? categoryId;
  String? itemCategoryParId;
  String? categoryName;
  String? unitId;
  String? unitName;
  String? sellPrice;
  String? buyPrice;
  String? stock;
  String? supplierId;
  String? supplierName;
  String? proteinPercent;
  String? lemakPercent;
  String? seratKasarPercent;
  String? kadarAbuPercent;
  String? kadarAirPercent;
  String? note;
  String? imageUrl;
  bool? activeBool;

  ProductsResponseData({
    this.id,
    this.code,
    this.name,
    this.categoryId,
    this.itemCategoryParId,
    this.categoryName,
    this.unitId,
    this.unitName,
    this.sellPrice,
    this.buyPrice,
    this.stock,
    this.supplierId,
    this.supplierName,
    this.proteinPercent,
    this.lemakPercent,
    this.seratKasarPercent,
    this.kadarAbuPercent,
    this.kadarAirPercent,
    this.note,
    this.imageUrl,
    this.activeBool,
  });

  factory ProductsResponseData.fromJson(String str) =>
      ProductsResponseData.fromMap(json.decode(str));

  factory ProductsResponseData.fromMap(Map<String, dynamic> json) =>
      ProductsResponseData(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        categoryId: json["category_id"],
        itemCategoryParId: json["item_category_par_id"],
        categoryName: json["category_name"],
        unitId: json["unit_id"],
        unitName: json["unit_name"],
        sellPrice: json["sell_price"],
        buyPrice: json["buy_price"],
        stock: json["stock"],
        supplierId: json["supplier_id"],
        supplierName: json["supplier_name"],
        proteinPercent: json["protein_percent"],
        lemakPercent: json["lemak_percent"],
        seratKasarPercent: json["serat_kasar_percent"],
        kadarAbuPercent: json["kadar_abu_percent"],
        kadarAirPercent: json["kadar_air_percent"],
        note: json["note"],
        imageUrl: json["image_url"],
        activeBool: json["active_bool"],
      );
}
