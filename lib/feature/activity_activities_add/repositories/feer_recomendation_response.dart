import 'dart:convert';

class FeedRecomendationResponse {
  FeedRecomendationResponseData? data;

  FeedRecomendationResponse({this.data});

  factory FeedRecomendationResponse.fromJson(String str) =>
      FeedRecomendationResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedRecomendationResponse.fromMap(Map<String, dynamic> json) =>
      FeedRecomendationResponse(
        data: json["data"] == null
            ? null
            : FeedRecomendationResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class FeedRecomendationResponseData {
  double? mbwByFishAge;
  double? suggestFeed;
  double? accumulationTotalFeedBefore;

  FeedRecomendationResponseData({
    this.mbwByFishAge,
    this.suggestFeed,
    this.accumulationTotalFeedBefore,
  });

  factory FeedRecomendationResponseData.fromJson(String str) =>
      FeedRecomendationResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedRecomendationResponseData.fromMap(Map<String, dynamic> json) =>
      FeedRecomendationResponseData(
        mbwByFishAge: json["mbw_by_fish_age"]?.toDouble(),
        suggestFeed: json["suggest_feed"]?.toDouble(),
        accumulationTotalFeedBefore:
            json["accumulation_total_feed_before"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "mbw_by_fish_age": mbwByFishAge,
        "suggest_feed": suggestFeed,
        "accumulation_total_feed_before": accumulationTotalFeedBefore,
      };
}
