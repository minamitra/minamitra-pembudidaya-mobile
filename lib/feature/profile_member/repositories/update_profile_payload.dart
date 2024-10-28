import 'dart:convert';

class UpdateProfilePayload {
  String? nik;
  String? name;
  String? email;
  String? mobilephone;
  String? birthPlace;
  String? birthDate;
  String? gender;
  String? job;
  String? imageUrl;
  String? ktpUrl;
  String? ekusukaUrl;
  List<String>? otherAttachmentJsonArray;

  UpdateProfilePayload({
    this.nik,
    this.name,
    this.email,
    this.mobilephone,
    this.birthPlace,
    this.birthDate,
    this.gender,
    this.job,
    this.imageUrl,
    this.ktpUrl,
    this.ekusukaUrl,
    this.otherAttachmentJsonArray,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'name': name,
      'email': email,
      'mobilephone': mobilephone,
      'birth_place': birthPlace,
      'birth_date': birthDate,
      'gender': gender,
      'job': job,
      'image_url': imageUrl,
      'ktp_url': ktpUrl,
      'ekusuka_url': ekusukaUrl,
      'other_attachment_json_array': otherAttachmentJsonArray,
    };
  }
}
