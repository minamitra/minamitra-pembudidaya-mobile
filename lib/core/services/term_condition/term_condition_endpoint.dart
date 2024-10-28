import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class TermConditionEndpoint {
  TermConditionEndpoint();

  Uri termCondition(String key) {
    return createUrl(
      path: "public-access/config/detail",
      queryParameters: {
        "key": key,
      },
    );
  }
}
