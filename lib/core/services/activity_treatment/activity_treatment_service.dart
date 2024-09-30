import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_treatment/activity_treatment_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/repositories/add_treatment_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/treatment_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/repositories/update_treatment_payload.dart';

abstract class ActivityTreatmentService {
  Future<BaseResponse<TreatmentResponse>> dataTreatment(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  );
  Future<BaseResponse<bool>> addTreatment(AddTreatmentPayload payload);
  Future<BaseResponse<bool>> deleteTreatment(String id);
  Future<BaseResponse<bool>> updateTreatment(UpdateTreatmentPayload payload);
}

class ActivityTreatmentServiceImpl implements ActivityTreatmentService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final ActivityTreatmentEndpoint endpoint;

  ActivityTreatmentServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory ActivityTreatmentServiceImpl.create() {
    return ActivityTreatmentServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: ActivityTreatmentEndpoint(),
    );
  }

  @override
  Future<BaseResponse<TreatmentResponse>> dataTreatment(
    int fishpondId,
    int fishpondcycleId,
    String datetime,
  ) async {
    final url = endpoint.dataTreatment(
      fishpondId,
      fishpondcycleId,
      datetime,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final TreatmentResponse treatmentResponse =
        TreatmentResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: treatmentResponse);
  }

  @override
  Future<BaseResponse<bool>> addTreatment(AddTreatmentPayload payload) async {
    final url = endpoint.addTreatment();
    final header = await headerProvider.headers;
    final response = await httpClient.postDio(
      url.toString(),
      header,
      payload.toMap(),
    );
    final MetaResponse meta = MetaResponse.fromMap(response.data);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<bool>> deleteTreatment(String id) async {
    final url = endpoint.deleteTreatment();
    final header = await headerProvider.headers;
    final response = await httpClient.postDio(
      url.toString(),
      header,
      {"id": id},
    );
    final MetaResponse meta = MetaResponse.fromMap(response.data);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<bool>> updateTreatment(
      UpdateTreatmentPayload payload) async {
    final url = endpoint.updateTreatment();
    final header = await headerProvider.headers;
    final response = await httpClient.postDio(
      url.toString(),
      header,
      payload.toMap(),
    );
    final MetaResponse meta = MetaResponse.fromMap(response.data);
    return BaseResponse(meta: meta, data: true);
  }
}
