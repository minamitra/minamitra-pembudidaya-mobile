import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class BankEndpoint {
  BankEndpoint();

  Uri getBanks() {
    return createUrl(
      path: 'mitra/bank/data',
      queryParameters: {
        'pagination_bool': 'false',
      },
    );
  }
}
