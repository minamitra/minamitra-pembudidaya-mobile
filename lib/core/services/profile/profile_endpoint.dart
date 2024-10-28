import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class ProfileEndpoint {
  ProfileEndpoint();

  Uri detailProfile() {
    return createUrl(path: "/mitra/profile/detail-personnal");
  }

  Uri updateProfile() {
    return createUrl(path: "/mitra/profile/update-personnal");
  }

  Uri postUpdatePassword() {
    return createUrl(path: "/mitra/profile/update-password");
  }
}
