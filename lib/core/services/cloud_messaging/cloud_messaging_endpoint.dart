import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class CloudMessagingEndpoint {
  CloudMessagingEndpoint();

  Uri postSendToken() {
    return createUrl(
      path: 'mitra/profile/update-fcm-token',
    );
  }
}
