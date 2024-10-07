import 'package:minamitra_pembudidaya_mobile/core/injections/env.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class Injection {
  static const fontFamily = "Inter";
  static final HttpClient httpClient = AppHttpClient.create();
  static final HeaderProvider headerProvider = AppHeaderProvider.create();
  static final host = env.baseURL;
  // static const quranHost = "";
  // static const prayerHost = "";
  // static const kGoogleApiKey = "";
}
