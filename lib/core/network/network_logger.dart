/// @author Diky Nugraha Difiera
/// @email dikynugraha1111@gmail.com
/// @create date 2024-03-24 14:22:40
/// @modify date 2024-03-24 14:22:40
import 'dart:developer';
import 'package:flutter/foundation.dart';

appNetworkLogger({
  required String endpoint,
  required String payload,
  required String response,
}) {
  if (kDebugMode) {
    log("============================================================================================================");
    String text = "$endpoint\nPAYLOAD => $payload\nRESPONSE => $response";
    log("\x1B[32m$text\x1B[0m ");
    log("============================================================================================================");
  }
}
