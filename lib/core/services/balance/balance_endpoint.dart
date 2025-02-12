import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class BalanceEndpoint {
  BalanceEndpoint();

  Uri getBalance() {
    return createUrl(path: 'mitra/dompet-3m/saldo');
  }

  Uri getHistoryBalance() {
    return createUrl(
      path: 'mitra/dompet-3m/saldo-history',
      queryParameters: {
        'pagination_bool': 'false',
      },
    );
  }
}
