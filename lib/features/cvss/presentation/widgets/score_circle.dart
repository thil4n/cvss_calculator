import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cvss_calculator/core/constants/severity_levels.dart';
import 'package:cvss_calculator/core/theme/app_theme.dart';

class ScoreCircle extends StatelessWidget {
  final double? score;

  const ScoreCircle({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final displayScore = score ?? 0.0;
    final severity = Severity.fromScore(displayScore);
    final bool hasScore = score != null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: AppTheme.cardPadding,
        ),
        child: Column(
          children: [
            Text(
              'CVSS v3.1 Base Score',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: displayScore),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, animatedScore, child) {
                final animSeverity = Severity.fromScore(animatedScore);
                return SizedBox(
                  width: 160,
                  height: 160,
                  child: CustomPaint(
                    painter: _ScoreRingPainter(
                      score: animatedScore,
                      color: hasScore
                          ? animSeverity.color
                          : const Color(0xFF334155),
                    ),
                    child: Center(
                      child: Text(
                        hasScore
                            ? animatedScore.toStringAsFixed(1)
                            : '—',
                        style: GoogleFonts.inter(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          color: hasScore
                              ? animSeverity.color
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: hasScore
                    ? severity.color.withValues(alpha: 0.15)
                    : const Color(0xFF334155).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                hasScore ? severity.label : 'Select metrics',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: hasScore ? severity.color : AppColors.textMuted,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  final double score;
  final Color color;

  _ScoreRingPainter({required this.score, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 10.0;

    // Background ring
    final bgPaint = Paint()
      ..color = const Color(0xFF334155)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Score arc
    final sweepAngle = (score / 10.0) * 2 * math.pi;
    final scorePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      scorePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) =>
      oldDelegate.score != score || oldDelegate.color != color;
}
