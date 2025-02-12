import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/plafon_distribution/plafon_distribution_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_another_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_feed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_seed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_treatment_use_response.dart';

abstract class PlafonDistributionService {
  Future<BaseResponse<PlafonSummaryResponse>> plafonSummary();
  Future<BaseResponse<PlafonDistributionResponse>> plafonDistribution();
  Future<BaseResponse<PlafonDistributionSummaryResponse>> detailSummaryUse(
    String fishpondID,
  );
  Future<BaseResponse<DetailFeedUseResponse>> detailFeedUse(
    String fishpondID,
  );
  Future<BaseResponse<DetailTreatmentUseResponse>> detailTreatmentUse(
    String fishpondID,
  );
  Future<BaseResponse<DetailSeedUseResponse>> detailSeedUse(
    String fishpondID,
  );
  Future<BaseResponse<DetailAnotherUseResponse>> detailAnotherUse(
    String fishpondID,
  );
}

class PlafonDistributionServiceImpl implements PlafonDistributionService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final PlafonDistributionEndpoint endpoint;

  PlafonDistributionServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory PlafonDistributionServiceImpl.create() {
    return PlafonDistributionServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: PlafonDistributionEndpoint(),
    );
  }

  @override
  Future<BaseResponse<PlafonSummaryResponse>> plafonSummary() async {
    final url = endpoint.getSummary();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final PlafonSummaryResponse balanceResponse =
        PlafonSummaryResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: balanceResponse,
    );
  }

  @override
  Future<BaseResponse<PlafonDistributionResponse>> plafonDistribution() async {
    final url = endpoint.getData();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final PlafonDistributionResponse distributionResponse =
        PlafonDistributionResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: distributionResponse,
    );
  }

  @override
  Future<BaseResponse<PlafonDistributionSummaryResponse>> detailSummaryUse(
    String fishpondID,
  ) async {
    final url = endpoint.getDetailSummaryUse(fishpondID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final PlafonDistributionSummaryResponse summaryResponse =
        PlafonDistributionSummaryResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: summaryResponse,
    );
  }

  @override
  Future<BaseResponse<DetailFeedUseResponse>> detailFeedUse(
    String fishpondID,
  ) async {
    final url = endpoint.getDetailFeedUse(fishpondID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final DetailFeedUseResponse detailFeedUseResponse =
        DetailFeedUseResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: detailFeedUseResponse,
    );
  }

  @override
  Future<BaseResponse<DetailTreatmentUseResponse>> detailTreatmentUse(
    String fishpondID,
  ) async {
    final url = endpoint.getDetailTreatmentUse(fishpondID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final DetailTreatmentUseResponse detailTreatmentUseResponse =
        DetailTreatmentUseResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: detailTreatmentUseResponse,
    );
  }

  @override
  Future<BaseResponse<DetailSeedUseResponse>> detailSeedUse(
    String fishpondID,
  ) async {
    final url = endpoint.getDetailSeedUse(fishpondID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final DetailSeedUseResponse detailSeedUseResponse =
        DetailSeedUseResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: detailSeedUseResponse,
    );
  }

  @override
  Future<BaseResponse<DetailAnotherUseResponse>> detailAnotherUse(
    String fishpondID,
  ) async {
    final url = endpoint.getDetailAnotherUse(fishpondID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final DetailAnotherUseResponse detailAnotherUseResponse =
        DetailAnotherUseResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: detailAnotherUseResponse,
    );
  }
}
