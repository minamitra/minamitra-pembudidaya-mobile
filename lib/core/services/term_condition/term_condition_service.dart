import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/term_condition/term_condition_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/privacy_policy/repositories/privacy_policy_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/term_condition/repositories/term_condition_response.dart';

abstract class TermConditionService {
  Future<BaseResponse<TermConditionResponse>> getTermCondition();
  Future<BaseResponse<PrivacyPolicyResponse>> getPrivacyPolicy();
}

class TermConditionServiceImpl implements TermConditionService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final TermConditionEndpoint endpoint;

  TermConditionServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory TermConditionServiceImpl.create() {
    return TermConditionServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: TermConditionEndpoint(),
    );
  }

  @override
  Future<BaseResponse<TermConditionResponse>> getTermCondition() async {
    final url = endpoint.termCondition("SYARAT_KETENTUAN");
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final TermConditionResponse termConditionResponse =
        TermConditionResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: termConditionResponse);
  }

  @override
  Future<BaseResponse<PrivacyPolicyResponse>> getPrivacyPolicy() async {
    final url = endpoint.termCondition("KEBIJAKAN_PRIVASI");
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final PrivacyPolicyResponse privacyPolicyResponse =
        PrivacyPolicyResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: privacyPolicyResponse);
  }
}
