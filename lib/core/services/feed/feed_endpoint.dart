import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class FeedEndpoint {
  FeedEndpoint();

  Uri getFeed(String type) {
    return createUrl(
      path: "mitra/fishfood/data",
      queryParameters: {
        "type": type,
      },
    );
  }
}
