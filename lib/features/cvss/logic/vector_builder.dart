import 'package:cvss_calculator/features/cvss/model/cvss_metrics.dart';

/// Builds the CVSS v3.1 vector string from metrics.
/// Example: CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:L
class VectorBuilder {
  const VectorBuilder._();

  static String build(CvssMetrics m) {
    return 'CVSS:3.1'
        '/AV:${m.av}'
        '/AC:${m.ac}'
        '/PR:${m.pr}'
        '/UI:${m.ui}'
        '/S:${m.scope}'
        '/C:${m.c}'
        '/I:${m.i}'
        '/A:${m.a}';
  }
}