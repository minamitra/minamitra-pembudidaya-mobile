import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/authentication/authentication_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/repositories/login_request.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/repositories/login_response.dart';

abstract class AuthenticationService {
  Future<BaseResponse<LoginResponse>> login(LoginRequest request);
  Future<bool?> register({
    required String email,
    required String phoneNumber,
    required String password,
    required String name,
  });
  Future<BaseResponse<UserData>> getUserData();
  Future<void> logout();
  // Future<UserMeData> getUserMe(); // Note : Please make sure the user model for this one
  // Future<UserKyc> getUserKyc();
}

class AuthenticationServiceImpl implements AuthenticationService {
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final AuthenticationEndpoint endpoint;

  AuthenticationServiceImpl(
    this.httpClient,
    this.headerProvider,
    this.endpoint,
  );

  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequest request) async {
    final url = endpoint.login();
    final headers = await headerProvider.emptyHeaders;
    final response = await httpClient.multipartPost(
      url,
      headers,
      {},
      request.toMap(),
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final LoginResponse loginResponse =
        LoginResponse.fromMap(metaResponse.result!);
    return BaseResponse(meta: metaResponse, data: loginResponse);
  }

  @override
  Future<bool?> register({
    required String email,
    required String phoneNumber,
    required String password,
    required String name,
  }) async {
    final url = endpoint.register();
    final headers = await headerProvider.emptyHeaders;
    final response = await httpClient.multipartPost(
      url,
      headers,
      {},
      {
        "email": email,
        "mobilephone": phoneNumber,
        "password": password,
        "name": name,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<BaseResponse<UserData>> getUserData() async {
    final url = endpoint.userMe();
    final headers = await headerProvider.headers;
    final response = await httpClient.get(
      url,
      headers,
    );
    final MetaResponse metaResponse = MetaResponse.fromJson(response.body);
    final UserData userData = UserData.fromMap(metaResponse.result!["data"]);
    return BaseResponse(meta: metaResponse, data: userData);
  }

  @override
  Future<void> logout() async {
    final url = endpoint.logout();
    final header = await headerProvider.headers;
    await httpClient.multipartPost(url, header, {}, {});
  }

  // @override
  // Future<UserMeData> getUserMe() async {
  //   final url = endpoint.userMe();
  //   final headers = await headerProvider.headers;
  //   final response = await httpClient.get(
  //     url,
  //     headers,
  //   );
  //   return UserMe.fromJson(response.body).data;
  // }

  // @override
  // Future<UserKyc> getUserKyc() async {
  //   final url = endpoint.userKyc();
  //   final headers = await headerProvider.headers;
  //   final response = await httpClient.get(
  //     url,
  //     headers,
  //   );
  //   if (response.statusCode == 200) {
  //     return UserKyc.fromJson(response.body);
  //   } else {
  //     return MetaExceptionHanlder(
  //       response.statusCode,
  //       response.body,
  //     ).handleByErrorCodeCatchMessage();
  //   }
  // }

  // @override
  // Future<UserProfile> getUserProfile() async {
  //   final url = endpoint.userProfile();
  //   final header = await headerProvider.headers;
  //   final response = await httpClient.get(
  //     url,
  //     header,
  //     stacktrase: StackTrace.current,
  //   );
  //   if (response.statusCode == 200) {
  //     return UserProfile.fromJson(response.body);
  //   } else {
  //     throw AppException(Meta.fromJson(response.body).message);
  //   }
  // }

  // @override
  // Future<EkycStatus> getEkycStatus() async {
  //   final url = endpoint.kycStatus();
  //   final header = await headerProvider.headers;
  //   final response = await httpClient.get(
  //     url,
  //     header,
  //     stacktrase: StackTrace.current,
  //   );
  //   if (response.statusCode == 200) {
  //     return EkycStatus.fromJson(response.body);
  //   } else {
  //     throw AppException(Meta.fromJson(response.body).message);
  //   }
  // }

  factory AuthenticationServiceImpl.create() {
    return AuthenticationServiceImpl(
      Injection.httpClient,
      Injection.headerProvider,
      AuthenticationEndpoint(),
    );
  }
}
