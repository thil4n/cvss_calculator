/// Represents the 8 base metrics for CVSS v3.1.
/// All metric values use their official abbreviation strings.
class CvssMetrics {
  final String av; // Attack Vector: N, A, L, P
  final String ac; // Attack Complexity: L, H
  final String pr; // Privileges Required: N, L, H
  final String ui; // User Interaction: N, R
  final String scope; // Scope: U, C
  final String c; // Confidentiality: N, L, H
  final String i; // Integrity: N, L, H
  final String a; // Availability: N, L, H

  const CvssMetrics({
    required this.av,
    required this.ac,
    required this.pr,
    required this.ui,
    required this.scope,
    required this.c,
    required this.i,
    required this.a,
  });

  /// Default: all metrics at their lowest-impact values.
  factory CvssMetrics.defaults() {
    return const CvssMetrics(
      av: 'N',
      ac: 'L',
      pr: 'N',
      ui: 'N',
      scope: 'U',
      c: 'N',
      i: 'N',
      a: 'N',
    );
  }

  CvssMetrics copyWith({
    String? av,
    String? ac,
    String? pr,
    String? ui,
    String? scope,
    String? c,
    String? i,
    String? a,
  }) {
    return CvssMetrics(
      av: av ?? this.av,
      ac: ac ?? this.ac,
      pr: pr ?? this.pr,
      ui: ui ?? this.ui,
      scope: scope ?? this.scope,
      c: c ?? this.c,
      i: i ?? this.i,
      a: a ?? this.a,
    );
  }

  bool get isScopeChanged => scope == 'C';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CvssMetrics &&
          av == other.av &&
          ac == other.ac &&
          pr == other.pr &&
          ui == other.ui &&
          scope == other.scope &&
          c == other.c &&
          i == other.i &&
          a == other.a;

  @override
  int get hashCode => Object.hash(av, ac, pr, ui, scope, c, i, a);
}