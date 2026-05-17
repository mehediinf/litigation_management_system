// lib/features/dashboard/presentation/views/appeal_bail_money_recovery/appeal_bail_money_recovery_preview.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_cases_app_bar.dart';

class AppealBailMoneyRecoveryPreview extends StatelessWidget {
  const AppealBailMoneyRecoveryPreview({super.key, required this.sectionTitle});

  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockData = _getMockData(sectionTitle);

    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      appBar: buildInstrumentDeliveryCasesAppBar(
        context,
        title: '${sectionTitle.replaceAll('\n', ' ').trim()} Preview',
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
                  child: const Icon(Icons.payments_rounded, color: AppColor.primary),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recovery Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColor.textPrimary,
                          ),
                    ),
                    Text(
                      'Total ${mockData.length} recovery records',
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
                return _RecoveryCard(item: item);
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
        'loan_ac': '0501600072651001',
        'ac_name': 'M/S Akbar Enterprize',
        'case_number': 'Artho-01/15',
        'deposit_amount': '1000000.00',
        'type': 'Bail Money',
        'deposit_date': '01/08/2022',
        'arrested': 'Yes',
        'region': 'South',
        'district': 'NOAKHALI',
      },
      {
        'loan_ac': '0201604534100001',
        'ac_name': 'M/S Bilkis Enterprise',
        'case_number': 'Artho-23/22',
        'deposit_amount': '100000.00',
        'type': 'Bail Money',
        'deposit_date': '01/08/2022',
        'arrested': 'Yes',
        'region': 'South',
        'district': 'NARAIL',
      },
      {
        'loan_ac': '0702601054345003',
        'ac_name': 'Noy Mile Machineries',
        'case_number': 'Artho-50/22',
        'deposit_amount': '3750000.00',
        'type': 'Bail Money',
        'deposit_date': '15/03/2023',
        'arrested': 'Yes',
        'region': 'North',
        'district': 'JOYPURHAT',
      },
      {
        'loan_ac': '1111111111111111',
        'ac_name': 'Bbl',
        'case_number': 'Artho-133/2022',
        'deposit_amount': '450000.00',
        'type': 'Bail Money',
        'deposit_date': '29/09/2025',
        'arrested': 'No',
        'region': 'Central',
        'district': 'NARAIL',
      },
    ];
    return baseData;
  }
}

class _RecoveryCard extends StatelessWidget {
  const _RecoveryCard({required this.item});

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    final isArrested = item['arrested'] == 'Yes';

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
          // Header with Type Badge
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
                    color: AppColor.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['type'] ?? '',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColor.primaryStrong,
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
                _buildInfoRow(context, 'Deposit Date', item['deposit_date'] ?? '', Icons.calendar_today_outlined),
                
                const Divider(height: 24, thickness: 0.5),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Deposit Amount',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColor.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '৳ ${item['deposit_amount']}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColor.primaryStrong,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isArrested 
                            ? AppColor.dashboardMetricRed.withValues(alpha: 0.1)
                            : AppColor.textMuted.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isArrested ? Icons.person_off_rounded : Icons.person_outline_rounded,
                            size: 14,
                            color: isArrested ? AppColor.dashboardMetricRed : AppColor.textMuted,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isArrested ? 'Arrested' : 'Not Arrested',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: isArrested ? AppColor.dashboardMetricRed : AppColor.textMuted,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildCompactTag(context, 'Region', item['region'] ?? '', Icons.map_outlined)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildCompactTag(context, 'District', item['district'] ?? '', Icons.location_on_outlined)),
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
          width: 85,
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

  Widget _buildCompactTag(BuildContext context, String label, String value, IconData icon) {
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
          Row(
            children: [
              Icon(icon, size: 12, color: AppColor.primary.withValues(alpha: 0.6)),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColor.textSecondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
              ),
            ],
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
