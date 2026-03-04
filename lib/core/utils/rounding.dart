/// CVSS v3.1 roundUp function.
/// "If the value when multiplied by 10 is not equal to an integer,
///  round UP to the next integer."
double roundUp(double value) {
  final int intInput = (value * 100000).toInt();
  if (intInput % 10000 == 0) {
    return intInput / 100000.0;
  }
  return ((intInput / 10000).floor() + 1) / 10.0;
}