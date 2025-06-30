import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class TransactionEndpoint {
  TransactionEndpoint();

  Uri postCheckOut() {
    return createUrl(
      path: 'mitra/order/add',
    );
  }

  Uri getTransactions({
    required String status,
    bool isMultiple = false,
  }) {
    return createUrl(
      path: 'mitra/order/data',
      queryParameters: {
        if (isMultiple) 'status[in]': status else 'status': status,
        'limit': '100',
      },
    );
  }

  Uri postCancelOrder() {
    return createUrl(
      path: 'mitra/order/cancel',
    );
  }

  Uri postPaymentProof() {
    return createUrl(
      path: 'mitra/order/update-proof',
    );
  }

  Uri postDoneTransaction() {
    return createUrl(
      path: 'mitra/order/done',
    );
  }

  Uri getDeliveryStatus(String orderID) {
    return createUrl(
      path: 'mitra/delivery-status/data',
      queryParameters: {
        'order_id': orderID,
      },
    );
  }

  Uri getTransactionDetail(String orderID) {
    return createUrl(
      path: 'mitra/order/detail',
      queryParameters: {'id': orderID},
    );
  }
}
