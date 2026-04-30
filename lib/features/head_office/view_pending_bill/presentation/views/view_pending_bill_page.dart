//lib/features/head_office/presentation/views/view_pending_bill_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

class ViewPendingBillPage extends StatefulWidget {
  const ViewPendingBillPage({super.key});

  @override
  State<ViewPendingBillPage> createState() => _ViewPendingBillPageState();
}

class _ViewPendingBillPageState extends State<ViewPendingBillPage> {
  String _year = 'Select Year';
  String _month = 'All January';
  String _type = 'Lawyer';
  String _vendor = 'Select Lawyer';
  String _region = 'Select Region';
  String _territory = 'Select Territory';
  String _district = 'Select District';
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  static const List<String> _yearOptions = [
    'Select Year',
    '2026',
    '2025',
    '2024',
    '2023',
  ];
  static const List<String> _monthOptions = [
    'All January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  static const List<String> _typeOptions = ['Lawyer', 'Vendor'];
  static const List<String> _vendorOptions = [
    'Select Lawyer',
    'ASIF AK AHMED',
    'SHAHEN SIDDIQUE',
    'NIRMAL KANTI SARKER',
    'MONJUR ELAHI PORAG',
  ];
  static const List<String> _regionOptions = [
    'Select Region',
    'Dhaka',
    'Chittagong',
    'Rajshahi',
  ];
  static const List<String> _territoryOptions = [
    'Select Territory',
    'Elephant Road',
    'Banani',
    'Dhanmondi',
  ];
  static const List<String> _districtOptions = [
    'Select District',
    'Dhaka',
    'Narayanganj',
    'Gazipur',
  ];

  static const List<_PendingBillRow> _rows = [
    _PendingBillRow(
      sl: 1,
      vendor: 'ASIF AK AHMED',
      accountNo: '6305603931864002',
      accountName: 'M/S HAZI ABDUS SALAM & SONS',
      caseNo: 'Artho-35/22',
      legalStepDate: '21-Aug-2022',
      purpose: 'Hazira',
      amount: '400.00',
    ),
    _PendingBillRow(
      sl: 2,
      vendor: '(Proxy)',
      accountNo: '1111111111111111',
      accountName: 'Bbl',
      caseNo: 'Artho-389/2023',
      legalStepDate: '04-Jan-2024',
      purpose: 'Argument Complete',
      amount: '1,200.00',
    ),
    _PendingBillRow(
      sl: 3,
      vendor: 'SHAHEN SIDDIQUE',
      accountNo: '6038465600005',
      accountName: 'Sardar Communication',
      caseNo: 'Artha-46/15(Jari-19/20)(Mis-36/22)',
      legalStepDate: '10-Jan-2024',
      purpose: 'Appeal/Revision/Review Hearing',
      amount: '700.00',
    ),
    _PendingBillRow(
      sl: 4,
      vendor: 'NIRMAL KANTI SARKER',
      accountNo: '0501600085578001',
      accountName: 'Balaka Restaurant',
      caseNo: 'Artho-05/20(Jari-10/21)',
      legalStepDate: '03-Mar-2024',
      purpose: 'Drafting filing & Moving Petition of U/s 33(5)/33(7)',
      amount: '500.00',
    ),
    _PendingBillRow(
      sl: 5,
      vendor: 'MONJUR ELAHI PORAG',
      accountNo: '3333333333333333',
      accountName: 'asdfasdf',
      caseNo: 'HC 33333333/2025',
      legalStepDate: '26-Jun-2025',
      purpose: 'Activities',
      amount: '100.00',
    ),
    _PendingBillRow(
      sl: 6,
      vendor: 'MONJUR ELAHI PORAG',
      accountNo: '1111111111111111',
      accountName: '111',
      caseNo: 'HC-11/2025',
      legalStepDate: '26-Jun-2025',
      purpose: 'Activities',
      amount: '1,000.00',
    ),
    _PendingBillRow(
      sl: 7,
      vendor: 'MONJUR ELAHI PORAG',
      accountNo: '1111111111111111',
      accountName: '111',
      caseNo: 'HC-11/2025',
      legalStepDate: '07-Jul-2025',
      purpose: 'Activities',
      amount: '100.00',
    ),
    _PendingBillRow(
      sl: 8,
      vendor: 'MONJUR ELAHI PORAG',
      accountNo: '8888888888888888',
      accountName: 'fsadfsad',
      caseNo: 'HC-3455/2025',
      legalStepDate: '23-Jul-2025',
      purpose: 'Activities',
      amount: '5,000.00',
    ),
    _PendingBillRow(
      sl: 9,
      vendor: 'MONJUR ELAHI PORAG',
      accountNo: '8888888888888888',
      accountName: 'sadfasfd',
      caseNo: 'HC-3424/423/2025',
      legalStepDate: '23-Jul-2025',
      purpose: 'Activities',
      amount: '80.00',
    ),
    _PendingBillRow(
      sl: 10,
      vendor: '(Proxy)',
      accountNo: '1111111111111111',
      accountName: 'bbl',
      caseNo: 'Artho-133/2022',
      legalStepDate: '31-Jul-2025',
      purpose: 'Appeal/Revision Hearing for filed against BBL',
      amount: '400.00',
    ),
  ];

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  Future<void> _openSearchFilters() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search Options',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColor.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _dropdownField(
                            context: context,
                            label: 'Year',
                            value: _year,
                            options: _yearOptions,
                            onChanged: (value) => setLocalState(() => _year = value),
                          ),
                          _dropdownField(
                            context: context,
                            label: 'Month',
                            value: _month,
                            options: _monthOptions,
                            onChanged: (value) => setLocalState(() => _month = value),
                          ),
                          _dropdownField(
                            context: context,
                            label: 'Type',
                            value: _type,
                            options: _typeOptions,
                            onChanged: (value) => setLocalState(() => _type = value),
                          ),
                          _dropdownField(
                            context: context,
                            label: 'Vendor',
                            value: _vendor,
                            options: _vendorOptions,
                            onChanged: (value) => setLocalState(() => _vendor = value),
                          ),
                          _dropdownField(
                            context: context,
                            label: 'Region',
                            value: _region,
                            options: _regionOptions,
                            onChanged: (value) => setLocalState(() => _region = value),
                          ),
                          _dropdownField(
                            context: context,
                            label: 'Territory',
                            value: _territory,
                            options: _territoryOptions,
                            onChanged: (value) =>
                                setLocalState(() => _territory = value),
                          ),
                          _dropdownField(
                            context: context,
                            label: 'District',
                            value: _district,
                            options: _districtOptions,
                            onChanged: (value) =>
                                setLocalState(() => _district = value),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _dateField(
                              context: context,
                              label: 'From',
                              controller: _fromDateController,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dateField(
                              context: context,
                              label: 'To',
                              controller: _toDateController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.visibility_outlined),
                              label: const Text('Search'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    setState(() {});
  }

  Widget _dropdownField({
    required BuildContext context,
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth, // full available width
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true, // important for responsiveness
            decoration: InputDecoration(
              labelText: label,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            items: options
                .map((option) =>
                DropdownMenuItem(value: option, child: Text(option)))
                .toList(),
            onChanged: (next) {
              if (next != null) onChanged(next);
            },
          ),
        );
      },
    );
  }

  Widget _dateField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'dd/mm/yyyy',
        prefixIcon: const Icon(Icons.calendar_month_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );
        if (picked != null) {
          controller.text =
              '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
        }
      },
    );
  }

  String _formatAmount(double value) {
    final fixed = value.toStringAsFixed(2);
    final parts = fixed.split('.');
    final chars = parts[0].split('').reversed.toList();
    final grouped = <String>[];
    for (var i = 0; i < chars.length; i++) {
      grouped.add(chars[i]);
      if ((i + 1) % 3 == 0 && i + 1 != chars.length) {
        grouped.add(',');
      }
    }
    return '${grouped.reversed.join()}'.trim() + '.${parts[1]}';
  }

  Widget _statCard({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColor.borderSoft),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColor.sectionBgBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColor.primary),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColor.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _billCard(BuildContext context, _PendingBillRow row) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.borderSoft),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.sectionBgBlue,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'SL ${row.sl}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.primary,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  row.vendor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'BDT ${row.amount}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColor.primary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _infoLine(
            context: context,
            icon: Icons.account_balance_wallet_outlined,
            label: 'Account No',
            value: row.accountNo,
          ),
          const SizedBox(height: 6),
          _infoLine(
            context: context,
            icon: Icons.person_outline_rounded,
            label: 'Account Name',
            value: row.accountName,
          ),
          const SizedBox(height: 6),
          _infoLine(
            context: context,
            icon: Icons.gavel_rounded,
            label: 'Case No',
            value: row.caseNo,
          ),
          const SizedBox(height: 6),
          _infoLine(
            context: context,
            icon: Icons.event_note_outlined,
            label: 'Legal Step Date',
            value: row.legalStepDate,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.sectionBgBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Purpose',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColor.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  row.purpose,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoLine({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColor.primary),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColor.textPrimary,
                    height: 1.35,
                  ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = _rows.fold<double>(
      0,
      (sum, item) => sum + (double.tryParse(item.amount.replaceAll(',', '')) ?? 0),
    );
    final totalAmountText = _formatAmount(totalAmount);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        toolbarHeight: 76,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F3E8A), Color(0xFF1A5FD0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'View Pending Bill',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
            Text(
              '${_rows.length} pending bill records',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.88),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Search options',
            onPressed: _openSearchFilters,
            icon: const Icon(Icons.search_rounded, color: Colors.white),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                _statCard(
                  context: context,
                  label: 'Total Bills',
                  value: '${_rows.length}',
                  icon: Icons.list_alt_rounded,
                ),
                const SizedBox(width: 10),
                _statCard(
                  context: context,
                  label: 'Total Amount',
                  value: totalAmountText,
                  icon: Icons.account_balance_wallet_outlined,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _rows.length,
                itemBuilder: (context, index) => _billCard(context, _rows[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingBillRow {
  const _PendingBillRow({
    required this.sl,
    required this.vendor,
    required this.accountNo,
    required this.accountName,
    required this.caseNo,
    required this.legalStepDate,
    required this.purpose,
    required this.amount,
  });

  final int sl;
  final String vendor;
  final String accountNo;
  final String accountName;
  final String caseNo;
  final String legalStepDate;
  final String purpose;
  final String amount;
}
