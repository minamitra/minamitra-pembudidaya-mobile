import 'package:intl/intl.dart';

String appConvertCurrency(double value) {
  String converted = NumberFormat('#,###', 'id_ID').format(value);
  return "Rp $converted";
}

extension HandlingEmptyString on String? {
  String handlingEmptyString() {
    return (this ?? "").isEmpty ? "-" : this ?? "-";
  }

  String handlingEmptyStringWithTNoteNotes() {
    return (this ?? "").isEmpty
        ? "Tidak Ada Catatan"
        : this ?? "Tidak Ada Catatan";
  }

  String? handleEmptyStringToNull() {
    return (this ?? "").isEmpty ? null : this;
  }

  String handleEmptyStringToZero() {
    return (this ?? "").isEmpty ? "0" : this ?? "0";
  }
}

extension FormatCurrency on String {
  String unFormatedCurrency() {
    return replaceAll("Rp ", "").replaceAll(".", "");
  }
}
