import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cvss_calculator/core/theme/app_theme.dart';

class MetricChoiceChipRow extends StatelessWidget {
  final String title;
  final Map<String, String> options; // abbreviation → label
  final String? selectedValue;
  final ValueChanged<String> onSelected;

  const MetricChoiceChipRow({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.entries.map((entry) {
              final isSelected = entry.key == selectedValue;
              return ChoiceChip(
                label: Text(
                  '${entry.value} (${entry.key})',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : AppColors.textSecondary,
                  ),
                ),
                selected: isSelected,
                selectedColor: AppColors.chipSelected,
                backgroundColor: AppColors.chipUnselected,
                side: BorderSide(
                  color: isSelected
                      ? AppColors.chipSelected
                      : AppColors.cardBorder,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppTheme.chipBorderRadius),
                ),
                showCheckmark: false,
                onSelected: (_) => onSelected(entry.key),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
