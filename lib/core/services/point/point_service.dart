import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_endpoint.dart';

abstract class PointService {}

class PointServiceImpl implements PointService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final PointEndpoint pointEndpoint;

  PointServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.pointEndpoint,
  });

  factory PointServiceImpl.create() {
    return PointServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      pointEndpoint: PointEndpoint(),
    );
  }
}
