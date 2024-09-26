import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class PondEndpoint {
  PondEndpoint();

  Uri addPond() {
    return createUrl(path: "mitra/fishpond/add");
  }

  Uri addPondCycle() {
    return createUrl(path: "mitra/fishpondcycle/add");
  }
}
