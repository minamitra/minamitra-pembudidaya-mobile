import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/balance_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/history_balance_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/balance/balance_endpoint.dart';

abstract class BalanceService {
  Future<BaseResponse<BalanceResponse>> balance();
  Future<BaseResponse<HistoryBalanceResponse>> historyBalance();
}

class BalanceServiceImpl implements BalanceService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final BalanceEndpoint endpoint;

  BalanceServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory BalanceServiceImpl.create() {
    return BalanceServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: BalanceEndpoint(),
    );
  }

  @override
  Future<BaseResponse<BalanceResponse>> balance() async {
    final url = endpoint.getBalance();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final BalanceResponse balanceResponse =
        BalanceResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: balanceResponse,
    );
  }

  @override
  Future<BaseResponse<HistoryBalanceResponse>> historyBalance() async {
    final url = endpoint.getHistoryBalance();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final HistoryBalanceResponse historyBalanceResponse =
        HistoryBalanceResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: historyBalanceResponse,
    );
  }
}
