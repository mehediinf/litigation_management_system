// lib/features/legal_team/appeal_and_bail_money/presentation/views/tabs/deposit_data_grid_tab.dart

import 'package:flutter/material.dart';

import '../../widgets/deposit_card.dart';
import '../../widgets/empty_state.dart';

class DepositDataGridTab extends StatelessWidget {
  final String loanAc;
  final String caseNumber;
  final String accountName;

  const DepositDataGridTab({
    super.key,
    this.loanAc = '',
    this.caseNumber = '',
    this.accountName = '',
  });

  static final List<Map<String, String>> _allData = [
    {
      'name': 'Choudhuri Transport',
      'account': '5501603448162001',
      'case': 'CR-1211/17(SC-689/18)',
      'date': '08/10/2025',
      'status': 'Withdrawn',
      'amount': '৳ 50,000',
    },
    {
      'name': 'Choudhuri Transport',
      'account': '5501603448162001',
      'case': 'CR-1211/17(SC-689/18)',
      'date': '01/01/1970',
      'status': 'Withdrawn',
      'amount': '৳ 50,000',
    },
    {
      'name': 'Bbl',
      'account': '1111111111111111',
      'case': 'Artho-133/2022',
      'date': '29/09/2025',
      'status': 'Withdrawn',
      'amount': '৳ 25,000',
    },
  ];

  List<Map<String, String>> get _filteredData {
    if (loanAc.isEmpty && caseNumber.isEmpty && accountName.isEmpty) {
      return _allData;
    }

    return _allData.where((r) {
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

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Record count badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F0FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${data.length} records found',
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF1565C0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),

          if (data.isEmpty)
            EmptyState(
              icon: (loanAc.isNotEmpty ||
                      caseNumber.isNotEmpty ||
                      accountName.isNotEmpty)
                  ? Icons.search_off
                  : Icons.inbox_outlined,
              message: (loanAc.isNotEmpty ||
                      caseNumber.isNotEmpty ||
                      accountName.isNotEmpty)
                  ? 'No records match your search criteria'
                  : 'No deposit records found',
            )
          else
            ...data.map((row) => DepositCard(data: row)),
        ],
      ),
    );
  }
}
