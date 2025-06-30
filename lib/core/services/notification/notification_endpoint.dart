import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class NotificationEndpoint {
  NotificationEndpoint();

  Uri getNotificationList() {
    return createUrl(
      path: 'mitra/notification/data',
    );
  }

  Uri getReadNotification(String id) {
    return createUrl(
      path: 'mitra/notification/detail',
      queryParameters: {
        'id': id,
      },
    );
  }
}
