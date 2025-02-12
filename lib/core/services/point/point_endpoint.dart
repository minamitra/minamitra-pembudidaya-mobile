import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class PointEndpoint {
  PointEndpoint();

  Uri getPointBalance() {
    return createUrl(
      path: 'mitra/poin/saldo',
    );
  }

  Uri getPointHistory(String? dateTime) {
    return createUrl(
      path: 'mitra/poin/saldo-history',
      queryParameters: {
        if (dateTime != null) 'datetime': dateTime,
        'pagination_bool': 'false',
      },
    );
  }

  Uri getPointConfiguration() {
    return createUrl(
      path: 'mitra/level-config/data',
    );
  }

  Uri postPointExchange() {
    return createUrl(
      path: 'mitra/poin-exchange/add',
    );
  }

  Uri getPointExchangeHistory(
    String? status,
    String type,
    String? createdDateTime,
  ) {
    return createUrl(
      path: 'mitra/poin-exchange/data',
      queryParameters: {
        if (status != null) 'status': status,
        'type': type,
        if (createdDateTime != null) 'create_datetime': createdDateTime,
        'pagination_bool': 'false',
      },
    );
  }

  Uri getPointMission() {
    return createUrl(
      path: 'mitra/poin-mission/detail',
    );
  }
}
