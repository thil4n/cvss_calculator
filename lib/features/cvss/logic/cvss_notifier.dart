import 'package:flutter/foundation.dart';

import 'package:cvss_calculator/features/cvss/logic/cvss_calculator.dart';
import 'package:cvss_calculator/features/cvss/logic/vector_builder.dart';
import 'package:cvss_calculator/features/cvss/model/cvss_metrics.dart';

/// Lightweight state management using ValueNotifier.
/// Holds the current CVSS metrics and exposes derived score + vector.
class CvssNotifier extends ChangeNotifier {
  CvssMetrics _metrics = CvssMetrics.defaults();

  CvssMetrics get metrics => _metrics;
  double get score => CvssCalculator.calculate(_metrics);
  String get vector => VectorBuilder.build(_metrics);

  void updateMetric({
    String? av,
    String? ac,
    String? pr,
    String? ui,
    String? scope,
    String? c,
    String? i,
    String? a,
  }) {
    _metrics = _metrics.copyWith(
      av: av,
      ac: ac,
      pr: pr,
      ui: ui,
      scope: scope,
      c: c,
      i: i,
      a: a,
    );
    notifyListeners();
  }

  void reset() {
    _metrics = CvssMetrics.defaults();
    notifyListeners();
  }
}
