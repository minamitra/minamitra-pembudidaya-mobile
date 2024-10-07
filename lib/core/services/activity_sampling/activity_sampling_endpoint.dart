import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class ActivitySamplingEndpoint {
  ActivitySamplingEndpoint();

  Uri dataSampling(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) {
    return createUrl(
      path: "mitra/activity-sampling/data",
      queryParameters: {
        "fishpond_id": fishpondId.toString(),
        "fishpondcycle_id": fishpondcycleId.toString(),
        "datetime": datetime,
      },
    );
  }

  Uri detailSampling(String id) {
    return createUrl(
      path: "mitra/activity-sampling/detail",
      queryParameters: {
        "id": id,
      },
    );
  }

  Uri addSampling() {
    return createUrl(path: "mitra/activity-sampling/add");
  }

  Uri deleteSampling() {
    return createUrl(path: "mitra/activity-sampling/delete");
  }

  Uri updateSampling() {
    return createUrl(path: "mitra/activity-sampling/update");
  }
}
