import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/notification/notification_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification/repositories/notification_list_response.dart';

abstract class NotificationService {
  Future<BaseResponse<NotificationListResponse>> notificationList();
  Future<BaseResponse<NotificationListResponseData>> readNotification(
      String id);
}

class NotificationServiceImpl implements NotificationService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final NotificationEndpoint endpoint;

  NotificationServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory NotificationServiceImpl.create() {
    return NotificationServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: NotificationEndpoint(),
    );
  }

  @override
  Future<BaseResponse<NotificationListResponse>> notificationList() async {
    final url = endpoint.getNotificationList();
    final headers = await headerProvider.headers;
    final response = await httpClient.get(url, headers);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final notificationListResponse =
        NotificationListResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: notificationListResponse,
    );
  }

  @override
  Future<BaseResponse<NotificationListResponseData>> readNotification(
    String id,
  ) async {
    final url = endpoint.getReadNotification(id);
    final headers = await headerProvider.headers;
    final response = await httpClient.get(url, headers);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final notificationData =
        NotificationListResponseData.fromMap(metaResponse.result!['data']);
    return BaseResponse(
      meta: metaResponse,
      data: notificationData,
    );
  }
}
