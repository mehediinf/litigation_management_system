// lib/features/legal_team/appeal_and_bail_money/presentation/views/widgets/status_list_view.dart

import 'package:flutter/material.dart';
import 'info_chip.dart';
import 'empty_state.dart';

class StatusListView extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Map<String, String>> allData;
  final String loanAc;
  final String caseNumber;
  final String accountName;
  final Color statusColor;
  final Color statusBg;
  final IconData headerIcon;
  final Color headerColor;
  final String emptyMessage;

  const StatusListView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.allData,
    this.loanAc = '',
    this.caseNumber = '',
    this.accountName = '',
    required this.statusColor,
    required this.statusBg,
    required this.headerIcon,
    required this.headerColor,
    required this.emptyMessage,
  });

  List<Map<String, String>> get _filteredData {
    if (loanAc.isEmpty && caseNumber.isEmpty && accountName.isEmpty) {
      return allData;
    }

    return allData.where((r) {
      final matchLoan = loanAc.isEmpty ||
          r['account']!.toLowerCase().contains(loanAc.toLowerCase());
      final matchCase = caseNumber.isEmpty ||
          r['case']!.toLowerCase().contains(caseNumber.toLowerCase());
      final matchName = accountName.isEmpty ||
          r['name']!.toLowerCase().contains(accountName.toLowerCase());

      return matchLoan && matchCase && matchName;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final data = _filteredData;
    final total = data.fold<int>(0, (sum, row) {
      final raw = row['amount']!.replaceAll(RegExp(r'[৳,\s]'), '');
      return sum + (int.tryParse(raw) ?? 0);
    });

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [headerColor.withOpacity(0.85), headerColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(headerIcon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${data.length} records',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      '৳ ${_formatAmount(total)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          if (data.isEmpty)
            EmptyState(
              icon: (loanAc.isNotEmpty ||
                      caseNumber.isNotEmpty ||
                      accountName.isNotEmpty)
                  ? Icons.search_off
                  : headerIcon,
              message: (loanAc.isNotEmpty ||
                      caseNumber.isNotEmpty ||
                      accountName.isNotEmpty)
                  ? 'No records match your search criteria'
                  : emptyMessage,
            )
          else
            ...data.map(
              (row) => _StatusCard(
                data: row,
                statusColor: statusColor,
                statusBg: statusBg,
              ),
            ),
        ],
      ),
    );
  }

  String _formatAmount(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}

class _StatusCard extends StatelessWidget {
  final Map<String, String> data;
  final Color statusColor;
  final Color statusBg;

  const _StatusCard({
    required this.data,
    required this.statusColor,
    required this.statusBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: statusColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name']!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data['account']!,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data['amount']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor.withOpacity(0.4)),
                      ),
                      child: Text(
                        data['status']!,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 9),
            const Divider(height: 1),
            const SizedBox(height: 9),
            Row(
              children: [
                Expanded(
                  child: InfoChip(
                    icon: Icons.gavel_outlined,
                    label: 'Case No.',
                    value: data['case']!,
                  ),
                ),
                const SizedBox(width: 16),
                InfoChip(
                  icon: Icons.calendar_today_outlined,
                  label: 'Date',
                  value: data['date']!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
