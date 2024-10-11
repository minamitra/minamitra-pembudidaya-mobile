import 'dart:convert';

class GraphResponse {
  GraphResponseData? data;

  GraphResponse({
    this.data,
  });

  factory GraphResponse.fromJson(String str) =>
      GraphResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GraphResponse.fromMap(Map<String, dynamic> json) => GraphResponse(
        data: json["data"] == null
            ? null
            : GraphResponseData.fromMap(json["data"]),
      );

  GraphResponse copyWith({
    GraphResponseData? data,
  }) =>
      GraphResponse(
        data: data ?? this.data,
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class GraphResponseData {
  String? filterName;
  List<GraphResponseDataItem>? data;
  List<GraphResponseDataItem>? tempData;

  GraphResponseData({
    this.filterName,
    this.data,
    this.tempData,
  });

  copyWith({
    String? filterName,
    List<GraphResponseDataItem>? data,
    List<GraphResponseDataItem>? tempData,
  }) {
    return GraphResponseData(
      filterName: filterName ?? this.filterName,
      data: data ?? this.data,
      tempData: tempData ?? this.tempData,
    );
  }

  factory GraphResponseData.fromJson(String str) =>
      GraphResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GraphResponseData.fromMap(Map<String, dynamic> json) =>
      GraphResponseData(
        filterName: json["filter_name"],
        data: json["data"] == null
            ? []
            : List<GraphResponseDataItem>.from(
                json["data"]!.map((x) => GraphResponseDataItem.fromMap(x))),
        tempData: List<GraphResponseDataItem>.from(
            json["data"]!.map((x) => GraphResponseDataItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "filter_name": filterName,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GraphResponseDataItem {
  int? doc;
  DateTime? date;
  double? target;
  double? actual;

  GraphResponseDataItem({
    this.doc,
    this.date,
    this.target,
    this.actual,
  });

  factory GraphResponseDataItem.fromJson(String str) =>
      GraphResponseDataItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GraphResponseDataItem.fromMap(Map<String, dynamic> json) =>
      GraphResponseDataItem(
        doc: int.tryParse(json["doc"].toString()) ?? 0,
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        target: double.tryParse(json["target"].toString()) ?? 0.0,
        actual: double.tryParse(json["actual"].toString()) ?? 0.0,
      );

  Map<String, dynamic> toMap() => {
        "doc": doc,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "target": target,
        "actual": actual,
      };
}
