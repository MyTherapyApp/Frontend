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
              Text(
                section['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                section['content']!,
                style: const TextStyle(
                  height: 1.7,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}