// lib/features/dashboard/presentation/views/case_update_information/case_update_information_preview.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_cases_app_bar.dart';

class CaseUpdateInformationPreview extends StatelessWidget {
  const CaseUpdateInformationPreview({super.key, required this.sectionTitle});

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
                  child: const Icon(Icons.update_rounded, color: AppColor.primary),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Case Updates',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColor.textPrimary,
                          ),
                    ),
                    Text(
                      'Total ${mockData.length} cases found in $sectionTitle',
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
                return _CaseUpdateCard(item: item);
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
        'loan_ac': '6038465600005',
        'ac_name': 'Sardar Communication',
        'case_number': 'Artho-46/15(Jari-19/20)(Mis-36/22)',
        'prev_date': '28-Apr-26',
        'prev_step': 'Auction 33(4)',
        'next_date': 'Yet To Fix',
        'curr_status': 'Auction 33(4)',
        'deal_officer': 'Md. Faridul Islam',
        'court_name': '1st Joint Dist & Session Judge Court',
        'lawyer_name': 'SHAHEEN SIDDIQUEE',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Barishal',
      },
      {
        'loan_ac': '0501600988567002',
        'ac_name': 'Lemon Enterprise',
        'case_number': 'Artho-05/20(Jari-1/22)',
        'prev_date': '20-Nov-23',
        'prev_step': 'Next Order',
        'next_date': 'Yet To Fix',
        'curr_status': 'Next Order',
        'deal_officer': 'Md. Nurul Haque Miah',
        'court_name': '2nd Joint Dist & Session Judge Court',
        'lawyer_name': 'NIRMAL KANTI SARKER',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Pirojpur',
      },
      {
        'loan_ac': '0501601116218001',
        'ac_name': 'Baba Loknat Store',
        'case_number': 'Artho-04/11(Jari-08/14)',
        'prev_date': '17-May-15',
        'prev_step': 'Warrant Of Arrest',
        'next_date': 'Yet To Fix',
        'curr_status': 'Warrant Of Arrest',
        'deal_officer': 'Md. Abdul Mannan',
        'court_name': '1st Joint Dist & Session Judge Court',
        'lawyer_name': 'MOHAMMAD MOSTAFA ZAMAN',
        'region': 'South',
        'territory': 'FARIDPUR',
        'district': 'Faridpur',
      },
      {
        'loan_ac': '0501601263809001',
        'ac_name': 'M/S Imran Store',
        'case_number': 'Artho-08/10(Jari-01/16)',
        'prev_date': '20-Feb-23',
        'prev_step': 'Stay Order',
        'next_date': 'Yet To Fix',
        'curr_status': 'Stay Order',
        'deal_officer': 'Saidul Islam',
        'court_name': '1st Joint Dist & Session Judge Court',
        'lawyer_name': 'MD GOLAM MAWLA',
        'region': 'South',
        'territory': 'BARISAL',
        'district': 'Barguna',
      },
    ];
    return baseData;
  }
}

class _CaseUpdateCard extends StatelessWidget {
  const _CaseUpdateCard({required this.item});

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
                    item['curr_status'] ?? '',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColor.primaryStrong,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoRow(context, 'Loan A/C', item['loan_ac'] ?? '', Icons.account_balance_wallet_outlined),
                const SizedBox(height: 10),
                _buildInfoRow(context, 'Case No', item['case_number'] ?? '', Icons.folder_open_outlined),
                const SizedBox(height: 10),
                _buildInfoRow(context, 'Deal Officer', item['deal_officer'] ?? '', Icons.person_outline),
                
                const Divider(height: 24, thickness: 0.5),

                Row(
                  children: [
                    Expanded(child: _buildDateInfo(context, 'Prev Date', item['prev_date'] ?? '', Icons.event_available)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildDateInfo(context, 'Next Date', item['next_date'] ?? '', Icons.event_note)),
                  ],
                ),
                
                const SizedBox(height: 12),
                _buildLongInfo(context, 'Court', item['court_name'] ?? '', Icons.account_balance_outlined),
                const SizedBox(height: 10),
                _buildLongInfo(context, 'Lawyer', item['lawyer_name'] ?? '', Icons.gavel_rounded),
                
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildCompactTag(context, 'Region', item['region'] ?? '')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildCompactTag(context, 'Territory', item['territory'] ?? '')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildCompactTag(context, 'District', item['district'] ?? '')),
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
          width: 80,
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

  Widget _buildDateInfo(BuildContext context, String label, String date, IconData icon) {
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
            date,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLongInfo(BuildContext context, String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColor.textMuted),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColor.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactTag(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColor.textMuted,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
