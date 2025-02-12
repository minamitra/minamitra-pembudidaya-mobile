import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class RefEndpoint {
  RefEndpoint();

  Uri getProvince() {
    return createUrl(
      path: 'public-access/ref_address/province/data',
      queryParameters: {
        'pagination_bool': 'false',
      },
    );
  }

  Uri getDistrict(String provinceId) {
    return createUrl(
      path: 'public-access/ref_address/city/data',
      queryParameters: {
        'pagination_bool': 'false',
        'province_id': provinceId,
      },
    );
  }

  Uri getSubDistrict(
    String? districtId, {
    String? search,
  }) {
    return createUrl(
      path: 'public-access/ref_address/subdistrict/data',
      queryParameters: {
        'pagination_bool': 'false',
        if (districtId != null) 'city_id': districtId,
        if (search != null) 'search': search,
      },
    );
  }

  Uri getVillage(String subDistrictId) {
    return createUrl(
      path: 'public-access/ref_address/village/data',
      queryParameters: {
        'pagination_bool': 'false',
        'subdistrict_id': subDistrictId,
      },
    );
  }
}
