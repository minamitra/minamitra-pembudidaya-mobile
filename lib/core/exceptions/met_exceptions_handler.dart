import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';

class MetaExceptionHanlder {
  final int errorCode;
  final dynamic responseBody;

  MetaExceptionHanlder(
    this.errorCode,
    this.responseBody,
  );

  handleByErrorCode() {
    String message =
        MetaResponse.fromJson(responseBody).message ?? "Unknown Error";

    switch (errorCode) {
      case 400:
        throw AppException(message);
      case 401:
        throw TokenExpired();
      default:
        throw AppException(message);
    }
  }

  handleByErrorCodeDio() {
    String message =
        MetaResponse.fromJson(responseBody).message ?? "Unknown Error";

    switch (errorCode) {
      case 400:
        throw AppException(message);
      case 401:
        throw TokenExpired();
      default:
        throw AppException(message);
    }
  }
}
