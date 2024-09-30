import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class ActivityTreatmentEndpoint {
  ActivityTreatmentEndpoint();

  Uri dataTreatment(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) {
    return createUrl(
      path: "mitra/activity-treatment/data",
      queryParameters: {
        "fishpond_id": fishpondId.toString(),
        "fishpondcycle_id": fishpondcycleId.toString(),
        "datetime": datetime,
      },
    );
  }

  Uri detailTreatment(String id) {
    return createUrl(
      path: "mitra/activity-treatment/detail",
      queryParameters: {
        "id": id,
      },
    );
  }

  Uri addTreatment() {
    return createUrl(path: "mitra/activity-treatment/add");
  }

  Uri deleteTreatment() {
    return createUrl(path: "mitra/activity-treatment/delete");
  }

  Uri updateTreatment() {
    return createUrl(path: "mitra/activity-treatment/update");
  }
}
