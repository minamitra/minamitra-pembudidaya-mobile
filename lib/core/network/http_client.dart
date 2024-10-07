/// @author Diky Nugraha Difiera
/// @email dikynugraha1111@gmail.com
/// @create date 2024-03-24 14:22:33
/// @modify date 2024-03-24 14:22:33
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/met_exceptions_handler.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/network_logger.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';

abstract class HttpClient<T> {
  Future<T> delete(
    Uri url,
    Map<String, String>? headers,
    Object? body, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  });
  Future<T> get(
    Uri url,
    Map<String, String>? headers, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  });
  Future<T> post(
    Uri url,
    Map<String, String>? headers,
    String body, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  });
  Future<T> put(
    Uri url,
    Map<String, String>? headers,
    Object? body, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  });
  Future<T> patch(
    Uri url,
    Map<String, String>? headers,
    Object? body, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  });
  Future<T> multipartPost(
    Uri url,
    Map<String, String> headers,
    Map<String, File> files,
    Map<String, String>? fields, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  });
  // Future<T> postDio(
  //   String url,
  //   Map<String, String> headers,
  //   Object? fields,
  // );
}

class AppHttpClient implements HttpClient {
  final http.Client _client;

  // final AppCrashlytic _crashlytic;

  AppHttpClient(this._client

      // this._crashlytic,
      );

  @override
  Future<http.Response> delete(
    Uri url,
    Map<String, String>? headers,
    Object? body, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  }) async {
    try {
      final response = await _client.delete(
        url,
        headers: headers,
        body: body,
      );
      appNetworkLogger(
        endpoint: "DELETE ENDPOINT => ${url.toString()}",
        payload: body.toString(),
        response: response.body.toString(),
      );
      MetaResponse metaResponse = MetaResponse.fromJson(response.body);
      if (response.statusCode != 200 || metaResponse.status != 200) {
        MetaExceptionHanlder(
          response.statusCode,
          response.body,
        ).handleByErrorCode();
      }
      // if (!kIsWeb) {
      //   if (customAllowedStatusCode != null
      //       ? !(customAllowedStatusCode.contains(response.statusCode))
      //       : !(response.statusCode == 200 || response.statusCode == 201)) {
      //     FirebaseCrashlytics.instance.recordError(
      //       _crashlytic.exception(response),
      //       stackTrace ?? StackTrace.current,
      //       reason: _crashlytic.reason(response),
      //       fatal: true,
      //     );
      //     await FirebaseCrashlytics.instance.sendUnsentReports();
      //   }
      // }
      // if (alice != null) alice!.onHttpResponse(response);
      return response;
    } on AppException {
      rethrow;
    } catch (exception) {
      throw AppException(exception.toString());
    }
  }

  @override
  Future<http.Response> get(
    Uri url,
    Map<String, String>? headers, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  }) async {
    try {
      final response = await _client.get(
        url,
        headers: headers,
      );
      appNetworkLogger(
        endpoint:
            "GET ENDPOINT => ${url.toString()} | HEADERS => ${headers.toString()} | STATUS CODE => ${response.statusCode}",
        payload: "",
        response: response.body.toString(),
      );
      MetaResponse metaResponse = MetaResponse.fromJson(response.body);
      if (customAllowedStatusCode != null) {
        if (customAllowedStatusCode.contains(response.statusCode) ||
            customAllowedStatusCode.contains(metaResponse.status)) {
          return response;
        }
      }
      if (response.statusCode != 200 || metaResponse.status != 200) {
        MetaExceptionHanlder(
          response.statusCode,
          response.body,
        ).handleByErrorCode();
      }
      // if (!kIsWeb) {
      //   if (customAllowedStatusCode != null
      //       ? !(customAllowedStatusCode.contains(response.statusCode))
      //       : !(response.statusCode == 200 || response.statusCode == 201)) {
      //     FirebaseCrashlytics.instance.recordError(
      //       _crashlytic.exception(response),
      //       stackTrace ?? StackTrace.current,
      //       reason: _crashlytic.reason(response),
      //       fatal: true,
      //     );
      //     await FirebaseCrashlytics.instance.sendUnsentReports();
      //   }
      // }

      // if (alice != null) alice!.onHttpResponse(response);
      return response;
    } on AppException {
      rethrow;
    } catch (exception) {
      throw AppException(exception.toString());
    }
  }

  @override
  Future<http.Response> post(
    Uri url,
    Map<String, String>? headers,
    String body, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  }) async {
    try {
      http.Request request = http.Request('POST', url);
      request.body = body;
      request.headers['Content-Type'] = "application/json";
      request.headers['Accept'] = "application/json";
      request.headers['token'] = headers!["token"]!;

      final sendData = await request.send();
      final response = await http.Response.fromStream(sendData);

      appNetworkLogger(
        endpoint: "POST ENDPOINT => ${url.toString()}",
        payload: body.toString(),
        response: response.body.toString(),
      );
      MetaResponse metaResponse = MetaResponse.fromJson(response.body);
      if (response.statusCode != 200 || metaResponse.status != 200) {
        MetaExceptionHanlder(
          response.statusCode,
          response.body,
        ).handleByErrorCode();
      }
      // if (!kIsWeb) {
      //   if (customAllowedStatusCode != null
      //       ? !(customAllowedStatusCode.contains(response.statusCode))
      //       : !(response.statusCode == 200 || response.statusCode == 201)) {
      //     FirebaseCrashlytics.instance.recordError(
      //       _crashlytic.exception(response),
      //       stackTrace ?? StackTrace.current,
      //       reason: _crashlytic.reason(response),
      //       fatal: true,
      //     );
      //     await FirebaseCrashlytics.instance.sendUnsentReports();
      //   }
      // }

      // if (alice != null) alice!.onHttpResponse(response);
      return response;
    } on AppException {
      rethrow;
    } catch (exception) {
      log(exception.toString());
      throw AppException(exception.toString());
    }
  }

  @override
  Future<http.Response> put(
    Uri url,
    Map<String, String>? headers,
    Object? body, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  }) async {
    try {
      final response = await _client.put(
        url,
        headers: headers,
        body: body,
      );
      appNetworkLogger(
        endpoint: "PUT ENDPOINT => ${url.toString()}",
        payload: body.toString(),
        response: response.body.toString(),
      );
      MetaResponse metaResponse = MetaResponse.fromJson(response.body);
      if (response.statusCode != 200 || metaResponse.status != 200) {
        MetaExceptionHanlder(
          response.statusCode,
          response.body,
        ).handleByErrorCode();
      }
      // if (!kIsWeb) {
      //   if (customAllowedStatusCode != null
      //       ? !(customAllowedStatusCode.contains(response.statusCode))
      //       : !(response.statusCode == 200 || response.statusCode == 201)) {
      //     FirebaseCrashlytics.instance.recordError(
      //       _crashlytic.exception(response),
      //       stackTrace ?? StackTrace.current,
      //       reason: _crashlytic.reason(response),
      //       fatal: true,
      //     );
      //     await FirebaseCrashlytics.instance.sendUnsentReports();
      //   }
      // }

      // if (alice != null) alice!.onHttpResponse(response);
      return response;
    } on AppException {
      rethrow;
    } catch (exception) {
      throw AppException(exception.toString());
    }
  }

  @override
  Future<http.Response> patch(
    Uri url,
    Map<String, String>? headers,
    Object? body, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  }) async {
    try {
      final response = await _client.patch(
        url,
        headers: headers,
        body: body,
      );
      appNetworkLogger(
        endpoint: "PATCH ENDPOINT => ${url.toString()}",
        payload: body.toString(),
        response: response.body.toString(),
      );
      MetaResponse metaResponse = MetaResponse.fromJson(response.body);
      if (response.statusCode != 200 || metaResponse.status != 200) {
        MetaExceptionHanlder(
          response.statusCode,
          response.body,
        ).handleByErrorCode();
      }
      // if (!kIsWeb) {
      //   if (customAllowedStatusCode != null
      //       ? !(customAllowedStatusCode.contains(response.statusCode))
      //       : !(response.statusCode == 200 || response.statusCode == 201)) {
      //     FirebaseCrashlytics.instance.recordError(
      //       _crashlytic.exception(response),
      //       stackTrace ?? StackTrace.current,
      //       reason: _crashlytic.reason(response),
      //       fatal: true,
      //     );
      //     await FirebaseCrashlytics.instance.sendUnsentReports();
      //   }
      // }

      // if (alice != null) alice!.onHttpResponse(response);
      return response;
    } on AppException {
      rethrow;
    } catch (exception) {
      throw AppException(exception.toString());
    }
  }

  @override
  Future<http.Response> multipartPost(
    Uri url,
    Map<String, String> headers,
    Map<String, File> files,
    Map<String, String>? fields, {
    StackTrace? stackTrace,
    List<int>? customAllowedStatusCode,
  }) async {
    http.MultipartRequest request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);
    if (fields != null) request.fields.addAll(fields);
    files.forEach((key, value) {
      request.files.add(http.MultipartFile.fromBytes(
        key,
        value.readAsBytesSync(),
        filename: value.path.split('/').last,
      ));
    });

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);
    appNetworkLogger(
      endpoint: "MULTIPART POST ENDPOINT => ${url.toString()}",
      payload: fields.toString(),
      response: response.body,
    );
    MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    if (response.statusCode != 200 || metaResponse.status != 200) {
      MetaExceptionHanlder(
        response.statusCode,
        response.body,
      ).handleByErrorCode();
    }

    // if (!kIsWeb) {
    //   if (customAllowedStatusCode != null
    //       ? !(customAllowedStatusCode.contains(streamedResponse.statusCode))
    //       : !(streamedResponse.statusCode == 200 ||
    //           streamedResponse.statusCode == 201)) {
    //     FirebaseCrashlytics.instance.recordError(
    //       streamedResponse,
    //       stackTrace ?? StackTrace.current,
    //       reason: streamedResponse,
    //       fatal: true,
    //     );
    //     await FirebaseCrashlytics.instance.sendUnsentReports();
    //   }
    // }

    return response;
  }

  factory AppHttpClient.create() {
    return AppHttpClient(http.Client()
        // AppCrashlyticImpl(),
        );
  }

  // @override
  // Future postDio(
  //   String url,
  //   Map<String, String> headers,
  //   Object? fields,
  // ) async {
  //   try {
  //     _dio.interceptors.addAll([
  //       LogInterceptor(
  //         responseBody: true,
  //         requestBody: true,
  //         logPrint: (object) => log(
  //           object.toString(),
  //           name: "KAJ DIO",
  //         ),
  //       ),
  //     ]);
  //     final response = await _dio.post(
  //       url,
  //       data: fields,
  //       options: Options(
  //         headers: headers,
  //         contentType: "application/json",
  //       ),
  //     );
  //     appNetworkLogger(
  //       endpoint: "POST ENDPOINT => ${url.toString()}",
  //       payload: fields.toString(),
  //       response: response.data.toString(),
  //     );
  //     MetaResponse metaResponse = MetaResponse.fromMap(response.data);
  //     if (response.statusCode != 200 || metaResponse.status != 200) {
  //       MetaExceptionHanlder(
  //         response.statusCode ?? 200,
  //         response.data,
  //       ).handleByErrorCodeDio();
  //     }
  //     // if (!kIsWeb) {
  //     //   if (customAllowedStatusCode != null
  //     //       ? !(customAllowedStatusCode.contains(response.statusCode))
  //     //       : !(response.statusCode == 200 || response.statusCode == 201)) {
  //     //     FirebaseCrashlytics.instance.recordError(
  //     //       _crashlytic.exception(response),
  //     //       stackTrace ?? StackTrace.current,
  //     //       reason: _crashlytic.reason(response),
  //     //       fatal: true,
  //     //     );
  //     //     await FirebaseCrashlytics.instance.sendUnsentReports();
  //     //   }
  //     // }

  //     // if (alice != null) alice!.onHttpResponse(response);
  //     // response.data
  //     return response;
  //   } on AppException {
  //     rethrow;
  //   } catch (exception) {
  //     log(exception.toString());
  //     throw AppException(exception.toString());
  //   }
  // }
}
