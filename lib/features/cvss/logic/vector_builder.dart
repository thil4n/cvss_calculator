import 'package:cvss_calculator/features/cvss/model/cvss_metrics.dart';

/// Builds the CVSS v3.1 vector string from metrics.
/// Example: CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:L
class VectorBuilder {
  const VectorBuilder._();

  /// Build vector from nullable metrics. Unselected metrics show as "_".
  static String build(CvssMetrics m) {
    return 'CVSS:3.1'
        '/AV:${m.av ?? '_'}'
        '/AC:${m.ac ?? '_'}'
        '/PR:${m.pr ?? '_'}'
        '/UI:${m.ui ?? '_'}'
        '/S:${m.scope ?? '_'}'
        '/C:${m.c ?? '_'}'
        '/I:${m.i ?? '_'}'
        '/A:${m.a ?? '_'}';
  }
}