import 'dart:math' as math;

import 'package:cvss_calculator/core/constants/cvss_constants.dart';
import 'package:cvss_calculator/core/utils/rounding.dart';
import 'package:cvss_calculator/features/cvss/model/cvss_metrics.dart';

/// Pure Dart CVSS v3.1 Base Score calculator.
/// No Flutter dependency — fully testable.
class CvssCalculator {
  const CvssCalculator._();

  /// Calculate the CVSS v3.1 Base Score from the given [metrics].
  static double calculate(CvssMetrics metrics) {
    final double iscBase = _iscBase(metrics);

    if (iscBase <= 0) return 0.0;

    final double impact = _impact(iscBase, metrics.isScopeChanged);
    final double exploitability = _exploitability(metrics);

    if (impact <= 0) return 0.0;

    if (metrics.isScopeChanged) {
      return roundUp(
        math.min(scopeChangedMultiplier * (impact + exploitability), 10.0),
      );
    }
    return roundUp(math.min(impact + exploitability, 10.0));
  }

  /// ISCBase = 1 - [(1 - C) × (1 - I) × (1 - A)]
  static double _iscBase(CvssMetrics m) {
    final double cVal = confidentialityWeights[m.c]!;
    final double iVal = integrityWeights[m.i]!;
    final double aVal = availabilityWeights[m.a]!;
    return 1.0 - ((1.0 - cVal) * (1.0 - iVal) * (1.0 - aVal));
  }

  /// Impact sub-score (depends on Scope).
  ///   Unchanged: 6.42 × ISCBase
  ///   Changed:   7.52 × [ISCBase − 0.029] − 3.25 × [ISCBase − 0.02]^13
  static double _impact(double iscBase, bool scopeChanged) {
    if (scopeChanged) {
      return 7.52 * (iscBase - 0.029) -
          3.25 * math.pow(iscBase - 0.02, 13).toDouble();
    }
    return 6.42 * iscBase;
  }

  /// Exploitability = 8.22 × AV × AC × PR × UI
  static double _exploitability(CvssMetrics m) {
    final double avVal = attackVectorWeights[m.av]!;
    final double acVal = attackComplexityWeights[m.ac]!;
    final double prVal = m.isScopeChanged
        ? privilegesRequiredWeightsChanged[m.pr]!
        : privilegesRequiredWeightsUnchanged[m.pr]!;
    final double uiVal = userInteractionWeights[m.ui]!;
    return exploitabilityCoefficient * avVal * acVal * prVal * uiVal;
  }
}