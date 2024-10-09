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

  Uri getSeed() {
    return createUrl(
      path: "mitra/fishseed/data",
    );
  }

  Uri postNewSeed() {
    return createUrl(
      path: "mitra/fishseed/add-kiloan",
    );
  }
}
