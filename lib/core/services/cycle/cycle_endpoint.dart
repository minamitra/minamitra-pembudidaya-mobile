import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';

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

  Uri getFeedCycleHistory({
    required String pondID,
    required String status,
    String? firstDate,
    String? lastDate,
  }) {
    return createUrl(
      path: "mitra/fishpondcycle/data",
      queryParameters: {
        "fishpond_id": pondID,
        "status[eq]": status,
        "pagination_bool": "false",
        if (firstDate != null) "estimation_panen_date[gte]": firstDate,
        if (lastDate != null) "estimation_panen_date[lte]": lastDate,
      },
    );
  }

  Uri postHarvest() {
    return createUrl(path: "mitra/fishpondcycle/update-panen");
  }
}
