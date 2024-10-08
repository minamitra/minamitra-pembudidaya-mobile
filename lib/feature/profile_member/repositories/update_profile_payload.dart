import 'dart:convert';

class UpdateProfilePayload {
  String? name;
  String? email;
  String? mobilephone;
  String? imageUrl;

  UpdateProfilePayload({
    this.name,
    this.email,
    this.mobilephone,
    this.imageUrl,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobilephone': mobilephone,
      'image_url': imageUrl,
    };
  }
}
