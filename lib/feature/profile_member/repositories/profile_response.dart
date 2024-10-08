import 'dart:convert';

class ProfileResponse {
  final ProfileResponseData? data;

  ProfileResponse({
    this.data,
  });

  factory ProfileResponse.fromJson(String str) =>
      ProfileResponse.fromMap(json.decode(str));

  factory ProfileResponse.fromMap(Map<String, dynamic> json) => ProfileResponse(
        data: json["data"] == null
            ? null
            : ProfileResponseData.fromMap(json["data"]),
      );
}

class ProfileResponseData {
  String? id;
  String? name;
  String? email;
  String? mobilephone;
  String? imageUrl;

  ProfileResponseData({
    this.id,
    this.name,
    this.email,
    this.mobilephone,
    this.imageUrl,
  });

  factory ProfileResponseData.fromJson(String str) =>
      ProfileResponseData.fromMap(json.decode(str));

  factory ProfileResponseData.fromMap(Map<String, dynamic> json) =>
      ProfileResponseData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobilephone: json["mobilephone"],
        imageUrl: json["image_url"],
      );
}
