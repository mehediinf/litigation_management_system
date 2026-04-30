//lib/features/head_office/supreme_court_matter/presentation/views/case_details.dart

import 'package:flutter/material.dart';

class CaseDetailsPage extends StatefulWidget {
  const CaseDetailsPage({super.key});

  @override
  State<CaseDetailsPage> createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
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
    if (query.trim().isEmpty) return _dummySupremeCases;
    final q = query.toLowerCase();
    return _dummySupremeCases
        .where((c) => c.values.any((v) => v != null && v.toString().toLowerCase().contains(q)))
        .toList();
  }

  Future<void> _openAdvancedSearchDialog() async {
    String division = _divisionOptions.first;
    String category = _categoryOptions.first;
    String caseType = _caseTypeOptions.first;
    String proposedType = _proposedTypeOptions.first;

    final acOrCardController = TextEditingController();
    final caseNoController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              elevation: 0,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 560),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.72,
                  child: Column(
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
                              child: const Icon(Icons.tune_rounded, color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Advanced Search',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(dialogContext).pop(),
                              icon: const Icon(Icons.close_rounded, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sectionLabel('Case Information'),
                              const SizedBox(height: 10),
                              _dropdownField(
                                label: 'Division',
                                value: division,
                                options: _divisionOptions,
                                onChanged: (v) => setLocalState(() => division = v),
                              ),
                              _dropdownField(
                                label: 'Category',
                                value: category,
                                options: _categoryOptions,
                                onChanged: (v) => setLocalState(() => category = v),
                              ),
                              _dropdownField(
                                label: 'Types',
                                value: caseType,
                                options: _caseTypeOptions,
                                onChanged: (v) => setLocalState(() => caseType = v),
                              ),
                              _dropdownField(
                                label: 'Proposed Type',
                                value: proposedType,
                                options: _proposedTypeOptions,
                                onChanged: (v) => setLocalState(() => proposedType = v),
                              ),
                              _textField(label: 'A/C or Card', controller: acOrCardController, hint: 'Case Number'),
                              _textField(label: 'Case Number', controller: caseNoController),
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
                          border: Border(top: BorderSide(color: Colors.grey.shade100)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(dialogContext).pop(),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.grey.shade600,
                                  side: BorderSide(color: Colors.grey.shade300),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                                  if (division != _divisionOptions.first) parts.add(division);
                                  if (category != _categoryOptions.first) parts.add(category);
                                  if (caseType != _caseTypeOptions.first) parts.add(caseType);
                                  if (proposedType != _proposedTypeOptions.first) parts.add(proposedType);
                                  if (acOrCardController.text.trim().isNotEmpty) {
                                    parts.add(acOrCardController.text.trim());
                                  }
                                  if (caseNoController.text.trim().isNotEmpty) {
                                    parts.add(caseNoController.text.trim());
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
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                              ),
                            ),
                          ],
                        ),
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

    acOrCardController.dispose();
    caseNoController.dispose();
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
          transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
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
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Search cases...',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.65), fontSize: 15),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.13),
                prefixIcon: Icon(Icons.search_rounded, color: Colors.white.withValues(alpha: 0.8), size: 20),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.5), width: 1),
                ),
              ),
            ),
          )
              : const Text(
            'Supreme Court Matter Details',
            key: ValueKey('title'),
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, letterSpacing: 0.2),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 4),
            child: IconButton(
              tooltip: _isSearching ? 'Close search' : 'Search',
              onPressed: _toggleSearch,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded, key: ValueKey(_isSearching)),
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: IconButton(
              tooltip: 'Advanced search',
              onPressed: _openAdvancedSearchDialog,
              icon: const Icon(Icons.tune_rounded),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  const Icon(Icons.filter_list_rounded, size: 14, color: Color(0xFF1552B0)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Results for: "$_searchQuery"',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF1552B0), fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleSearch,
                    child: const Icon(Icons.close_rounded, size: 14, color: Color(0xFF1552B0)),
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
                return _SupremeCaseCard(caseData: caseData);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SupremeCaseCard extends StatefulWidget {
  const _SupremeCaseCard({required this.caseData});

  final Map<String, dynamic> caseData;

  @override
  State<_SupremeCaseCard> createState() => _SupremeCaseCardState();
}

class _SupremeCaseCardState extends State<_SupremeCaseCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _ctrl;
  late final Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    _expandAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    _isExpanded ? _ctrl.forward() : _ctrl.reverse();
  }

  String _v(String key) {
    final val = widget.caseData[key];
    if (val == null || val.toString().isEmpty) return '—';
    return val.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSpecialStatus = widget.caseData['Status']?.toString().contains('Received') ?? false;
    final Color accentColor = isSpecialStatus ? const Color(0xFF1B8A5A) : const Color(0xFF1552B0);

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
        children: [
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: _toggle,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                          child: Text(
                            _v('A/C NAME'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _infoRow(Icons.tag_rounded, 'Case No', _v('CASE NO'), accentColor),
                    const SizedBox(height: 8),
                    _infoRow(Icons.credit_card_rounded, 'A/C Number', _v('A/C NO'), accentColor),
                    const SizedBox(height: 8),
                    _infoRow(Icons.account_balance_rounded, 'Division', _v('Division'), const Color(0xFF1552B0)),
                    const SizedBox(height: 8),
                    _infoRow(
                      Icons.monetization_on_rounded,
                      'Claim Amount',
                      '৳ ${_v('Case Claim')}',
                      const Color(0xFF7C3AED),
                    ),
                    const SizedBox(height: 8),
                    _infoRow(Icons.event_rounded, 'Filing Date', _v('Filing Date'), const Color(0xFFD97706)),
                    const SizedBox(height: 8),
                    _infoRow(Icons.person_rounded, 'Lawyer Name', _v('Lawyer Name'), const Color(0xFF0D9488)),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _actionBtn(
                          Icons.file_open,
                          'Preview',
                          const Color(0xFFEF4444),
                          const Color(0xFFFEE2E2),
                              () {},
                        ),
                        const Spacer(),
                        _expandBtn(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: _expandAnim,
            child: Column(
              children: [
                Divider(height: 1, color: Colors.grey.shade100),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHead('Case Classification', Icons.description_outlined),
                      const SizedBox(height: 12),
                      _labelValueList([
                        ('Sl', _v('Sl')),
                        ('Case Category', _v('Case Category')),
                        ('Case Types', _v('Case Types')),
                        ('Filing Date', _v('Filing Date')),
                        ('Claim Amount', '৳ ${_v('Case Claim')}'),
                        ('Portfolio', _v('Portfolio')),
                        ('District', _v('NAME OF DIST')),
                        ('Lawyer Name', _v('Lawyer Name')),
                      ]),
                      _divider(),
                      _sectionHead('Status & Last Activities', Icons.history_rounded),
                      const SizedBox(height: 12),
                      _statusCard(),
                      _divider(),
                      _sectionHead('Legal Cost Information', Icons.account_balance_wallet_rounded),
                      const SizedBox(height: 12),
                      _legalCostCard(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
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
                  color: (color == const Color(0xFFD97706) || color == const Color(0xFF7C3AED))
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

  Widget _actionBtn(IconData icon, String label, Color color, Color bg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandBtn() {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE8EEF9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isExpanded ? 'Collapse' : 'View Details',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1552B0),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: const Color(0xFF1552B0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHead(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EEF9),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, size: 14, color: const Color(0xFF1552B0)),
        ),
        const SizedBox(width: 9),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Color(0xFF334155),
          ),
        ),
      ],
    );
  }

  Widget _labelValueList(List<(String, String)> items) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final (label, value) = items[i];
          final isLast = i == items.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 14,
                  endIndent: 14,
                  color: Colors.grey.shade100,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _statusCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDE5F7)),
      ),
      child: Column(
        children: [
          _statusRow(
            icon: Icons.info_outline_rounded,
            label: 'Status',
            value: _v('Status'),
            iconColor: const Color(0xFF1552B0),
          ),
          Divider(height: 1, indent: 14, endIndent: 14, color: Colors.grey.shade100),
          _statusRow(
            icon: Icons.task_alt_rounded,
            label: 'Last Activity',
            value: _v('LAST ACTIVITIES'),
            iconColor: const Color(0xFF0D9488),
          ),
          Divider(height: 1, indent: 14, endIndent: 14, color: Colors.grey.shade100),
          _statusRow(
            icon: Icons.gavel_rounded,
            label: 'Cause of Action',
            value: _v('PRESENT CAUSE OF ACTION'),
            iconColor: const Color(0xFF7C3AED),
          ),
        ],
      ),
    );
  }

  // Legal Cost Card with Legal Cost + Legal as per (last updated date)
  Widget _legalCostCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDE5F7)),
      ),
      child: Column(
        children: [
          _statusRow(
            icon: Icons.account_balance_wallet_rounded,
            label: 'Legal Cost',
            value: '৳ ${_v('Legal Cost')}',
            iconColor: const Color(0xFF059669),
          ),
          Divider(height: 1, indent: 14, endIndent: 14, color: Colors.grey.shade100),
          _statusRow(
            icon: Icons.update_rounded,
            label: 'Legal as per\n(last updated)',
            value: _v('Legal Last Updated'),
            iconColor: const Color(0xFFD97706),
          ),
        ],
      ),
    );
  }

  Widget _statusRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: iconColor),
          const SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Divider(height: 1, color: Colors.grey.shade100),
    );
  }
}

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
          child: const Icon(Icons.search_off_rounded, size: 36, color: Color(0xFF1552B0)),
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

Widget _sectionLabel(String label) {
  return Text(
    label.toUpperCase(),
    style: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w800,
      color: Color(0xFF1552B0),
      letterSpacing: 1.0,
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1552B0), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1552B0), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      items: options.map((opt) => DropdownMenuItem<String>(value: opt, child: Text(opt, style: const TextStyle(fontSize: 14)))).toList(),
      onChanged: (next) {
        if (next != null) onChanged(next);
      },
    ),
  );
}

const List<String> _divisionOptions = [
  'Select Division',
  'High Court Division',
  'Appellate Division',
];

const List<String> _categoryOptions = [
  'Select Case Category',
  'Civil Appeal',
  'Criminal Appeal',
  'Writ Petition',
];

const List<String> _caseTypeOptions = [
  'Select Case Type',
  'First Appeal',
  'First Misc Appeal',
  'Civil Revision',
];

const List<String> _proposedTypeOptions = [
  'Proposed Type',
  'New',
  'Running',
  'Closed',
];



final List<Map<String, dynamic>> _dummySupremeCases = [
  {
    'Sl': '1',
    'Division': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Types': 'First Appeal',
    'CASE NO': 'HC-333333/2025',
    'A/C NO': '1111111111111111',
    'A/C NAME': 'Bbl',
    'Portfolio': 'Retail',
    'Case Claim': '333.00',
    'Filing Date': '16-10-2025',
    'NAME OF DIST': 'Bagerhat',
    'Lawyer Name': 'MONJUR ELAHI PORAG',
    'Status': 'Received Rule Copy From High Court',
    'LAST ACTIVITIES': 'asdf',
    'PRESENT CAUSE OF ACTION': 'asdfsa',
    'Legal Cost': '0.00',
    'Legal Last Updated': '31-Mar-26 12:25 PM',
  },
  {
    'Sl': '2',
    'Division': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Types': 'First Appeal',
    'CASE NO': 'HC-3382/2025(HC-1/2025)',
    'A/C NO': '1111111111111111',
    'A/C NAME': 'asdfsdf',
    'Portfolio': 'Corporate',
    'Case Claim': '0.00',
    'Filing Date': '15-10-2025',
    'NAME OF DIST': 'Bagerhat',
    'Lawyer Name': 'MONJUR ELAHI PORAG',
    'Status': 'Power/Authorization Submission',
    'LAST ACTIVITIES': 'sf',
    'PRESENT CAUSE OF ACTION': 'asdfsdf',
    'Legal Cost': '0.00',
    'Legal Last Updated': '23-Nov-25 06:36 PM',
  },
  {
    'Sl': '3',
    'Division': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Types': 'First Misc Appeal',
    'CASE NO': 'HC-333/2025(HC-1/2025)',
    'A/C NO': '1111111111111111',
    'A/C NAME': 'safsad',
    'Portfolio': 'Corporate',
    'Case Claim': '0.00',
    'Filing Date': '15-10-2025',
    'NAME OF DIST': 'Bagerhat',
    'Lawyer Name': 'MONJUR ELAHI PORAG',
    'Status': 'Obtained Judgment & Judgment Copy',
    'LAST ACTIVITIES': 'asdf',
    'PRESENT CAUSE OF ACTION': 'asdf',
    'Legal Cost': '0.00',
    'Legal Last Updated': '23-Nov-25 06:36 PM',
  },
  {
    'Sl': '4',
    'Division': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Types': 'First Appeal',
    'CASE NO': 'HC-3333333333/2025',
    'A/C NO': '1111111111111111',
    'A/C NAME': 'asdf',
    'Portfolio': 'Corporate',
    'Case Claim': '333.00',
    'Filing Date': '08-10-2025',
    'NAME OF DIST': 'Bagerhat',
    'Lawyer Name': 'MONJUR ELAHI PORAG',
    'Status': 'Received Rule Copy From High Court',
    'LAST ACTIVITIES': 'sdf',
    'PRESENT CAUSE OF ACTION': 'asdfasdf',
    'Legal Cost': '1000.00',
    'Legal Last Updated': '31-Mar-26 12:25 PM',
  },
];