import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';

class CycleEndpoint {
  CycleEndpoint();

  Uri getOngoingCycle({
    String status = "active",
    String? fishpondID,
    String? lastPondCycleID,
  }) {
    return createUrl(
      path: "mitra/fishpondcycle/data",
      queryParameters: {
        // "status": status,
        if (fishpondID != null) "fishpond_id": fishpondID,
        if (lastPondCycleID != null) "id": lastPondCycleID,
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

  Uri updateHarvestDone() {
    return createUrl(
      path: "mitra/fishpondcycle/update-panen-selesai",
    );
  }

  Uri getGraph({
    required String pondCycleID,
    required String filterName,
  }) {
    return createUrl(
      path: "mitra/fishpondcycle/data-grafik",
      queryParameters: {
        "fishpondcycle_id": pondCycleID,
        "filter": filterName,
      },
    );
  }

  Uri getCompanionNotes(
    String pondCycleID, {
    String? filterStartDate,
    String? filterEndDate,
    String? companionName,
  }) {
    return createUrl(
      path: "mitra/assistant-note/data",
      queryParameters: {
        "fishpondcycle_id": pondCycleID,
        "pagination_bool": "false",
        if (filterStartDate != null) "create_datetime[gte]": filterStartDate,
        if (filterEndDate != null) "create_datetime[lte]": filterEndDate,
        if (companionName != null) "user_name": companionName,
      },
    );
  }
}
