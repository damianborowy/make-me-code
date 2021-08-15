import 'dart:math';

final magnitudes = {
  6: "M",
  9: "B",
  12: "T",
  15: "AA",
  18: "BB",
  21: "CC",
  24: "DD",
  27: "EE",
  30: "FF",
  33: "GG",
  36: "HH",
};

String prettifyNumber(num? number) {
  if (number == null) return "";

  if (number >= 1000000) {
    int exponent = log(number) ~/ log(10);
    String mantissa = ((number / pow(10, exponent)) * pow(10, exponent % 3))
        .toStringAsFixed(2);

    return "$mantissa ${magnitudes[exponent - (exponent % 3)]}";
  } else {
    return number.toInt().toString().replaceAllMapped(
        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => "${match[1]},");
  }
}
