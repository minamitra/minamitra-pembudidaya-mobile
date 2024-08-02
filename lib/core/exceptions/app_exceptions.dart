/// @author Diky Nugraha Difiera
/// @email dikynugraha1111@gmail.com
/// @create date 2024-03-24 14:21:42
/// @modify date 2024-03-24 14:21:42
class AppException implements Exception {
  final String message;

  AppException(this.message);
}

class AuthenticationFailed extends AppException {
  AuthenticationFailed({String message = "AUTHENTICATION_FAILED"})
      : super(message);
}

class FailedSaveSecureStorageToken extends AppException {
  FailedSaveSecureStorageToken({String message = "FAILED_SAVE_TOKEN"})
      : super(message);
}

class FailedClearSecureStorage extends AppException {
  FailedClearSecureStorage({String message = "FAILED_CLEAR_SECURE_STORAGE"})
      : super(message);
}

class FailedClearSecureStorageToken extends AppException {
  FailedClearSecureStorageToken({String message = "FAILED_CLEAR_TOKEN"})
      : super(message);
}

class SecureStorageNullToken extends AppException {
  SecureStorageNullToken({String message = "SECURE_STORAGE_NULL_TOKEN"})
      : super(message);
}

class TokenExpired extends AppException {
  TokenExpired({String message = "TOKEN_EXPIRED"}) : super(message);
}

class TokenNotFound extends AppException {
  TokenNotFound({String message = "TOKEN_NOT_FOUND"}) : super(message);
}

class FailedReadSecureStorage extends AppException {
  FailedReadSecureStorage({String message = "FAILED_READ_STORAGE"})
      : super(message);
}

class FailedWriteSecureStorage extends AppException {
  FailedWriteSecureStorage({String message = "FAILED_WRITE_STORAGE"})
      : super(message);
}

class LanguageException extends AppException {
  LanguageException({String message = "FAILED_LANGUAGE"}) : super(message);
}

class FailedGetUserPosition extends AppException {
  FailedGetUserPosition({String message = "FAILED_GET_USER_POSITION_CACHE"})
      : super(message);
}

class PositionNullValue extends AppException {
  PositionNullValue({String message = "FAILED_GET_USER_POSITION_ON_NULL"})
      : super(message);
}

class FailedGetHistoryLocation extends AppException {
  FailedGetHistoryLocation(
      {String message = "FAILED_GET_HISTORY_LOCATION_CACHE"})
      : super(message);
}

class FailedSaveUserProfile extends AppException {
  FailedSaveUserProfile({String message = "FAILED_SAVE_PROFILE"})
      : super(message);
}

class FailedReadUserProfile extends AppException {
  FailedReadUserProfile({String message = "FAILED_READ_PROFILE"})
      : super(message);
}

class FailedAuthorizingProfile extends AppException {
  FailedAuthorizingProfile({String message = "FAILED_AUTHORIZING_PROFILE"})
      : super(message);
}

class DataNotFound extends AppException {
  DataNotFound({String message = "DATA_NOT_FOUND"}) : super(message);
}

class LimitCreditLoanNull extends AppException {
  LimitCreditLoanNull({String message = "LIMIT_CREDIT_NULL"}) : super(message);
}

class CustomException extends AppException {
  CustomException({String message = "UNKNOWN_ERROR"}) : super(message);
}

class FailedGetPrayerSchedule extends AppException {
  FailedGetPrayerSchedule({String message = "FAILED_GET_PRAYER_SCHEDULE"})
      : super(message);
}

class FailedUpdatePrayerSchedule extends AppException {
  FailedUpdatePrayerSchedule({String message = "FAILED_UPDATE_PRAYER_SCHEDULE"})
      : super(message);
}

class FailedGetLatestReadSurah extends AppException {
  FailedGetLatestReadSurah({String message = "FAILED_GET_LATEST_READ_SURAH"})
      : super(message);
}

class FailedUpdateLatestReadSurah extends AppException {
  FailedUpdateLatestReadSurah(
      {String message = "FAILED_UPDATE_LATEST_READ_SURAH"})
      : super(message);
}

class PrayerScheduleNullValue extends AppException {
  PrayerScheduleNullValue({String message = "PRAYER_SCHEDULE_NULL"})
      : super(message);
}

class FailedUpdateFirebaseCloudMessagingToken extends AppException {
  FailedUpdateFirebaseCloudMessagingToken(
      {String message = "FAILED_UPDATE_FIREBASE_CLOUD_MESSAGING_TOKEN"})
      : super(message);
}

class FailedGetFingerprintIdentity extends AppException {
  FailedGetFingerprintIdentity(
      {String message = "FAILED_GET_FINGERPRINT_IDENTITY"})
      : super(message);
}

class FailedSetFingerprintIdentity extends AppException {
  FailedSetFingerprintIdentity(
      {String message = "FAILED_SET_FINGERPRINT_IDENTITY"})
      : super(message);
}

class FailedClearFingerprintIdentity extends AppException {
  FailedClearFingerprintIdentity(
      {String message = "FAILED_CLEAR_FINGERPRINT_IDENTITY"})
      : super(message);
}

class FailedGetUser extends AppException {
  FailedGetUser({String message = "FAILED_GET_USER"}) : super(message);
}

class FingerPrintDeactivated extends AppException {
  FingerPrintDeactivated({String message = "FINGERPRINT_DEACTIVATED"})
      : super(message);
}

class FailedFingerPrintIdentify extends AppException {
  FailedFingerPrintIdentify({String message = "FAILED_FINGERPRINT_IDENTIFY"})
      : super(message);
}

class FingerPrintUnavailable extends AppException {
  FingerPrintUnavailable({String message = "FINGERPRINT_UNAVAILABLE"})
      : super(message);
}

extension DefaultException on int {
  AppException get defaultException {
    switch (this) {
      case 400:
        return TokenExpired();
      default:
        return CustomException(message: "UNKNOWN_ERROR");
    }
  }
}
