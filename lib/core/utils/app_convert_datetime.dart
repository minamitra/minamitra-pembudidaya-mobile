import 'package:intl/intl.dart';

String countryCode = "id";

class AppConvertDateTime {
  String jm(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  String jm24(DateTime dateTime) {
    return DateFormat('HH:mm', countryCode).format(dateTime);
  }

  String dmy(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy', countryCode).format(dateTime);
  }

  String ymdDash(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd', countryCode).format(dateTime);
  }

  String edmy(DateTime dateTime) {
    return DateFormat('EEE, dd MMM yyyy', countryCode).format(dateTime);
  }

  String mdy(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy', countryCode).format(dateTime);
  }

  String dmyName(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy', countryCode).format(dateTime);
  }

  String ddmmyyyyhhmm(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy HH:mm WIB', countryCode).format(dateTime);
  }
}
