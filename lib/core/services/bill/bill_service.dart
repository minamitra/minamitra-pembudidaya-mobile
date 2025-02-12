import 'dart:convert';
import 'dart:core';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/list_bill_payed_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bill/bill_endpoint.dart';

abstract class BillService {
  Future<BaseResponse<BillSummaryResponse>> billSummary();
  Future<BaseResponse<BillResponse>> bill({
    String? filterStatus,
    String? dueDateFilterMin,
    String? dueDateFilterMax,
  });
  Future<BaseResponse<int>> pay({
    required int plafonSubmissionID,
    required String method,
    required int nominal,
    int? tfBankID,
    String? note,
  });
  Future<BaseResponse<bool>> uploadPaymentProof({
    required int id,
    required String proofImageURL,
    String? proofNote,
  });
  Future<BaseResponse<ListBillPayedResponse>> listBillPayed(
    String plafonSubmissionID,
  );
}

class BillServiceImpl implements BillService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final BillEndpoint billEndpoint;

  BillServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.billEndpoint,
  });

  factory BillServiceImpl.create() {
    return BillServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      billEndpoint: BillEndpoint(),
    );
  }

  @override
  Future<BaseResponse<BillResponse>> bill({
    String? filterStatus,
    String? dueDateFilterMin,
    String? dueDateFilterMax,
  }) async {
    final url = billEndpoint.getData(
      filterStatus,
      dueDateFilterMin,
      dueDateFilterMax,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final BillResponse billResponse =
        BillResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: billResponse,
    );
  }

  @override
  Future<BaseResponse<int>> pay({
    required int plafonSubmissionID,
    required String method,
    required int nominal,
    int? tfBankID,
    String? note,
  }) async {
    final url = billEndpoint.postPay();
    final header = await headerProvider.headers;
    final body = {
      'plafon_submission_id': plafonSubmissionID,
      'method': method,
      'nominal': nominal,
      if (tfBankID != null) 'tf_bank_id': tfBankID,
      'note': note ?? '-',
    };
    final response = await httpClient.post(
      url,
      header,
      json.encode(body),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: metaResponse.result!['data']['id'],
    );
  }

  @override
  Future<BaseResponse<bool>> uploadPaymentProof({
    required int id,
    required String proofImageURL,
    String? proofNote,
  }) async {
    final url = billEndpoint.postUploadPaymentProof();
    final header = await headerProvider.headers;
    final body = {
      'id': id,
      'proof_image_url': proofImageURL,
      'proof_note': proofNote ?? '-',
    };
    final response = await httpClient.post(
      url,
      header,
      json.encode(body),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: true,
    );
  }

  @override
  Future<BaseResponse<ListBillPayedResponse>> listBillPayed(
    String plafonSubmissionID,
  ) async {
    final url = billEndpoint.getListBillPayed(plafonSubmissionID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final ListBillPayedResponse listBillPayedResponse =
        ListBillPayedResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: listBillPayedResponse,
    );
  }

  @override
  Future<BaseResponse<BillSummaryResponse>> billSummary() async {
    final url = billEndpoint.getBillSummary();
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final BillSummaryResponse billSummaryResponse =
        BillSummaryResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: billSummaryResponse,
    );
  }
}
