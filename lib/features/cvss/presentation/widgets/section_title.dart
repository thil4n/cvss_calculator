import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cvss_calculator/core/theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.textMuted,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
