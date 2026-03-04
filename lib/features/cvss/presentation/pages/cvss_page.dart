import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cvss_calculator/core/constants/cvss_constants.dart';
import 'package:cvss_calculator/core/theme/app_theme.dart';
import 'package:cvss_calculator/features/cvss/logic/cvss_notifier.dart';
import 'package:cvss_calculator/features/cvss/presentation/widgets/metric_choice_chip.dart';
import 'package:cvss_calculator/features/cvss/presentation/widgets/metric_section_card.dart';
import 'package:cvss_calculator/features/cvss/presentation/widgets/score_circle.dart';
import 'package:cvss_calculator/features/cvss/presentation/widgets/vector_display.dart';

class CvssPage extends StatefulWidget {
  const CvssPage({super.key});

  @override
  State<CvssPage> createState() => _CvssPageState();
}

class _CvssPageState extends State<CvssPage> {
  final _notifier = CvssNotifier();

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _notifier,
          builder: (context, _) {
            final metrics = _notifier.metrics;
            final score = _notifier.score;
            final vector = _notifier.vector;

            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                // App Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.shield_outlined,
                            color: AppColors.primaryLight,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CVSS Calculator',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'Common Vulnerability Scoring System v3.1',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: _notifier.reset,
                          icon: const Icon(Icons.restart_alt_rounded, size: 22),
                          color: AppColors.textSecondary,
                          tooltip: 'Reset all metrics',
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.card,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: AppColors.cardBorder,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.list(
                    children: [
                      // Score
                      ScoreCircle(score: score),
                      const SizedBox(height: AppTheme.sectionSpacing),

                      // Exploitability Metrics
                      MetricSectionCard(
                        title: 'Exploitability Metrics',
                        icon: Icons.bug_report_outlined,
                        children: [
                          MetricChoiceChipRow(
                            title: 'Attack Vector (AV)',
                            options: attackVectorLabels,
                            selectedValue: metrics.av,
                            onSelected: (v) =>
                                _notifier.updateMetric(av: v),
                          ),
                          MetricChoiceChipRow(
                            title: 'Attack Complexity (AC)',
                            options: attackComplexityLabels,
                            selectedValue: metrics.ac,
                            onSelected: (v) =>
                                _notifier.updateMetric(ac: v),
                          ),
                          MetricChoiceChipRow(
                            title: 'Privileges Required (PR)',
                            options: privilegesRequiredLabels,
                            selectedValue: metrics.pr,
                            onSelected: (v) =>
                                _notifier.updateMetric(pr: v),
                          ),
                          MetricChoiceChipRow(
                            title: 'User Interaction (UI)',
                            options: userInteractionLabels,
                            selectedValue: metrics.ui,
                            onSelected: (v) =>
                                _notifier.updateMetric(ui: v),
                          ),
                          MetricChoiceChipRow(
                            title: 'Scope (S)',
                            options: scopeLabels,
                            selectedValue: metrics.scope,
                            onSelected: (v) =>
                                _notifier.updateMetric(scope: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.sectionSpacing),

                      // Impact Metrics
                      MetricSectionCard(
                        title: 'Impact Metrics',
                        icon: Icons.warning_amber_rounded,
                        children: [
                          MetricChoiceChipRow(
                            title: 'Confidentiality (C)',
                            options: confidentialityLabels,
                            selectedValue: metrics.c,
                            onSelected: (v) =>
                                _notifier.updateMetric(c: v),
                          ),
                          MetricChoiceChipRow(
                            title: 'Integrity (I)',
                            options: integrityLabels,
                            selectedValue: metrics.i,
                            onSelected: (v) =>
                                _notifier.updateMetric(i: v),
                          ),
                          MetricChoiceChipRow(
                            title: 'Availability (A)',
                            options: availabilityLabels,
                            selectedValue: metrics.a,
                            onSelected: (v) =>
                                _notifier.updateMetric(a: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.sectionSpacing),

                      // Vector String
                      VectorDisplay(vector: vector),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
