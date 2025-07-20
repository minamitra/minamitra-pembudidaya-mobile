double appDoubleConvert(double value, {int fix = 3}) {
  return double.parse(value.toStringAsFixed(fix));
}
