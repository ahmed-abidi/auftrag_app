import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const int $euro = 0x20AC;

class Utils {
  static formatPrice(double price) => ' ${price.toStringAsFixed(2)}';
  // ignore: non_constant_identifier_names
  static formatPricebrute(double price_brut) =>
      ' ${price_brut.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
