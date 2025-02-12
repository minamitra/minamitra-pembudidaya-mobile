extension AppConvertDouble on double? {
  double handlingOnNull() {
    return this ?? 0.0;
  }
}
