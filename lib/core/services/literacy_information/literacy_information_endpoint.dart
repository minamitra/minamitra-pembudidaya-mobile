import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class LiteracyInformationEndpoint {
  LiteracyInformationEndpoint();

  Uri getLiteracyInformations({
    String page = '1',
    String limit = '7',
  }) {
    return createUrl(
      path: 'public-access/literacy/data',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );
  }

  Uri getLiteracyInformationDetail(String id) {
    return createUrl(
      path: 'public-access/literacy/detail',
      queryParameters: {'id': id},
    );
  }
}
