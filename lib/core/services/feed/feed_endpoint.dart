import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class FeedEndpoint {
  FeedEndpoint();

  Uri getFeed(String type) {
    return createUrl(
      path: 'mitra/fishfood/data',
      queryParameters: {
        'type': type,
        'pagination_bool': 'false',
        'sort': 'fishfood_name',
      },
    );
  }

  Uri getSeed({
    String? createdBy,
  }) {
    return createUrl(
      path: 'mitra/fishseed/data',
      queryParameters: {
        'pagination_bool': 'false',
        'sort': 'name',
        if (createdBy != null) 'create_by_type': createdBy,
      },
    );
  }

  Uri postNewSeed() {
    return createUrl(
      path: 'mitra/fishseed/add-kiloan',
    );
  }

  Uri getCommodity() {
    return createUrl(
      path: 'mitra/commodity/data',
      queryParameters: {
        'sort': 'name',
        'pagination_bool': 'false',
      },
    );
  }
}
