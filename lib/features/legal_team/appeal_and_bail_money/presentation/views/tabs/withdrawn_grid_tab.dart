// lib/features/legal_team/appeal_and_bail_money/presentation/views/tabs/withdrawn_grid_tab.dart

import 'package:flutter/material.dart';

import '../../widgets/status_list_view.dart';

class WithdrawnGridTab extends StatelessWidget {
  final String loanAc;
  final String caseNumber;
  final String accountName;

  const WithdrawnGridTab({
    super.key,
    this.loanAc = '',
    this.caseNumber = '',
    this.accountName = '',
  });

  static final List<Map<String, String>> _allData = [
    {
      'name': 'Bbl',
      'account': '1111111111111111',
      'case': 'Artho-133/2022',
      'date': '29/09/2025',
      'status': 'Withdrawn',
      'amount': '৳ 25,000',
    },
    {
      'name': 'Bbl',
      'account': '1111111111111111',
      'case': 'Artho-133/2022',
      'date': '30/09/2025',
      'status': 'Withdrawn',
      'amount': '৳ 30,000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return StatusListView(
      title: 'Completed Withdrawals',
      subtitle: 'Successfully processed',
      allData: _allData,
      loanAc: loanAc,
      caseNumber: caseNumber,
      accountName: accountName,
      statusColor: Colors.green.shade700,
      statusBg: Colors.green.shade50,
      headerIcon: Icons.check_circle_outline,
      headerColor: Colors.green.shade700,
      emptyMessage: 'No completed withdrawals',
    );
  }
}
