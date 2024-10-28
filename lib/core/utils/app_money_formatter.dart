import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class AppCurrencyFormatter {
  static String format(double value) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(value);
  }

  static CurrencyTextInputFormatter currency =
      CurrencyTextInputFormatter.currency(
    locale: 'id',
    decimalDigits: 0,
    symbol: "",
  );

  String unFormatedCurrency(String value) {
    return value.replaceAll("Rp ", "").replaceAll(".", "");
  }
}
