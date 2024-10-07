import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class CdnEndpoint {
  CdnEndpoint();

  Uri imageEndpoint() {
    return createUrl(
      customBaseURL: "cdn.mitra3m.id",
      path: "image.php",
    );
  }

  Uri fileEndpoint() {
    return createUrl(
      customBaseURL: "cdn.mitra3m.id",
      path: "file.php",
    );
  }
}
