import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';

/// @author Diky Nugraha Difiera
/// @email dikynugraha1111@gmail.com
/// @create date 2024-03-24 14:22:53
/// @modify date 2024-03-24 14:22:53

Uri createUrl({
  String? path,
  Map<String, dynamic>? queryParameters,
  String? customBaseURL,
}) =>
    Uri(
      scheme: "https",
      host: customBaseURL ?? Injection.host,
      path: path,
      queryParameters: queryParameters,
    );
