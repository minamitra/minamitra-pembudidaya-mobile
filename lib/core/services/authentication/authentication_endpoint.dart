import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class AuthenticationEndpoint {
  AuthenticationEndpoint();

  Uri login() {
    return createUrl(
      path: "mitra/auth/login",
    );
  }

  Uri register() {
    return createUrl(
      path: "mitra/auth/register",
    );
  }

  Uri userMe() {
    return createUrl(
      path: "mitra/profile/detail",
    );
  }

  Uri logout() {
    return createUrl(
      path: "mitra/auth/logout",
    );
  }

  Uri userKyc() {
    return createUrl(
      path: "api/document/identity-verification",
    );
  }
}
