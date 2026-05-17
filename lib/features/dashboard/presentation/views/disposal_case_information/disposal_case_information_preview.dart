// lib/features/dashboard/presentation/views/disposal_case_information/disposal_case_information_preview.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_cases_app_bar.dart';

class DisposalCaseInformationPreview extends StatelessWidget {
  const DisposalCaseInformationPreview({super.key, required this.sectionTitle});

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
                  child: const Icon(
                    Icons.list_alt_rounded,
                    color: AppColor.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Case List',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColor.textPrimary,
                      ),
                    ),
                    Text(
                      'Total ${mockData.length} records found',
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
                return _CasePreviewCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getMockData(String section) {
    // Basic data from image
    final baseData = [
      {
        'sl': '1',
        'type': 'Loan',
        'ac': '6038465600005',
        'name': 'Sardar Communication',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Barishal',
      },
      {
        'sl': '2',
        'type': 'Loan',
        'ac': '0201600968418001',
        'name': 'Joyma Enterprise',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '3',
        'type': 'Loan',
        'ac': '0201601566415001',
        'name': 'Sabbir Store',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '4',
        'type': 'Loan',
        'ac': '0201601620680003',
        'name': 'M/S R M N Enterprise',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '5',
        'type': 'Loan',
        'ac': '0201601620686003',
        'name': 'Shanonda Enterprise',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '6',
        'type': 'Loan',
        'ac': '0201601705009004',
        'name': 'Atul Vander',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '7',
        'type': 'Loan',
        'ac': '0201601898196003',
        'name': "Ranu Brick'S Fild",
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '8',
        'type': 'Loan',
        'ac': '0201602165320005',
        'name': 'Biprojit Enterprise',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '9',
        'type': 'Loan',
        'ac': '0201602190620001',
        'name': 'Madhabi Traders',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '10',
        'type': 'Loan',
        'ac': '0201602848853005',
        'name': 'Universal Telecom',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '11',
        'type': 'Loan',
        'ac': '0201602929849004',
        'name': 'Sulov Furniture',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '12',
        'type': 'Loan',
        'ac': '0201603026775005',
        'name': 'M/S Alvi Traders',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '13',
        'type': 'Loan',
        'ac': '0201603079995002',
        'name': 'Olshi Photostart',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
      {
        'sl': '14',
        'type': 'Loan',
        'ac': '0201603079998005',
        'name': 'M/S.Firoza Traders',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Bagerhat',
      },
    ];

    if (section == 'ARA') return baseData;
    if (section == 'NI ACT') return baseData.take(5).toList();
    if (section == 'Others') return baseData.skip(10).toList();
    return baseData; // Total or default
  }
}

class _CasePreviewCard extends StatelessWidget {
  const _CasePreviewCard({required this.item});

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
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
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColor.softBlue,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '#${item['sl']}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColor.primaryStrong,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item['name'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColor.textPrimary,
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
                _buildRow(
                  context,
                  'A/C Number',
                  item['ac'] ?? '',
                  Icons.account_balance_wallet_outlined,
                ),
                const SizedBox(height: 12),
                _buildRow(
                  context,
                  'Proposed Type',
                  item['type'] ?? '',
                  Icons.category_outlined,
                ),
                const Divider(height: 24, thickness: 0.5),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoBox(
                        context,
                        'Region',
                        item['region'] ?? '',
                        Icons.map_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoBox(
                        context,
                        'District',
                        item['district'] ?? '',
                        Icons.location_on_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInfoBox(
                  context,
                  'Territory',
                  item['territory'] ?? '',
                  Icons.domain_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColor.textMuted),
        const SizedBox(width: 10),
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColor.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
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

  Widget _buildInfoBox(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.sectionBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.borderSoft.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: AppColor.primary.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
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
