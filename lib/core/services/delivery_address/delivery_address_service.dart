import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/delivery_address/delivery_address_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/repositories/member_address_response.dart';

abstract class DeliveryAddressService {
  Future<BaseResponse<bool>> addAddress({
    required String nameAddress,
    required String nameReceiver,
    required String phoneReceiver,
    required String province,
    required String provinceId,
    required String district,
    required String districtId,
    required String subdistrict,
    required String subdistrictId,
    required String village,
    required String villageId,
    required String fullAddress,
    required String latitude,
    required String longitude,
    required bool isPrimaryAddress,
  });
  Future<BaseResponse<MemberAddressResponse>> getAddresses();
  Future<BaseResponse<bool>> updateAddress({
    required String addressID,
    required String nameAddress,
    required String nameReceiver,
    required String phoneReceiver,
    required String province,
    required String provinceId,
    required String district,
    required String districtId,
    required String subdistrict,
    required String subdistrictId,
    required String village,
    required String villageId,
    required String fullAddress,
    required String latitude,
    required String longitude,
    required bool isPrimaryAddress,
  });
  Future<BaseResponse<bool>> deleteAddress({required int addressID});
}

class DeliveryAddressServiceImpl implements DeliveryAddressService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final DeliveryAddressEndpoint endpoint;

  DeliveryAddressServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory DeliveryAddressServiceImpl.create() {
    return DeliveryAddressServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: DeliveryAddressEndpoint(),
    );
  }

  @override
  Future<BaseResponse<bool>> addAddress({
    required String nameAddress,
    required String nameReceiver,
    required String phoneReceiver,
    required String province,
    required String provinceId,
    required String district,
    required String districtId,
    required String subdistrict,
    required String subdistrictId,
    required String village,
    required String villageId,
    required String fullAddress,
    required String latitude,
    required String longitude,
    required bool isPrimaryAddress,
  }) async {
    final uri = endpoint.postAddAddress();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      jsonEncode(
        {
          'title': nameAddress,
          'name': nameReceiver,
          'phone': phoneReceiver,
          'province_id': provinceId,
          'province_name': province,
          'city_id': districtId,
          'city_name': district,
          'subdistrict_id': subdistrictId,
          'subdistrict_name': subdistrict,
          'village_id': villageId,
          'village_name': village,
          'address': fullAddress,
          'latitude': latitude,
          'longitude': longitude,
          'is_primary_bool': isPrimaryAddress,
        },
      ),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: true,
    );
  }

  @override
  Future<BaseResponse<MemberAddressResponse>> getAddresses() async {
    final uri = endpoint.getAddress();
    final header = await headerProvider.headers;
    final response = await httpClient.get(uri, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final MemberAddressResponse memberAddressResponse =
        MemberAddressResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: memberAddressResponse,
    );
  }

  @override
  Future<BaseResponse<bool>> updateAddress({
    required String addressID,
    required String nameAddress,
    required String nameReceiver,
    required String phoneReceiver,
    required String province,
    required String provinceId,
    required String district,
    required String districtId,
    required String subdistrict,
    required String subdistrictId,
    required String village,
    required String villageId,
    required String fullAddress,
    required String latitude,
    required String longitude,
    required bool isPrimaryAddress,
  }) async {
    final Uri uri = endpoint.postUpdateAddress();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      json.encode({
        'id': addressID,
        'title': nameAddress,
        'name': nameReceiver,
        'phone': phoneReceiver,
        'province_id': provinceId,
        'province_name': province,
        'city_id': districtId,
        'city_name': district,
        'subdistrict_id': subdistrictId,
        'subdistrict_name': subdistrict,
        'village_id': villageId,
        'village_name': village,
        'address': fullAddress,
        'latitude': latitude,
        'longitude': longitude,
        'is_primary_bool': isPrimaryAddress,
      }),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: true,
    );
  }

  @override
  Future<BaseResponse<bool>> deleteAddress({required int addressID}) async {
    final Uri uri = endpoint.postDeleteAddress();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      json.encode({'id': addressID}),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: true,
    );
  }
}
