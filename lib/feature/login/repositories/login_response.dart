import 'dart:convert';

class LoginResponse {
  final UserData? data;
  final String? token;
  final int? expiredIn;

  LoginResponse({
    this.data,
    this.token,
    this.expiredIn,
  });

  factory LoginResponse.fromJson(String str) =>
      LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        data: json['data'] == null ? null : UserData.fromMap(json['data']),
        token: json['token'],
        expiredIn: json['expired_in'],
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
        'token': token,
        'expired_in': expiredIn,
      };
}

class UserData {
  final String? id;
  final String? name;
  final String? email;
  final String? mobilephone;
  final String? imageUrl;
  final String? type;
  final String? level;
  final int? totalPoin;
  final String? status;

  UserData({
    this.id,
    this.name,
    this.email,
    this.mobilephone,
    this.imageUrl,
    this.type,
    this.level,
    this.totalPoin,
    this.status,
  });

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        mobilephone: json['mobilephone'],
        imageUrl: json['image_url'],
        type: json['type'],
        level: json['level'],
        totalPoin: json['total_poin'],
        status:
            json['status'], // 'submission','processed','rejected','approved'
      );

  bool isSubmission() => status?.toLowerCase() == 'submission';
  bool isProcessed() => status?.toLowerCase() == 'processed';
  bool isRejected() => status?.toLowerCase() == 'rejected';
  bool isApproved() => status?.toLowerCase() == 'approved';

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'mobilephone': mobilephone,
        'image_url': imageUrl,
        'type': type,
        'level': level,
        'total_poin': totalPoin,
        'status': status,
      };
}
