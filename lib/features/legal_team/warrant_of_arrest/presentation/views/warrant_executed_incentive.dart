//lib/features/legal_team/warrant_of_arrest/presentation/views/warrant_executed_incentive.dart

import 'package:flutter/material.dart';

class ExecutedIncentivePage extends StatefulWidget {
  const ExecutedIncentivePage({super.key});

  @override
  State<ExecutedIncentivePage> createState() => _ExecutedIncentivePageState();
}

class _ExecutedIncentivePageState extends State<ExecutedIncentivePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      if (_isSearching) {
        _searchController.clear();
        _searchQuery = '';
      }
      _isSearching = !_isSearching;
    });
  }

  void _onQueryChanged(String value) {
    setState(() => _searchQuery = value);
  }

  List<Map<String, dynamic>> _filterCases(String query) {
    if (query.trim().isEmpty) return _dummyComplianceCases;
    final q = query.toLowerCase();
    return _dummyComplianceCases
        .where(
          (c) => c.values.any(
            (v) => v != null && v.toString().toLowerCase().contains(q),
          ),
        )
        .toList();
  }

  Future<void> _openAdvancedSearchDialog() async {
    String proposedType = 'Proposed Type';

    final loanAcController = TextEditingController();
    final caseNoController = TextEditingController();
    final serialNoController = TextEditingController();
    final nameController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 560),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1552B0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.tune_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _dropdownField(
                              label: 'Proposed Type',
                              value: proposedType,
                              options: [
                                'Proposed Type',
                                'Loan',
                                'New',
                                'Running',
                              ],
                              onChanged: (v) =>
                                  setLocalState(() => proposedType = v),
                            ),
                            _textField(
                              label: 'Loan A/C',
                              controller: loanAcController,
                              hint: 'Enter Loan A/C',
                            ),
                            _textField(
                              label: 'Case Number',
                              controller: caseNoController,
                              hint: 'Enter Case Number',
                            ),
                            _textField(
                              label: 'Name',
                              controller: nameController,
                              hint: 'Enter Name',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        border: Border(
                          top: BorderSide(color: Colors.grey.shade100),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setLocalState(() {
                                  proposedType = 'Proposed Type';
                                  loanAcController.clear();
                                  caseNoController.clear();
                                  serialNoController.clear();
                                  nameController.clear();
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey.shade600,
                                side: BorderSide(color: Colors.grey.shade300),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text('Reset'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: FilledButton.icon(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                final parts = <String>[];
                                if (loanAcController.text.trim().isNotEmpty) {
                                  parts.add(loanAcController.text.trim());
                                }
                                if (caseNoController.text.trim().isNotEmpty) {
                                  parts.add(caseNoController.text.trim());
                                }
                                if (serialNoController.text.trim().isNotEmpty) {
                                  parts.add(serialNoController.text.trim());
                                }
                                if (nameController.text.trim().isNotEmpty) {
                                  parts.add(nameController.text.trim());
                                }
                                if (proposedType != 'Proposed Type') {
                                  parts.add(proposedType);
                                }
                                final keyword = parts.join(' ').trim();
                                setState(() {
                                  _searchQuery = keyword;
                                  _searchController.text = keyword;
                                  _isSearching = keyword.isNotEmpty;
                                });
                              },
                              icon: const Icon(Icons.search_rounded, size: 18),
                              label: const Text('Search'),
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF1552B0),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    loanAcController.dispose();
    caseNoController.dispose();
    serialNoController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filterCases(_searchQuery);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFF1552B0),
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          transitionBuilder: (child, anim) =>
              FadeTransition(opacity: anim, child: child),
          child: _isSearching
              ? Padding(
                  key: const ValueKey('search-field'),
                  padding: const EdgeInsets.only(right: 8),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    maxLines: 1,
                    textInputAction: TextInputAction.search,
                    cursorColor: Colors.white,
                    onChanged: _onQueryChanged,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search cases...',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.65),
                        fontSize: 15,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.13),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 20,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                )
              : const Text(
                  'Executed Incentive',
                  key: ValueKey('title'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    letterSpacing: 0.2,
                  ),
                ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: IconButton(
              tooltip: 'Search',
              onPressed: _openAdvancedSearchDialog,
              icon: const Icon(Icons.search_outlined),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearching && _searchQuery.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color(0xFFE8EEF9),
              child: Row(
                children: [
                  const Icon(
                    Icons.filter_list_rounded,
                    size: 14,
                    color: Color(0xFF1552B0),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Results for: "$_searchQuery"',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1552B0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleSearch,
                    child: const Icon(
                      Icons.close_rounded,
                      size: 14,
                      color: Color(0xFF1552B0),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: filtered.length,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    itemBuilder: (context, index) {
                      final caseData = filtered[index];
                      return _ComplianceCaseCard(caseData: caseData);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Card widget — all data shown inline, no expand/collapse

class _ComplianceCaseCard extends StatelessWidget {
  const _ComplianceCaseCard({required this.caseData});

  final Map<String, dynamic> caseData;

  String _v(String key) {
    final val = caseData[key];
    if (val == null || val.toString().isEmpty) return '—';
    return val.toString();
  }

  @override
  Widget build(BuildContext context) {
    final String payment = _v('Payment');
    final bool isPaid = payment.toLowerCase() == 'paid';

    final Color accentColor = isPaid
        ? const Color(0xFF1B8A5A)
        : const Color(0xFF1552B0);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 44,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _v('Name'),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF1552B0,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _v('Type'),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1552B0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              payment.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // All info rows
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Column(
              children: [
                _infoRow(
                  Icons.pin_rounded,
                  'Pin',
                  _v('Pin'),
                  const Color(0xFF64748B),
                ),
                const SizedBox(height: 8),
                _infoRow(
                  Icons.business_rounded,
                  'Account Name',
                  _v('Account Name'),
                  const Color(0xFF1552B0),
                ),
                const SizedBox(height: 8),
                _infoRow(
                  Icons.credit_card_rounded,
                  'Account',
                  _v('Account'),
                  const Color(0xFF0F172A),
                ),
                const SizedBox(height: 8),
                _infoRow(
                  Icons.tag_rounded,
                  'Case Number',
                  _v('Case Number'),
                  const Color(0xFFD97706),
                ),
                const SizedBox(height: 8),
                _infoRow(
                  Icons.monetization_on_rounded,
                  'Amount',
                  '৳ ${_v('Amount')}',
                  const Color(0xFF7C3AED),
                ),
                const SizedBox(height: 8),
                _infoRow(
                  Icons.info_outline_rounded,
                  'Particulars',
                  _v('Particulars'),
                  const Color(0xFF0D9488),
                ),
              ],
            ),
          ),
          // Preview button
          Padding(
            padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(14),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.picture_as_pdf_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Preview Document',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.5,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: (color == const Color(0xFF7C3AED))
                      ? color
                      : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Helpers

Widget _buildEmptyState() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFFE8EEF9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.search_off_rounded,
            size: 36,
            color: Color(0xFF1552B0),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'No results found',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Try a different keyword or filter',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
        ),
      ],
    ),
  );
}

Widget _textField({
  required String label,
  required TextEditingController controller,
  String? hint,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 13),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFF7F9FD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1552B0), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
    ),
  );
}

Widget _dropdownField({
  required String label,
  required String value,
  required List<String> options,
  required ValueChanged<String> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 13),
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFF7F9FD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1552B0), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
      items: options
          .map(
            (opt) => DropdownMenuItem<String>(
              value: opt,
              child: Text(opt, style: const TextStyle(fontSize: 14)),
            ),
          )
          .toList(),
      onChanged: (next) {
        if (next != null) onChanged(next);
      },
    ),
  );
}

// Dummy data

final List<Map<String, dynamic>> _dummyComplianceCases = [
  {
    'Name': 'Super Admin',
    'Pin': '7777777',
    'Type': 'Recovery Maker',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-01/22',
    'Amount': '1000.00',
    'Particulars': '',
    'Payment': 'paid',
  },
  {
    'Name': 'name',
    'Pin': '',
    'Type': 'Others',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-01/22',
    'Amount': '1000.00',
    'Particulars': '',
    'Payment': 'paid',
  },
  {
    'Name': 'Super Admin',
    'Pin': '7777777',
    'Type': 'Recovery Maker',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-28/18',
    'Amount': '1000.00',
    'Particulars': 'sdfds',
    'Payment': 'paid',
  },
  {
    'Name': 'red',
    'Pin': '',
    'Type': 'Others',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-28/18',
    'Amount': '1000.00',
    'Particulars': '',
    'Payment': 'paid',
  },
  {
    'Name': 'Super Admin3',
    'Pin': '5555555',
    'Type': 'Recovery Maker',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-28/18',
    'Amount': '5000.00',
    'Particulars': '',
    'Payment': 'paid',
  },
  {
    'Name': 'Super Admin',
    'Pin': '7777777',
    'Type': 'Recovery Maker',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-02/19(Jari-1...)',
    'Amount': '1000.00',
    'Particulars': '',
    'Payment': 'paid',
  },
  {
    'Name': 'Super Admin',
    'Pin': '7777777',
    'Type': 'Recovery Maker',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-01/21',
    'Amount': '1000.00',
    'Particulars': '',
    'Payment': 'paid',
  },
  {
    'Name': 'red',
    'Pin': '',
    'Type': 'Others',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-01/21',
    'Amount': '3000.00',
    'Particulars': 'refdfd',
    'Payment': 'paid',
  },
  {
    'Name': 'pot',
    'Pin': '1111111',
    'Type': 'HOOPS',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-01/22',
    'Amount': '500.00',
    'Particulars': 'dsfsdf',
    'Payment': 'paid',
  },
  {
    'Name': 'Super Admin',
    'Pin': '7777777',
    'Type': 'Recovery Maker',
    'Account Name': '',
    'Account': '',
    'Case Number': 'Artho-48/19',
    'Amount': '1000.00',
    'Particulars': 'assa',
    'Payment': 'paid',
  },
];
