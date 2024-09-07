import 'dart:async';

import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_key.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/authentication/authentication_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/repositories/login_request.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/repositories/login_response.dart';

enum AuthenticationStatus {
  initial,
  unknown,
  authenticated,
  unauthenticated,
  unverifiedEKYC,
  waitingEKYC,
  error,
  loading,
  success
}

extension AuthenticationStatusX on AuthenticationStatus {
  bool get isAuthenticated => this == AuthenticationStatus.authenticated;
  bool get isUnAuthenticated => this == AuthenticationStatus.unauthenticated;
}

abstract class AuthenticationRepository {
  Future<void> initAuthenticationStatus();
  Future<BaseResponse<LoginResponse>> login(LoginRequest request);
  // Future<void> loginWithBiometric();
  // Future<void> register(
  //   String email,
  //   String phoneNumber,
  //   String password,
  //   String name,
  // );
  Future<void> logout();
  // Future<UserMeData> readUserProfile();
  Stream<AuthenticationStatus> get streamedStatus;
  Future<void> authorizingProfile();
  // Future<UserKycData> getUserKyc();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this._storageService,
    this.authenticationService,
    // this.fingerprintService,
  );

  final _controller = StreamController<AuthenticationStatus>();
  final SharedPreferenceService _storageService;
  final AuthenticationService authenticationService;
  // final FingerprintService fingerprintService;

  @override
  Future<void> initAuthenticationStatus() async {
    final String? accessToken =
        await _storageService.getSharedPreference(AppSharedPrefKey.tokenKey);
    if (accessToken != null && accessToken.isNotEmpty) {
      // await authorizingProfile();
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      throw TokenNotFound();
    }
  }

  // @override
  // Future<void> register(
  //   String email,
  //   String phoneNumber,
  //   String password,
  //   String name,
  // ) async {
  //   await authenticationService.register(
  //     email,
  //     phoneNumber,
  //     password,
  //     name,
  //   );
  //   await authenticationService.login(
  //     phoneNumber,
  //     password,
  //   );
  // }

  @override
  Future<void> logout() async {
    await _storageService.clearSecureStorage();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  Future<void> authorizingProfile() async {
    // final response = await authenticationService.getUserMe();
    await _storageService.setSharedPreference(
      AppSharedPrefKey.userProfileKey,
      "Input to json models", // response.toJson(),
    );
    _controller.add(AuthenticationStatus.authenticated);
  }

  // Future getEKYCStatus() async {
  //   final response = await authenticationService.getEkycStatus();
  //   if (response.data.kycStatus == EKYCStatus.unverified.value) {
  //     _controller.add(AuthenticationStatus.unverifiedEKYC);
  //   } else if (response.data.kycStatus == EKYCStatus.waiting.value) {
  //     _controller.add(AuthenticationStatus.waitingEKYC);
  //   } else {
  //     _controller.add(AuthenticationStatus.authenticated);
  //   }
  // }

  // Read user profile models from local
  // @override
  // Future<UserMeData> readUserProfile() async {
  //   return await _storageService
  //       .getSharedPreference(AppSharedPrefKey.userProfileKey);
  // }

  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequest request) async {
    try {
      final loginResponse = await authenticationService.login(request);
      if (loginResponse.data.token == null ||
          loginResponse.data.token == "" ||
          (loginResponse.data.token?.isEmpty ?? true)) {
        throw AppException("Invalid Token");
      }
      await _storageService.setSharedPreference(
        AppSharedPrefKey.tokenKey,
        loginResponse.data.token!,
      );
      await _storageService.setSharedPreference(
        AppSharedPrefKey.loginResponseKey,
        loginResponse.data.toJson(),
      );
      _controller.add(AuthenticationStatus.authenticated);
      return loginResponse;
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(e.toString());
    }

    // await fingerprintService.setBiometricIdentify(userName, password);
    // await authorizingProfile();
  }

  // @override
  // Future<UserKycData> getUserKyc() async {
  //   final response = await authenticationService.getUserKyc();
  //   return response.data;
  // }

  @override
  Stream<AuthenticationStatus> get streamedStatus async* {
    yield* _controller.stream;
  }

  // @override
  // Future<void> loginWithBiometric() async {
  //   final FingerprintIdentity? fingerprintIdentity =
  //       await _credentialsStorageService.getFingerprintIdentity();
  //   if (fingerprintIdentity == null) {
  //     throw FailedGetFingerprintIdentity();
  //   }
  //   final loginResponse = await authenticationService.login(
  //     fingerprintIdentity.username,
  //     fingerprintIdentity.password,
  //   );
  //   await _credentialsStorageService.saveToken(loginResponse);
  //   await authorizingProfile();
  // }

  factory AuthenticationRepositoryImpl.create() {
    return AuthenticationRepositoryImpl(
      SharedPreferenceServiceImpl.create(),
      AuthenticationServiceImpl.create(),
    );
  }
}
