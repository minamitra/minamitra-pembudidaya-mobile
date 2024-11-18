import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bank_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bank/bank_endpoint.dart';

abstract class BankService {
  Future<BaseResponse<BankResponse>> getBanks();
}

class BankServiceImpl implements BankService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final BankEndpoint endpoint;

  BankServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory BankServiceImpl.create() {
    return BankServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: BankEndpoint(),
    );
  }

  @override
  Future<BaseResponse<BankResponse>> getBanks() async {
    final uri = endpoint.getBanks();
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final BankResponse bankResponse =
        BankResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: bankResponse,
    );
  }
}
