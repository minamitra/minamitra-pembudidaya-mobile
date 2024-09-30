import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class CycleEndpoint {
  CycleEndpoint();

  Uri getOngoingCycle({
    String status = "active",
    String? fishpondID,
  }) {
    return createUrl(
      path: "mitra/fishpondcycle/data",
      queryParameters: {
        // "status": status,
        if (fishpondID != null) "fishpond_id": fishpondID,
      },
    );
  }
}
