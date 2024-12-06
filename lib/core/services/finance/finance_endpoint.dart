import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class FinanceEndpoint {
  FinanceEndpoint();

  Uri getSummary(String fishPondID) {
    return createUrl(
      path: 'mitra/keuangan/summary',
      queryParameters: {
        'fishpond_id': fishPondID,
      },
    );
  }

  Uri getFinancePerCycle(
    String fishPondID, {
    String? fishPondCycleID,
  }) {
    return createUrl(
      path: 'mitra/keuangan/data-per-cycle',
      queryParameters: {
        'fishpond_id': fishPondID,
        if (fishPondCycleID != null) 'fishpondcycle_id': fishPondCycleID,
      },
    );
  }

  Uri getFisphPondCycleCost(String fishpondCycleID) {
    return createUrl(
      path: 'mitra/fishpondcycle-cost/data',
      queryParameters: {
        'fishpondcycle_id': fishpondCycleID,
      },
    );
  }

  Uri postAddOtherCost() {
    return createUrl(
      path: 'mitra/fishpondcycle-cost/add',
    );
  }

  Uri postUpdateOtherCost() {
    return createUrl(
      path: 'mitra/fishpondcycle-cost/update',
    );
  }

  Uri postDeleteCost() {
    return createUrl(
      path: 'mitra/fishpondcycle-cost/delete',
    );
  }
}
