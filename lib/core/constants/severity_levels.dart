import 'package:flutter/material.dart';

enum Severity {
  none('None', Color(0xFF6B7280), 0.0, 0.0),
  low('Low', Color(0xFF22C55E), 0.1, 3.9),
  medium('Medium', Color(0xFFEAB308), 4.0, 6.9),
  high('High', Color(0xFFF97316), 7.0, 8.9),
  critical('Critical', Color(0xFFEF4444), 9.0, 10.0);

  final String label;
  final Color color;
  final double min;
  final double max;

  const Severity(this.label, this.color, this.min, this.max);

  static Severity fromScore(double score) {
    if (score <= 0.0) return Severity.none;
    if (score <= 3.9) return Severity.low;
    if (score <= 6.9) return Severity.medium;
    if (score <= 8.9) return Severity.high;
    return Severity.critical;
  }
}