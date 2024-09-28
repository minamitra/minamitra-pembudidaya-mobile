import 'dart:convert';

class CDNImageResponse {
  final CDNImageResponseData? data;

  CDNImageResponse({
    this.data,
  });

  factory CDNImageResponse.fromJson(String str) =>
      CDNImageResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CDNImageResponse.fromMap(Map<String, dynamic> json) =>
      CDNImageResponse(
        data: CDNImageResponseData.fromMap(json),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class CDNImageResponseData {
  final String? type;
  final String? filename;
  final String? filepath;
  final String? filemime;
  final String? fullpath;
  final String? fileuri;

  CDNImageResponseData({
    this.type,
    this.filename,
    this.filepath,
    this.filemime,
    this.fullpath,
    this.fileuri,
  });

  factory CDNImageResponseData.fromJson(String str) =>
      CDNImageResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CDNImageResponseData.fromMap(Map<String, dynamic> json) =>
      CDNImageResponseData(
        type: json["type"],
        filename: json["filename"],
        filepath: json["filepath"],
        filemime: json["filemime"],
        fullpath: json["fullpath"],
        fileuri: json["fileuri"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "filename": filename,
        "filepath": filepath,
        "filemime": filemime,
        "fullpath": fullpath,
        "fileuri": fileuri,
      };
}
