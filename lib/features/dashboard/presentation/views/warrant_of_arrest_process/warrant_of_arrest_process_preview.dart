// lib/features/dashboard/presentation/views/warrant_of_arrest_process/warrant_of_arrest_process_preview.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_cases_app_bar.dart';

class WarrantOfArrestProcessPreview extends StatelessWidget {
  const WarrantOfArrestProcessPreview({super.key, required this.sectionTitle});

  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockData = _getMockData(sectionTitle);

    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      appBar: buildInstrumentDeliveryCasesAppBar(
        context,
        title: '$sectionTitle Preview',
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
                    color: AppColor.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.gavel_rounded, color: AppColor.primary),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Warrant Records',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColor.textPrimary,
                          ),
                    ),
                    Text(
                      'Total ${mockData.length} cases in $sectionTitle',
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
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
              physics: const BouncingScrollPhysics(),
              itemCount: mockData.length,
              itemBuilder: (context, index) {
                final item = mockData[index];
                return _WarrantCaseCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getMockData(String section) {
    final baseData = [
      {
        'loan_ac': '0201604340131001',
        'ac_name': 'Vision Enterprise',
        'case_number': 'Artho-01/22',
        'claim_amount': '454348.85',
        'nature_wa': 'Artho Jari',
        'arrested_by': 'Motivational',
        'wa_status': 'Disposal',
        'ex_criteria': 'First',
        'district': 'NARAIL',
      },
      {
        'loan_ac': '0501600899514003',
        'ac_name': 'M/S Jasim Traders',
        'case_number': 'Artho-02/19(Jari-12/20)',
        'claim_amount': '1417187.81',
        'nature_wa': 'Artho Jari',
        'arrested_by': 'Motivational',
        'wa_status': 'Running',
        'ex_criteria': 'First',
        'district': 'NATORE',
      },
    ];

    // For variety, just return the same list but you could filter or modify
    return baseData;
  }
}

class _WarrantCaseCard extends StatelessWidget {
  const _WarrantCaseCard({required this.item});

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    final isRunning = item['wa_status'] == 'Running';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColor.panelBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColor.borderSoft.withValues(alpha: 0.8)),
        boxShadow: const [
          BoxShadow(
            color: AppColor.cardShadow,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header with Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColor.softBlue,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item['ac_name'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColor.textPrimary,
                        ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isRunning 
                        ? AppColor.dashboardMetricCoral.withValues(alpha: 0.1)
                        : AppColor.dashboardMetricMint.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isRunning ? AppColor.dashboardMetricCoral : AppColor.dashboardMetricMint,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    item['wa_status'] ?? '',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isRunning ? AppColor.dashboardMetricCoral : AppColor.dashboardMetricMint,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoRow(context, 'Loan A/C', item['loan_ac'] ?? '', Icons.account_balance_wallet_outlined),
                const SizedBox(height: 10),
                _buildInfoRow(context, 'Case No', item['case_number'] ?? '', Icons.folder_open_outlined),
                const SizedBox(height: 10),
                _buildInfoRow(context, 'Claim Amt', '৳ ${item['claim_amount']}', Icons.payments_outlined),
                
                const Divider(height: 24, thickness: 0.5),
                
                Row(
                  children: [
                    Expanded(child: _buildCompactInfo(context, 'Nature WA', item['nature_wa'] ?? '')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildCompactInfo(context, 'Arrested By', item['arrested_by'] ?? '')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildCompactInfo(context, 'EX Criteria', item['ex_criteria'] ?? '')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildCompactInfo(context, 'District', item['district'] ?? '')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColor.textMuted),
        const SizedBox(width: 10),
        SizedBox(
          width: 75,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const Text(':', style: TextStyle(color: AppColor.textMuted)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactInfo(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.sectionBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.borderSoft.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
