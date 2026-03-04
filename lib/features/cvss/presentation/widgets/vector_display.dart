import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cvss_calculator/core/theme/app_theme.dart';

class VectorDisplay extends StatelessWidget {
  final String vector;

  const VectorDisplay({super.key, required this.vector});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.code, size: 18, color: AppColors.primaryLight),
                const SizedBox(width: 8),
                Text(
                  'Vector String',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => _copyVector(context),
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  color: AppColors.textSecondary,
                  tooltip: 'Copy vector string',
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.chipUnselected,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(36, 36),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: SelectableText(
                vector,
                style: GoogleFonts.firaCode(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryLight,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyVector(BuildContext context) {
    Clipboard.setData(ClipboardData(text: vector));
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Vector copied to clipboard',
            style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          ),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
