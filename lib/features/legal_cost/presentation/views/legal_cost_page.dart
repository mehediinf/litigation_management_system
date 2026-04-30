//lib/features/legal_cost/presentation/views/legal_cost_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

class LegalCostPage extends StatelessWidget {
  const LegalCostPage({
    super.key,
    this.searchQuery = '',
  });

  final String searchQuery;

  static const List<_LegalCostEntry> _entries = [
    _LegalCostEntry(
      loanAccount: '1111111111111111',
      caseType: 'ARA-2003',
      accountName: 'BBL1',
      caseNumber: 'ara-2022',
      vendorName: '-',
      activities: 'Null',
      activityDate: '08-Aug-2022',
      amount: 1200,
    ),
    _LegalCostEntry(
      loanAccount: '1502600891523001',
      caseType: 'ARA-2003',
      accountName: 'Alamgir',
      caseNumber: 'Artho-471/20(Jari-253/22)',
      vendorName: '-',
      activities: 'Null',
      activityDate: '03-Oct-2022',
      amount: 4200,
    ),
    _LegalCostEntry(
      loanAccount: '1502602456821011',
      caseType: 'ARA-2003',
      accountName: 'Connect Corporation',
      caseNumber: 'Artho-879/19(Jati-203/22)',
      vendorName: '-',
      activities: 'Null',
      activityDate: '03-Oct-2022',
      amount: 5000,
    ),
    _LegalCostEntry(
      loanAccount: '1504600291027004',
      caseType: 'ARA-2003',
      accountName: 'Sarna Garments',
      caseNumber: 'Artho-517/20(Jari-232/22)',
      vendorName: '-',
      activities: 'Null',
      activityDate: '03-Oct-2022',
      amount: 4200,
    ),
    _LegalCostEntry(
      loanAccount: '1506600372230001',
      caseType: 'ARA-2003',
      accountName: 'Ornet',
      caseNumber: 'Artho-1024/19(Jari-213/22)',
      vendorName: '-',
      activities: 'Null',
      activityDate: '03-Oct-2022',
      amount: 6000,
    ),
    _LegalCostEntry(
      loanAccount: '1506600373562001',
      caseType: 'ARA-2003',
      accountName: 'Fashion Bangla',
      caseNumber: 'Artho-1223/19(Jari-212/22)',
      vendorName: '-',
      activities: 'Null',
      activityDate: '03-Oct-2022',
      amount: 6000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = searchQuery.trim().toLowerCase();
    final filteredEntries = normalizedQuery.isEmpty
        ? _entries
        : _entries.where((entry) => entry.matches(normalizedQuery)).toList();
    final totalAmount = filteredEntries.fold<double>(
      0,
      (sum, entry) => sum + entry.amount,
    );
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width < 380 ? 16.0 : 18.0;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 32),
      children: [
        _SectionTitle(
          title: 'Activity Records',
          subtitle: normalizedQuery.isEmpty
              ? '${filteredEntries.length} visible entries from your provided data'
              : '${filteredEntries.length} matching records for "$searchQuery"',
        ),
        const SizedBox(height: 12),
        if (filteredEntries.isEmpty)
          const _EmptySearchState()
        else
          ...filteredEntries.map((entry) => _EntryCard(entry: entry)),
      ],
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _LegalCostTokens.textSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: _LegalCostTokens.textPrimary,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: _LegalCostTokens.textPrimary,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _LegalCostTokens.textSecondary,
              ),
        ),
      ],
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.entry,
  });

  final _LegalCostEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _LegalCostTokens.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _LegalCostTokens.border),
        boxShadow: _LegalCostTokens.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _LegalCostTokens.softBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  color: _LegalCostTokens.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.accountName,
                            style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: _LegalCostTokens.textPrimary,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _LegalCostTokens.caseTypeBg,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            entry.caseType,
                            style:
                                Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: _LegalCostTokens.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.caseNumber,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: _LegalCostTokens.textSecondary,
                            height: 1.35,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            decoration: BoxDecoration(
              color: _LegalCostTokens.amountBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _LegalCostTokens.amountBorder),
            ),
            child: Row(
              children: [
                const Text(
                  'Amount',
                  style: TextStyle(
                    color: _LegalCostTokens.amountTextMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  entry.formattedAmount,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: _LegalCostTokens.amountText,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: _LegalCostTokens.divider),
          const SizedBox(height: 14),
          _LabeledValueRow(label: 'Loan A/C', value: entry.loanAccount),
          const SizedBox(height: 10),
          _LabeledValueRow(label: 'Case Type', value: entry.caseType),
          const SizedBox(height: 10),
          _LabeledValueRow(label: 'Account Name', value: entry.accountName),
          const SizedBox(height: 10),
          _LabeledValueRow(label: 'Case Number', value: entry.caseNumber),
          const SizedBox(height: 10),
          _LabeledValueRow(label: 'Vendor Name', value: entry.vendorName),
          const SizedBox(height: 10),
          _LabeledValueRow(label: 'Activities', value: entry.activities),
          const SizedBox(height: 10),
          _LabeledValueRow(
            label: 'Activities Date',
            value: entry.activityDate,
          ),
        ],
      ),
    );
  }
}

class _LabeledValueRow extends StatelessWidget {
  const _LabeledValueRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _LegalCostTokens.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: _LegalCostTokens.textPrimary,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
          ),
        ),
      ],
    );
  }
}

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _LegalCostTokens.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _LegalCostTokens.border),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _LegalCostTokens.softBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: _LegalCostTokens.primary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No matching record found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: _LegalCostTokens.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try searching by account name, loan account, case number, or activity date.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: _LegalCostTokens.textSecondary,
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}

class _LegalCostEntry {
  const _LegalCostEntry({
    required this.loanAccount,
    required this.caseType,
    required this.accountName,
    required this.caseNumber,
    required this.vendorName,
    required this.activities,
    required this.activityDate,
    required this.amount,
  });

  final String loanAccount;
  final String caseType;
  final String accountName;
  final String caseNumber;
  final String vendorName;
  final String activities;
  final String activityDate;
  final double amount;

  String get formattedAmount => 'BDT ${amount.toStringAsFixed(2)}';

  bool matches(String query) {
    return [
      loanAccount,
      caseType,
      accountName,
      caseNumber,
      vendorName,
      activities,
      activityDate,
      formattedAmount,
    ].any((value) => value.toLowerCase().contains(query));
  }
}

class _LegalCostTokens {
  static const Color primary = AppColor.primary;
  static const Color surface = AppColor.panelBg;
  static const Color softBlue = AppColor.softBlueAlt;
  static const Color border = AppColor.legalCostBorder;
  static const Color divider = AppColor.legalCostDivider;
  static const Color textPrimary = AppColor.legalCostTextPrimary;
  static const Color textSecondary = AppColor.legalCostTextSecondary;
  static const Color amountBg = AppColor.legalCostAmountBg;
  static const Color amountBorder = AppColor.legalCostAmountBorder;
  static const Color amountText = AppColor.legalCostAmountText;
  static const Color amountTextMuted = AppColor.legalCostAmountTextMuted;
  static const Color caseTypeBg = AppColor.legalCostCaseTypeBg;

  static const List<BoxShadow> softShadow = AppColor.legalCostShadowList;
}
