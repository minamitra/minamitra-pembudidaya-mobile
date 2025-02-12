import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class PlafonDistributionEndpoint {
  PlafonDistributionEndpoint();

  Uri getSummary() {
    return createUrl(path: 'mitra/plafon-distribution/summary');
  }

  Uri getData() {
    return createUrl(
      path: 'mitra/plafon-distribution/data',
      queryParameters: {
        'pagination_bool': 'fasle',
      },
    );
  }

  Uri getDetailSummaryUse(String fishpondID) {
    return createUrl(
      path: 'mitra/plafon-distribution/detail-summary',
      queryParameters: {
        'fishpond_id': fishpondID,
      },
    );
  }

  Uri getDetailFeedUse(String fishpondID) {
    return createUrl(
      path: 'mitra/plafon-distribution/detail-data-fishfood',
      queryParameters: {
        'fishpond_id': fishpondID,
      },
    );
  }

  Uri getDetailTreatmentUse(String fishpondID) {
    return createUrl(
      path: 'mitra/plafon-distribution/detail-data-treatment',
      queryParameters: {
        'fishpond_id': fishpondID,
      },
    );
  }

  Uri getDetailSeedUse(String fishpondID) {
    return createUrl(
      path: 'mitra/plafon-distribution/detail-data-fishseed',
      queryParameters: {
        'fishpond_id': fishpondID,
      },
    );
  }

  Uri getDetailAnotherUse(String fishpondID) {
    return createUrl(
      path: 'mitra/plafon-distribution/detail-data-other',
      queryParameters: {
        'fishpond_id': fishpondID,
      },
    );
  }
}
