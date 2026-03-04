import 'package:flutter_test/flutter_test.dart';

import 'package:cvss_calculator/features/cvss/logic/cvss_calculator.dart';
import 'package:cvss_calculator/features/cvss/logic/vector_builder.dart';
import 'package:cvss_calculator/features/cvss/model/cvss_metrics.dart';

void main() {
  group('CvssCalculator', () {
    test('all None impact yields 0.0', () {
      final metrics = CvssMetrics.defaults();
      expect(CvssCalculator.calculate(metrics), 0.0);
    });

    test('AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H = 9.8', () {
      const metrics = CvssMetrics(
        av: 'N', ac: 'L', pr: 'N', ui: 'N',
        scope: 'U', c: 'H', i: 'H', a: 'H',
      );
      expect(CvssCalculator.calculate(metrics), 9.8);
    });

    test('AV:N/AC:L/PR:N/UI:N/S:C/C:H/I:H/A:H = 10.0', () {
      const metrics = CvssMetrics(
        av: 'N', ac: 'L', pr: 'N', ui: 'N',
        scope: 'C', c: 'H', i: 'H', a: 'H',
      );
      expect(CvssCalculator.calculate(metrics), 10.0);
    });

    test('AV:N/AC:L/PR:N/UI:R/S:C/C:L/I:L/A:N = 6.1', () {
      const metrics = CvssMetrics(
        av: 'N', ac: 'L', pr: 'N', ui: 'R',
        scope: 'C', c: 'L', i: 'L', a: 'N',
      );
      expect(CvssCalculator.calculate(metrics), 6.1);
    });

    test('AV:L/AC:H/PR:H/UI:R/S:U/C:L/I:N/A:N = 1.8', () {
      const metrics = CvssMetrics(
        av: 'L', ac: 'H', pr: 'H', ui: 'R',
        scope: 'U', c: 'L', i: 'N', a: 'N',
      );
      expect(CvssCalculator.calculate(metrics), 1.8);
    });
  });

  group('VectorBuilder', () {
    test('builds correct vector string', () {
      const metrics = CvssMetrics(
        av: 'N', ac: 'L', pr: 'N', ui: 'N',
        scope: 'U', c: 'H', i: 'H', a: 'L',
      );
      expect(
        VectorBuilder.build(metrics),
        'CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:L',
      );
    });
  });
}

