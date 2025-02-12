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
        data: json['data'] == null
            ? []
            : List<ProductsResponseData>.from(
                json['data']!.map((x) => ProductsResponseData.fromMap(x)),
              ),
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
  int? quantity;
  String? supplierImageUrl;

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
    this.quantity = 1,
    this.supplierImageUrl,
  });

  factory ProductsResponseData.fromJson(String str) =>
      ProductsResponseData.fromMap(json.decode(str));

  factory ProductsResponseData.fromMap(Map<String, dynamic> json) =>
      ProductsResponseData(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        categoryId: json['category_id'],
        itemCategoryParId: json['item_category_par_id'],
        categoryName: json['category_name'],
        unitId: json['unit_id'],
        unitName: json['unit_name'],
        sellPrice: json['sell_price'],
        buyPrice: json['buy_price'],
        stock: json['stock'],
        supplierId: json['supplier_id'],
        supplierName: json['supplier_name'],
        proteinPercent: json['protein_percent'],
        lemakPercent: json['lemak_percent'],
        seratKasarPercent: json['serat_kasar_percent'],
        kadarAbuPercent: json['kadar_abu_percent'],
        kadarAirPercent: json['kadar_air_percent'],
        note: json['note'],
        imageUrl: json['image_url'],
        activeBool: json['active_bool'],
        supplierImageUrl: json['supplier_image_url'],
      );

  ProductsResponseData copyWith({
    String? id,
    String? code,
    String? name,
    String? categoryId,
    String? itemCategoryParId,
    String? categoryName,
    String? unitId,
    String? unitName,
    String? sellPrice,
    String? buyPrice,
    String? stock,
    String? supplierId,
    String? supplierName,
    String? proteinPercent,
    String? lemakPercent,
    String? seratKasarPercent,
    String? kadarAbuPercent,
    String? kadarAirPercent,
    String? note,
    String? imageUrl,
    bool? activeBool,
    int? quantity,
  }) {
    return ProductsResponseData(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      itemCategoryParId: itemCategoryParId ?? this.itemCategoryParId,
      categoryName: categoryName ?? this.categoryName,
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
      sellPrice: sellPrice ?? this.sellPrice,
      buyPrice: buyPrice ?? this.buyPrice,
      stock: stock ?? this.stock,
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
      proteinPercent: proteinPercent ?? this.proteinPercent,
      lemakPercent: lemakPercent ?? this.lemakPercent,
      seratKasarPercent: seratKasarPercent ?? this.seratKasarPercent,
      kadarAbuPercent: kadarAbuPercent ?? this.kadarAbuPercent,
      kadarAirPercent: kadarAirPercent ?? this.kadarAirPercent,
      note: note ?? this.note,
      imageUrl: imageUrl ?? this.imageUrl,
      activeBool: activeBool ?? this.activeBool,
      quantity: quantity ?? this.quantity,
    );
  }
}
