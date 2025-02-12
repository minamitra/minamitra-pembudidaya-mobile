import 'dart:convert';
import 'dart:developer';

class MissionPointResponse {
  final MissionPointResponseData? data;

  MissionPointResponse({
    this.data,
  });

  factory MissionPointResponse.fromJson(String str) =>
      MissionPointResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MissionPointResponse.fromMap(Map<String, dynamic> json) =>
      MissionPointResponse(
        data: json['data'] == null
            ? null
            : MissionPointResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class MissionPointResponseData {
  final List<Mission>? dailyMission;
  final List<Mission>? limitedMission;

  MissionPointResponseData({
    this.dailyMission,
    this.limitedMission,
  });

  factory MissionPointResponseData.fromJson(String str) =>
      MissionPointResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MissionPointResponseData.fromMap(Map<String, dynamic> json) =>
      MissionPointResponseData(
        dailyMission: json['daily_mission'] == null
            ? []
            : List<Mission>.from(
                json['daily_mission']!.map((x) => Mission.fromMap(x)),
              ),
        limitedMission: json['limited_mission'] == null
            ? []
            : List<Mission>.from(
                json['limited_mission']!.map((x) => Mission.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        'daily_mission': dailyMission == null
            ? []
            : List<dynamic>.from(dailyMission!.map((x) => x.toMap())),
        'limited_mission': limitedMission == null
            ? []
            : List<dynamic>.from(limitedMission!.map((x) => x.toMap())),
      };
}

class Mission {
  final String? name;
  final int? poin;
  final String? progress;
  final String? status;
  final String? route;
  final int? pointStart;
  final int? pointEnd;

  Mission({
    this.name,
    this.poin,
    this.progress,
    this.status,
    this.route,
    this.pointStart,
    this.pointEnd,
  });

  factory Mission.fromJson(String str) => Mission.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mission.fromMap(Map<String, dynamic> json) {
    List<String> pointSplit = json['progress'].split('/');
    int pointStarts = int.parse(pointSplit[0].toString());
    int? pointEnds =
        pointSplit.length > 1 ? int.parse(pointSplit[1].toString()) : null;

    return Mission(
      name: json['name'],
      poin: json['poin'],
      progress: json['progress'],
      status: json['status'],
      route: json['route'],
      pointStart: pointStarts,
      pointEnd: pointEnds,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'poin': poin,
        'progress': progress,
        'status': status,
        'route': route,
      };
}
