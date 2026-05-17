// lib/features/dashboard/presentation/views/litigation_management_handbook/litigation_management_handbook_preview.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_cases_app_bar.dart';

class LitigationManagementHandbookPreview extends StatelessWidget {
  const LitigationManagementHandbookPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockHandbooks = [
      {'name': 'Test'},
      {'name': 'Litigation Guidelines 2024'},
      {'name': 'Case Management Protocol'},
      {'name': 'Legal Notice Templates'},
    ];

    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      appBar: buildInstrumentDeliveryCasesAppBar(
        context,
        title: 'LMS HandBooks Preview',
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppColor.panelBg,
              border: Border(bottom: BorderSide(color: AppColor.borderSoft)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.dashboardAccentOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.auto_stories_rounded, color: AppColor.dashboardAccentOrange),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LMS HandBooks',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColor.textPrimary,
                          ),
                    ),
                    Text(
                      'Available resources and guides',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
              physics: const BouncingScrollPhysics(),
              itemCount: mockHandbooks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final handbook = mockHandbooks[index];
                return _HandbookCard(name: handbook['name'] ?? '');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HandbookCard extends StatelessWidget {
  const _HandbookCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.panelBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColor.borderSoft.withValues(alpha: 0.8)),
        boxShadow: const [
          BoxShadow(
            color: AppColor.cardShadow,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: AppColor.transparent,
        child: InkWell(
          onTap: () {
            // Logic to view/download PDF would go here
          },
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColor.softBlue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf_rounded,
                    color: Colors.redAccent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'File Name',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColor.textMuted,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColor.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.search_rounded,
                    color: AppColor.primary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
