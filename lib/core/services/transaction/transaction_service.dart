import 'dart:convert';

import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/transaction/transaction_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/checkout_body.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/repositories/transaction_item_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/repositories/delivery_status_response.dart';

abstract class TransactionService {
  Future<BaseResponse<bool>> checkout({required CheckoutBody body});
  Future<BaseResponse<TransactionItemResponse>> transactions({
    required String status,
    bool isMultiple = false,
  });
  Future<BaseResponse<bool>> cancelOrder({required int id});
  Future<BaseResponse<bool>> uploadPaymentProof({
    required int id,
    required String imageURL,
    required String notes,
  });
  Future<BaseResponse<bool>> completeTransaction({required int id});
  Future<BaseResponse<DeliveryStatusResponse>> getDeliveryStatus({
    required String orderID,
  });
}

class TransactionServiceImpl implements TransactionService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final TransactionEndpoint endpoint;

  TransactionServiceImpl({
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
  });

  factory TransactionServiceImpl.create() {
    return TransactionServiceImpl(
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: TransactionEndpoint(),
    );
  }

  @override
  Future<BaseResponse<bool>> checkout({required CheckoutBody body}) async {
    final url = endpoint.postCheckOut();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      url,
      header,
      body.toJson(),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: true,
    );
  }

  @override
  Future<BaseResponse<TransactionItemResponse>> transactions({
    required String status,
    bool isMultiple = false,
  }) async {
    final url = endpoint.getTransactions(
      status: status,
      isMultiple: isMultiple,
    );
    final header = await headerProvider.headers;
    final response = await httpClient.get(url, header);
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final TransactionItemResponse data =
        TransactionItemResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: data,
    );
  }

  @override
  Future<BaseResponse<bool>> cancelOrder({required int id}) async {
    final uri = endpoint.postCancelOrder();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      json.encode({'id': id}),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: true,
    );
  }

  @override
  Future<BaseResponse<bool>> uploadPaymentProof({
    required int id,
    required String imageURL,
    required String notes,
  }) async {
    final uri = endpoint.postPaymentProof();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      json.encode({
        'id': id,
        'payment_proof_image_url': imageURL,
        'payment_proof_note': notes,
      }),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: true,
    );
  }

  @override
  Future<BaseResponse<bool>> completeTransaction({required int id}) async {
    final uri = endpoint.postDoneTransaction();
    final header = await headerProvider.headers;
    final response = await httpClient.post(
      uri,
      header,
      json.encode({'id': id}),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    return BaseResponse(
      meta: metaResponse,
      data: true,
    );
  }

  @override
  Future<BaseResponse<DeliveryStatusResponse>> getDeliveryStatus({
    required String orderID,
  }) async {
    final uri = endpoint.getDeliveryStatus(orderID);
    final header = await headerProvider.headers;
    final response = await httpClient.get(
      uri,
      header,
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final DeliveryStatusResponse data =
        DeliveryStatusResponse.fromMap(metaResponse.result!);
    return BaseResponse(
      meta: metaResponse,
      data: data,
    );
  }
}
