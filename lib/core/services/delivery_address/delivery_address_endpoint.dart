import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class DeliveryAddressEndpoint {
  DeliveryAddressEndpoint();

  Uri postAddAddress() {
    return createUrl(
      path: 'mitra/delivery-address/add',
    );
  }

  Uri postUpdateAddress() {
    return createUrl(
      path: 'mitra/delivery-address/update',
    );
  }

  Uri postUpdatePrimaryAddress() {
    return createUrl(
      path: 'mitra/delivery-address/update-primary',
    );
  }

  Uri postDeleteAddress() {
    return createUrl(
      path: '/mitra/delivery-address/delete',
    );
  }

  Uri getAddress() {
    return createUrl(
      path: '/mitra/delivery-address/data',
      queryParameters: {'pagination_bool': 'false'},
    );
  }
}
