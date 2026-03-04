/// Represents the 8 base metrics for CVSS v3.1.
/// All metric values use their official abbreviation strings.
/// Nullable fields mean "not yet selected by the user".
class CvssMetrics {
  final String? av; // Attack Vector: N, A, L, P
  final String? ac; // Attack Complexity: L, H
  final String? pr; // Privileges Required: N, L, H
  final String? ui; // User Interaction: N, R
  final String? scope; // Scope: U, C
  final String? c; // Confidentiality: N, L, H
  final String? i; // Integrity: N, L, H
  final String? a; // Availability: N, L, H

  const CvssMetrics({
    this.av,
    this.ac,
    this.pr,
    this.ui,
    this.scope,
    this.c,
    this.i,
    this.a,
  });

  /// Empty initial state — nothing selected.
  const CvssMetrics.empty()
      : av = null,
        ac = null,
        pr = null,
        ui = null,
        scope = null,
        c = null,
        i = null,
        a = null;

  /// Whether the user has selected at least one metric.
  bool get hasAnySelection =>
      av != null ||
      ac != null ||
      pr != null ||
      ui != null ||
      scope != null ||
      c != null ||
      i != null ||
      a != null;

  /// Whether all 8 metrics have been selected.
  bool get isComplete =>
      av != null &&
      ac != null &&
      pr != null &&
      ui != null &&
      scope != null &&
      c != null &&
      i != null &&
      a != null;

  /// Returns a fully-resolved copy using fallback defaults for any
  /// null metrics. Defaults use highest-severity exploitability and
  /// impact values so the score reacts visibly on the very first pick.
  CvssMetrics resolved() {
    return CvssMetrics(
      av: av ?? 'N',
      ac: ac ?? 'L',
      pr: pr ?? 'N',
      ui: ui ?? 'N',
      scope: scope ?? 'U',
      c: c ?? 'H',
      i: i ?? 'H',
      a: a ?? 'H',
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

  bool get isScopeChanged => (scope ?? 'U') == 'C';

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