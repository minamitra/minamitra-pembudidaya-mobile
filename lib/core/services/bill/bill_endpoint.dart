import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class BillEndpoint {
  BillEndpoint();

  Uri getBillSummary() {
    return createUrl(path: 'mitra/plafon-invoice/summary');
  }

  Uri getData(
    String? filterStatus,
    String? dueDateFilterMin,
    String? dueDateFilterMax,
  ) {
    return createUrl(
      path: 'mitra/plafon-invoice/data',
      queryParameters: {
        if (filterStatus != null && filterStatus != 'Semua Tagihan')
          'payment_status': filterStatus,
        if (filterStatus != null && filterStatus == 'Semua Tagihan')
          'payment_status[neq]': 'Tagihan Terbayar',
        if (dueDateFilterMin != null) 'due_date[gte]': dueDateFilterMin,
        if (dueDateFilterMax != null) 'due_date[lte]': dueDateFilterMax,
        'pagination_bool': 'false',
      },
    );
  }

  Uri postPay() {
    return createUrl(path: 'mitra/plafon-payment/add');
  }

  Uri postUploadPaymentProof() {
    return createUrl(path: 'mitra/plafon-payment/update-proof');
  }

  Uri getListBillPayed(String plafonSubmissionID) {
    return createUrl(
      path: 'mitra/plafon-payment/data',
      queryParameters: {'plafon_submission_id': plafonSubmissionID},
    );
  }
}
