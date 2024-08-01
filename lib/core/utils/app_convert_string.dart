import 'package:intl/intl.dart';

String appConvertCurrency(double value) {
  String converted = NumberFormat('#,###', 'id_ID').format(value);
  return "Rp $converted";
}
