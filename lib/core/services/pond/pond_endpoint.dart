import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class PondEndpoint {
  PondEndpoint();

  Uri addPond() {
    return createUrl(path: "mitra/fishpond/add");
  }

  Uri addPondCycle() {
    return createUrl(path: "mitra/fishpondcycle/add");
  }

  Uri updatePond() {
    return createUrl(path: "mitra/fishpond/update");
  }

  Uri getPond() {
    return createUrl(
      path: "mitra/fishpond/data",
      queryParameters: {
        "pagination_bool": "false",
      },
    );
  }

  Uri getPondDashboard(String? pondID) {
    return createUrl(
      path: "mitra/dashboard/farming",
      queryParameters: {if (pondID != null) "fishpond_id": pondID},
    );
  }

  Uri deletePond() {
    return createUrl(path: "mitra/fishpond/delete");
  }
}
