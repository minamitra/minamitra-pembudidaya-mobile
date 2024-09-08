import 'dart:developer';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/district_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/province_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/sub_district_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/village_response.dart';

abstract class RefService {
  Future<BaseResponse<ProvinceResponse>> province();
  Future<BaseResponse<DistrictResponse>> district(String provinceId);
  Future<BaseResponse<SubDistrictResponse>> subDistrict(String districtId);
  Future<BaseResponse<VillageResponse>> village(String subDistrictId);
}

class RefServiceImpl implements RefService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final RefEndpoint endpoint;

  RefServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory RefServiceImpl.create() {
    return RefServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: RefEndpoint(),
    );
  }

  @override
  Future<BaseResponse<DistrictResponse>> district(String provinceID) async {
    log("provinceID running");
    final uri = endpoint.getDistrict(provinceID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final DistrictResponse districtResponse =
        DistrictResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: districtResponse);
  }

  @override
  Future<BaseResponse<ProvinceResponse>> province() async {
    final uri = endpoint.getProvince();
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final ProvinceResponse provinceResponse =
        ProvinceResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: provinceResponse);
  }

  @override
  Future<BaseResponse<SubDistrictResponse>> subDistrict(
      String districtID) async {
    final uri = endpoint.getSubDistrict(districtID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final SubDistrictResponse subDistrictResponse =
        SubDistrictResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: subDistrictResponse);
  }

  @override
  Future<BaseResponse<VillageResponse>> village(String subdistrictID) async {
    final uri = endpoint.getVillage(subdistrictID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final VillageResponse villageResponse =
        VillageResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: villageResponse);
  }
}
