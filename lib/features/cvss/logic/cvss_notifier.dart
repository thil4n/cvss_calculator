import 'package:flutter/foundation.dart';

import 'package:cvss_calculator/features/cvss/logic/cvss_calculator.dart';
import 'package:cvss_calculator/features/cvss/logic/vector_builder.dart';
import 'package:cvss_calculator/features/cvss/model/cvss_metrics.dart';

/// Lightweight state management using ValueNotifier.
/// Holds the current CVSS metrics and exposes derived score + vector.
class CvssNotifier extends ChangeNotifier {
  CvssMetrics _metrics = const CvssMetrics.empty();

  CvssMetrics get metrics => _metrics;

  /// Returns the score, or null if no metric has been selected yet.
  double? get score {
    if (!_metrics.hasAnySelection) return null;
    return CvssCalculator.calculate(_metrics.resolved());
  }

  /// Returns the vector string, or null if nothing is selected.
  String? get vector {
    if (!_metrics.hasAnySelection) return null;
    return VectorBuilder.build(_metrics);
  }

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
    _metrics = const CvssMetrics.empty();
    notifyListeners();
  }
}
