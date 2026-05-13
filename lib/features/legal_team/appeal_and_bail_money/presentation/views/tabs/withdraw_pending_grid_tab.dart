// lib/features/legal_team/appeal_and_bail_money/presentation/views/tabs/withdraw_pending_grid_tab.dart

import 'package:flutter/material.dart';
import '../../widgets/status_list_view.dart';

class WithdrawPendingGridTab extends StatelessWidget {
  final String loanAc;
  final String caseNumber;
  final String accountName;

  const WithdrawPendingGridTab({
    super.key,
    this.loanAc = '',
    this.caseNumber = '',
    this.accountName = '',
  });

  static final List<Map<String, String>> _allData = [
    {
      'name': 'Choudhuri Transport',
      'account': '5501603448162001',
      'case': 'CR-1211/17',
      'date': '08/10/2025',
      'status': 'Pending',
      'amount': '৳ 50,000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return StatusListView(
      title: 'Pending Withdrawals',
      subtitle: 'Awaiting approval',
      allData: _allData,
      loanAc: loanAc,
      caseNumber: caseNumber,
      accountName: accountName,
      statusColor: Colors.orange.shade700,
      statusBg: Colors.orange.shade50,
      headerIcon: Icons.hourglass_empty_rounded,
      headerColor: Colors.orange.shade700,
      emptyMessage: 'No pending withdrawals',
    );
  }
}
