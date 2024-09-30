import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class ActivityWaterQualityEndpoint {
  ActivityWaterQualityEndpoint();

  Uri dataWaterQuality(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) {
    return createUrl(
      path: "mitra/activity-water-quality/data",
      queryParameters: {
        "fishpond_id": fishpondId.toString(),
        "fishpondcycle_id": fishpondcycleId.toString(),
        "datetime": datetime,
      },
    );
  }

  Uri detailWaterQuality(String id) {
    return createUrl(
      path: "mitra/activity-water-quality/detail",
      queryParameters: {
        "id": id,
      },
    );
  }

  Uri addWaterQuality() {
    return createUrl(path: "mitra/activity-water-quality/add");
  }

  Uri deleteWaterQuality() {
    return createUrl(path: "mitra/activity-water-quality/add");
  }
}
