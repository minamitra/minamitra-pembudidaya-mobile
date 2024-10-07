/// @author Diky Nugraha Difiera
/// @email dikynugraha1111@gmail.com
/// @create date 2024-03-24 14:22:18
/// @modify date 2024-03-24 14:22:18

import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_key.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/repositories/login_response.dart';

abstract class SharedPreferenceService {
  Future<void> setSharedPreference(String key, String value);
  Future<String?> getSharedPreference(String key);
  Future<void> clearSharedPreference(String key);
  Future<void> clearSecureStorage();
  Future<UserData> getUserData();
}

class SharedPreferenceServiceImpl implements SharedPreferenceService {
  const SharedPreferenceServiceImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> clearSecureStorage() {
    return _secureStorage.deleteAll();
  }

  @override
  Future<void> clearSharedPreference(String key) {
    return _secureStorage.delete(key: key);
  }

  @override
  Future<String?> getSharedPreference(String key) {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> setSharedPreference(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }

  @override
  Future<UserData> getUserData() async {
    try {
      var userDataJson =
          await _secureStorage.read(key: AppSharedPrefKey.userProfileKey);
      log(userDataJson.toString());
      if (userDataJson == null) {
        throw Exception("User data not found");
      }
      return UserData.fromJson(userDataJson);
    } catch (e) {
      throw Exception("User data not found");
    }
  }

  factory SharedPreferenceServiceImpl.create() {
    return const SharedPreferenceServiceImpl(FlutterSecureStorage());
  }
}
