import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class FeedActivityEndpoint {
  FeedActivityEndpoint();

  Uri getData(
    String fishPondCycleID,
    String dateTime,
  ) {
    return createUrl(
      path: "mitra/activity-feeding/data",
      queryParameters: {
        "fishpondcycle_id": fishPondCycleID,
        "datetime": dateTime,
      },
    );
  }

  Uri getRecommendation(
    String fishPondCycleID,
    String fishAge,
  ) {
    return createUrl(
      path: "mitra/activity-feeding/get-recommendation",
      queryParameters: {
        "fishpondcycle_id": fishPondCycleID,
        "fish_age": fishAge,
      },
    );
  }

  Uri getFishFeedByCycle(String fishPondCycleID) {
    return createUrl(
      path: "mitra/activity-feeding/data-fishfood",
      queryParameters: {"fishpondcycle_id": fishPondCycleID},
    );
  }

  Uri postFishFeed() {
    return createUrl(path: "mitra/activity-feeding/add");
  }

  Uri deleteFishActivity() {
    return createUrl(path: "mitra/activity-feeding/delete");
  }

  Uri getFeedRecommendationBulk(
    String fishpondIds,
    String date,
  ) {
    return createUrl(
      path: "mitra/activity-feeding/get-recommendation-bulk",
      queryParameters: {
        "fishpond_ids": fishpondIds,
        "date": date,
      },
    );
  }

  Uri postBulkFeed() {
    return createUrl(path: "mitra/activity-feeding/add-bulk");
  }
}
