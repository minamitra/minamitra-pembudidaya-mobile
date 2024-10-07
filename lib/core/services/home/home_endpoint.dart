import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class HomeEndpoint {
  HomeEndpoint();

  Uri getHomeBanner() {
    return createUrl(
      path: "mitra/home-banner/data",
    );
  }
}
