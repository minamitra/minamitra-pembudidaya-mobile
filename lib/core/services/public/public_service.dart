import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/public_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/suplier_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/unit_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/water_color_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/water_weather_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/public/public_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq/repositories/faq_list_response.dart';

abstract class PublicService {
  Future<BaseResponse<FaqListResponse>> faqList();
  Future<BaseResponse<FaqListResponseData>> faqDetail(String id);
  Future<BaseResponse<PublicResponse>> aboutUs();
  Future<BaseResponse<PublicResponse>> waNumber();
  Future<BaseResponse<PublicResponse>> email();
  Future<BaseResponse<PublicResponse>> officeLocation();
  Future<BaseResponse<WaterColorResponse>> waterColor();
  Future<BaseResponse<WaterWeatherResponse>> waterWeather();
  Future<BaseResponse<UnitResponse>> unitResponse();
  Future<BaseResponse<SuplierResponse>> supplierResponse();
}

class PublicServiceImpl implements PublicService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final PublicEndpoint endpoint;

  PublicServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory PublicServiceImpl.create() {
    return PublicServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: PublicEndpoint(),
    );
  }

  @override
  Future<BaseResponse<FaqListResponse>> faqList() async {
    final url = endpoint.getFAQList();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final data = FaqListResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<FaqListResponseData>> faqDetail(String id) async {
    final url = endpoint.getFAQDetail(id);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final data = FaqListResponseData.fromMap(metaResponse.result!['data']);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<PublicResponse>> aboutUs() async {
    final url = endpoint.getPublicAccess('TENTANG_KAMI');
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final data = PublicResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<PublicResponse>> waNumber() async {
    final url = endpoint.getPublicAccess('WA_NUMBER_SUPPORT');
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final data = PublicResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<PublicResponse>> email() async {
    final url = endpoint.getPublicAccess('EMAIL_SUPPORT');
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final data = PublicResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<PublicResponse>> officeLocation() async {
    final url = endpoint.getPublicAccess('OFFICE_SUPPORT');
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final data = PublicResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }

  @override
  Future<BaseResponse<WaterColorResponse>> waterColor() async {
    final url = endpoint.getWaterColor();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final data = WaterColorResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }

  @override
  Future<BaseResponse<WaterWeatherResponse>> waterWeather() async {
    final url = endpoint.getWaterWeather();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final data = WaterWeatherResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }

  @override
  Future<BaseResponse<UnitResponse>> unitResponse() async {
    final url = endpoint.getUnit();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse meta = MetaResponse.fromJson(response.body);
    final data = UnitResponse.fromMap(meta.result!);
    return BaseResponse(meta: meta, data: data);
  }

  @override
  Future<BaseResponse<SuplierResponse>> supplierResponse() async {
    final url = endpoint.getSupplier();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final data = SuplierResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: data);
  }
}
