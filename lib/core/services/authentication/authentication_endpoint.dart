import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class AuthenticationEndpoint {
  AuthenticationEndpoint();

  Uri login() {
    return createUrl(
      path: "pos/auth/login",
    );
  }

  Uri register() {
    return createUrl(
      path: "api/auth/register",
    );
  }

  Uri userMe() {
    return createUrl(
      path: "api/user/me",
    );
  }

  Uri userKyc() {
    return createUrl(
      path: "api/document/identity-verification",
    );
  }
}
