import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

class ClinicalReportCard extends StatelessWidget {
  final String report;

  const ClinicalReportCard({
    super.key,
    required this.report,
  });

  List<Map<String, String>> _sections() {
    final sections = report.split('###');

    return sections
        .where((e) => e.trim().isNotEmpty)
        .map((section) {
      final lines =
          section.trim().split('\n');

      return {
        'title': lines.first,
        'content': lines
            .skip(1)
            .join('\n')
            .trim(),
      };
    }).toList();
  }
  String _cleanContent(String text) {
  return text
      .replaceAll('**', '')
      .replaceAll('- ', '• ')
      .replaceAll('CBT', 'CBT (Cognitive Behavioral Therapy)')
      .replaceAll('ERP', 'ERP (Exposure Response Prevention)');
}

  @override
  Widget build(BuildContext context) {
    final sections = _sections();

    return Column(
      children: sections.map((section) {
        return Container(
          margin:
              const EdgeInsets.only(bottom: 16),
          padding:
              const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.navBackground,
            borderRadius:
                BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  ),
  decoration: BoxDecoration(
    color: AppColors.primary.withOpacity(.08),
    borderRadius: BorderRadius.circular(10),
  ),
  child: Text(
    section['title']!,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    ),
  ),
),
              const SizedBox(height: 12),
             Directionality(
  textDirection: TextDirection.rtl,
  child: Text(
    _cleanContent(
      section['content']!,
    ),
    style: const TextStyle(
      height: 1.8,
      fontSize: 15,
    ),
  ),
)
            ],
          ),
        );
      }).toList(),
    );
  }
}