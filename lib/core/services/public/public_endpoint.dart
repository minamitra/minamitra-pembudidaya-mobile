import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class PublicEndpoint {
  PublicEndpoint();

  Uri getFAQList() {
    return createUrl(
      path: 'public-access/faq/data',
      queryParameters: {
        'pagination_bool': 'false',
      },
    );
  }

  Uri getFAQDetail(String id) {
    return createUrl(
      path: 'public-access/faq/detail',
      queryParameters: {'id': id},
    );
  }

  Uri getPublicAccess(String key) {
    return createUrl(
      path: 'public-access/config/detail',
      queryParameters: {'key': key},
    );
  }

  Uri getWaterColor() {
    return createUrl(
      path: 'public-access/water-information/data-color',
      queryParameters: {
        'pagination_bool': 'false',
      },
    );
  }

  Uri getWaterWeather() {
    return createUrl(
      path: 'public-access/water-information/data-weather',
      queryParameters: {
        'pagination_bool': 'false',
      },
    );
  }
}
