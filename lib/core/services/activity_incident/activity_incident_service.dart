import 'dart:convert';
import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_incident/activity_incident_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/repositories/incident_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/repositories/add_incident_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/repositories/update_incicent_payload.dart';

abstract class ActivityIncidentService {
  Future<BaseResponse<IncidentResponse>> dataIncident();
  Future<BaseResponse<IncidentResponse>> historyIncident();
  Future<BaseResponse<bool>> addIncident(AddIncidentPayload payload);
  Future<BaseResponse<bool>> deleteIncident(String id);
  Future<BaseResponse<bool>> updateIncident(UpdateIncidentPayload payload);
}

class ActivityIncidentServiceImpl implements ActivityIncidentService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final ActivityIncidentEndpoint endpoint;

  ActivityIncidentServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory ActivityIncidentServiceImpl.create() {
    return ActivityIncidentServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: ActivityIncidentEndpoint(),
    );
  }

  @override
  Future<BaseResponse<IncidentResponse>> dataIncident() async {
    final url = endpoint.dataIncident("waiting,processed");
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final IncidentResponse incidentResponse =
        IncidentResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: incidentResponse);
  }

  @override
  Future<BaseResponse<IncidentResponse>> historyIncident() async {
    final url = endpoint.dataIncident("rejected,done,failed,canceled");
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final IncidentResponse incidentResponse =
        IncidentResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: incidentResponse);
  }

  @override
  Future<BaseResponse<bool>> addIncident(AddIncidentPayload payload) async {
    final url = endpoint.addIncident();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      payload.toJson(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<bool>> deleteIncident(String id) async {
    final url = endpoint.deleteIncident();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      json.encode({"id": id}),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }

  @override
  Future<BaseResponse<bool>> updateIncident(
      UpdateIncidentPayload payload) async {
    final url = endpoint.updateIncident();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      payload.toJson(),
    );
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    return BaseResponse(meta: meta, data: true);
  }
}
