/// @author Diky Nugraha Difiera
/// @email dikynugraha1111@gmail.com
/// @create date 2024-03-24 14:22:27
/// @modify date 2024-03-24 14:22:27
import 'dart:developer';

import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_key.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_service.dart';

abstract class HeaderProvider {
  Future<Map<String, String>> get headers;
  Future<Map<String, String>> get emptyHeaders;
}

class AppHeaderProvider implements HeaderProvider {
  final SharedPreferenceService _sharedPreferenceService;

  // final UserAgentProvider userAgentProvider;

  const AppHeaderProvider(this._sharedPreferenceService);

  @override
  Future<Map<String, String>> get headers async {
    final accessToken = await _sharedPreferenceService
        .getSharedPreference(AppSharedPrefKey.tokenKey);
    log("Token => ${accessToken.toString()}");
    // String? language = await _tokenProvider.getApplicationLanguage();
    // switch (language) {
    //   case "en":
    //     language = "en-US";
    //     break;
    //   case "ms":
    //     language = "my-MY";
    //     break;
    //   default:
    //     language = "my-MY";
    //     break;
    // }

    final headers = {
      // 'x-api-key': "",
      // 'Authorization': 'Basic YWlkYW46YTFkYW53M2IxZA==',
      'token': '$accessToken',
      "Content-Type": "application/json",
      'Accept': 'application/json',
      // 'Accept-Language': language
    };
    return headers;
  }

  @override
  Future<Map<String, String>> get emptyHeaders async => {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  factory AppHeaderProvider.create() {
    return AppHeaderProvider(SharedPreferenceServiceImpl.create());
  }
}

// class UserAgentProvider {
//   const UserAgentProvider();

//   Future<String> get userAgent async {
//     final packageInfo = await PackageInfo.fromPlatform();
//     final appName = packageInfo.appName;
//     final version = packageInfo.version;

//     final deviceInfo = DeviceInfoPlugin();
//     final String deviceInformation;
//     final String operatingSystemVersion;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       deviceInformation = androidInfo.model;
//       operatingSystemVersion = androidInfo.version.release;
//     } else if (Platform.isIOS) {
//       final iOSInfo = await deviceInfo.iosInfo;
//       deviceInformation = iOSInfo.utsname.machine ?? "Unknown";
//       operatingSystemVersion = iOSInfo.systemVersion ?? "Unknown OS Version";
//     } else {
//       deviceInformation = "Unknown";
//       operatingSystemVersion = "Unknown OS Version";
//     }
//     final operatingSystem = Platform.operatingSystem;

//     return "$appName/$version $deviceInformation $operatingSystem/$operatingSystemVersion";
//   }
// }
