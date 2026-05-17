// lib/features/dashboard/presentation/views/case_schedule_today/case_schedule_today_preview.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import '../instrument_delivery_status_cases/instrument_delivery_cases_app_bar.dart';

class CaseScheduleTodayPreview extends StatelessWidget {
  const CaseScheduleTodayPreview({super.key, required this.selectedDate});

  final String selectedDate;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockData = _getMockData(selectedDate);

    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      appBar: buildInstrumentDeliveryCasesAppBar(
        context,
        title: 'Schedule for $selectedDate',
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
                  child: const Icon(Icons.calendar_today_rounded, color: AppColor.primary),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Schedule',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColor.textPrimary,
                          ),
                    ),
                    Text(
                      'Total ${mockData.length} cases scheduled',
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
                return _ScheduleCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getMockData(String date) {
    return [
      {
        'loan_ac': '1515603837207001',
        'ac_name': 'Md Rafikul Islam',
        'case_number': 'Artho-39/21',
        'curr_date': '17-Jul-24',
        'curr_status': 'Written Statement',
        'court_name': '2nd Joint Dist & Session Judge Court',
        'lawyer_name': 'MD SULAIMAN MIAH SWAPON',
        'district': 'Gazipur',
        'territory': 'Retail',
        'prev_remarks': '...',
      },
      {
        'loan_ac': '1502600740370002',
        'ac_name': 'Nazrul Enterprise',
        'case_number': 'CR-253/15(SC-6950/17)',
        'curr_date': '17-Jul-24',
        'curr_status': 'Witness',
        'court_name': '1st Joint Metro Session Judge Court',
        'lawyer_name': 'THE LAWYERS & JURISTS LTD',
        'district': 'Dhaka',
        'territory': 'ELEPHANT ROAD',
        'prev_remarks': '-',
      },
      {
        'loan_ac': '1529604071760002',
        'ac_name': 'M/S Tashin Enterprise',
        'case_number': 'CR-3779/21(Session Case-20732/2022)',
        'curr_date': '17-Jul-24',
        'curr_status': '',
        'court_name': '2nd Joint Metro Session Judge Court',
        'lawyer_name': 'MD. ABDUL MAZED',
        'district': 'Dhaka',
        'territory': 'MOTIJHEEL',
        'prev_remarks': 'Transfer Case',
      },
    ];
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({required this.item});

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
                if (item['curr_status']?.isNotEmpty ?? false) ...[
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
                _buildInfoRow(context, 'Lawyer', item['lawyer_name'] ?? '', Icons.person_pin_outlined),
                
                const Divider(height: 24, thickness: 0.5),

                _buildLongInfo(context, 'Court Name', item['court_name'] ?? '', Icons.account_balance_outlined),
                
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(child: _buildCompactInfo(context, 'District', item['district'] ?? '')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildCompactInfo(context, 'Territory', item['territory'] ?? '')),
                  ],
                ),
                
                if (item['prev_remarks']?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 12),
                  _buildRemarkBox(context, item['prev_remarks'] ?? ''),
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
              const SizedBox(height: 2),
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

  Widget _buildRemarkBox(BuildContext context, String remark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Previous Remarks',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.amber.shade900,
                  fontWeight: FontWeight.w700,
                  fontSize: 9,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            remark,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }
}
