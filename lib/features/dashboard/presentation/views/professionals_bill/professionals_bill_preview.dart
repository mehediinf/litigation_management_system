// lib/features/dashboard/presentation/views/professionals_bill/professionals_bill_preview.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_cases_app_bar.dart';

class ProfessionalsBillPreview extends StatelessWidget {
  const ProfessionalsBillPreview({super.key, required this.sectionTitle});

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
                  child: const Icon(Icons.receipt_long_rounded, color: AppColor.primary),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Professional Bills',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColor.textPrimary,
                          ),
                    ),
                    Text(
                      'Total ${mockData.length} bill records found',
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
                return _BillCard(item: item);
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
        'loan_ac': '1522600664898001',
        'ac_name': 'Sultana Banijjaya Bitan',
        'case_number': 'CR-800/13(SC-15204/17)(Appeal-541/2023)',
        'bill_type': 'Lawyer Bill',
        'vendor': '12 BC LAW CHAMBERS',
        'purpose': '12(3) Auction Legal Notice',
        'date': '15-Apr-2025',
        'amount': '50',
        'remarks': '',
      },
      {
        'loan_ac': '6305603931864002',
        'ac_name': 'M/S HAZI ABDUS SALAM & SONS',
        'case_number': 'Artho-35/22',
        'bill_type': 'Lawyer Bill',
        'vendor': 'ASHFAK AHMED',
        'purpose': 'Drafting',
        'date': '21-Aug-2022',
        'amount': '2000',
        'remarks': '',
      },
      {
        'loan_ac': '6305603931864002',
        'ac_name': 'M/S HAZI ABDUS SALAM & SONS',
        'case_number': 'Artho-35/22',
        'bill_type': 'Lawyer Bill',
        'vendor': 'ASHFAK AHMED',
        'purpose': 'Filing',
        'date': '21-Aug-2022',
        'amount': '1000',
        'remarks': '',
      },
      {
        'loan_ac': '6305603931864002',
        'ac_name': 'M/S HAZI ABDUS SALAM & SONS',
        'case_number': 'Artho-35/22',
        'bill_type': 'Lawyer Bill',
        'vendor': 'ASHFAK AHMED',
        'purpose': 'Drafting of Summons Notice',
        'date': '21-Aug-2022',
        'amount': '500',
        'remarks': '',
      },
      {
        'loan_ac': '6305603931864002',
        'ac_name': 'M/S HAZI ABDUS SALAM & SONS',
        'case_number': 'Artho-35/22',
        'bill_type': 'Lawyer Bill',
        'vendor': 'ASHFAK AHMED',
        'purpose': 'Hazira',
        'date': '10-Oct-2022',
        'amount': '400',
        'remarks': '',
      },
      {
        'loan_ac': '6305603931864002',
        'ac_name': 'M/S HAZI ABDUS SALAM & SONS',
        'case_number': 'Artho-35/22',
        'bill_type': 'Lawyer Bill',
        'vendor': 'ASHFAK AHMED',
        'purpose': 'Expartee Complete',
        'date': '07-Mar-2023',
        'amount': '1200',
        'remarks': '',
      },
    ];
    return baseData;
  }
}

class _BillCard extends StatelessWidget {
  const _BillCard({required this.item});

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
                    item['bill_type'] ?? '',
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
                _buildInfoRow(context, 'Vendor', item['vendor'] ?? '', Icons.person_pin_outlined),
                
                const Divider(height: 24, thickness: 0.5),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Purpose',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColor.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['purpose'] ?? '',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColor.textPrimary,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Amount',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColor.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '৳ ${item['amount']}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColor.primaryStrong,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColor.sectionBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, size: 14, color: AppColor.textSecondary),
                      const SizedBox(width: 8),
                      Text(
                        'Activity Date:',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColor.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item['date'] ?? '',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColor.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
                if (item['remarks']?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 10),
                  _buildInfoRow(context, 'Remarks', item['remarks'] ?? '', Icons.notes_rounded),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColor.textMuted),
        const SizedBox(width: 10),
        SizedBox(
          width: 70,
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
}
