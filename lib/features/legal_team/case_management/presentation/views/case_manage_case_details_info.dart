import 'package:flutter/material.dart';

class CaseManagementCaseDetailsInfoPage extends StatefulWidget {
  const CaseManagementCaseDetailsInfoPage({super.key});

  @override
  State<CaseManagementCaseDetailsInfoPage> createState() =>
      _CaseManagementCaseDetailsInfoPageState();
}

class _CaseManagementCaseDetailsInfoPageState
    extends State<CaseManagementCaseDetailsInfoPage> {
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
        .where(
          (c) => c.values.any(
            (v) => v != null && v.toString().toLowerCase().contains(q),
          ),
        )
        .toList();
  }

  Future<void> _openAdvancedSearchDialog() async {
    String caseType = _caseTypeOptions.first;
    String proposedType = _proposedTypeOptions.first;
    String region = _regionOptions.first;
    String territory = _territoryOptions.first;
    String district = _districtOptions.first;
    String unit = _unitOptions.first;
    String portfolio = _portfolioOptions.first;

    final noController = TextEditingController();
    final cifController = TextEditingController();
    final caseNoController = TextEditingController();
    final filingFromController = TextEditingController();
    final filingToController = TextEditingController();
    final nextDateController = TextEditingController();

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
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
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
                              child: const Icon(
                                Icons.tune_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Advanced Search',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
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
                              _sectionLabel('Case Classification'),
                              const SizedBox(height: 12),
                              _dropdownField(
                                label: 'Case Type',
                                value: caseType,
                                options: _caseTypeOptions,
                                onChanged: (v) =>
                                    setLocalState(() => caseType = v),
                              ),
                              _dropdownField(
                                label: 'Proposed Type',
                                value: proposedType,
                                options: _proposedTypeOptions,
                                onChanged: (v) =>
                                    setLocalState(() => proposedType = v),
                              ),
                              _textField(
                                label: 'No.',
                                controller: noController,
                                hint: 'A/C or Serial No.',
                              ),
                              _textField(
                                label: 'CIF',
                                controller: cifController,
                                hint: 'CIF Number',
                              ),
                              _textField(
                                label: 'Case No.',
                                controller: caseNoController,
                                hint: 'Case Number',
                              ),
                              const SizedBox(height: 10),
                              _sectionLabel('Location & Unit'),
                              const SizedBox(height: 12),
                              _dropdownField(
                                label: 'Region',
                                value: region,
                                options: _regionOptions,
                                onChanged: (v) =>
                                    setLocalState(() => region = v),
                              ),
                              _dropdownField(
                                label: 'Territory',
                                value: territory,
                                options: _territoryOptions,
                                onChanged: (v) =>
                                    setLocalState(() => territory = v),
                              ),
                              _dropdownField(
                                label: 'District',
                                value: district,
                                options: _districtOptions,
                                onChanged: (v) =>
                                    setLocalState(() => district = v),
                              ),
                              _dropdownField(
                                label: 'Unit',
                                value: unit,
                                options: _unitOptions,
                                onChanged: (v) => setLocalState(() => unit = v),
                              ),
                              _dropdownField(
                                label: 'Portfolio',
                                value: portfolio,
                                options: _portfolioOptions,
                                onChanged: (v) =>
                                    setLocalState(() => portfolio = v),
                              ),
                              const SizedBox(height: 10),
                              _sectionLabel('Dates'),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: _textField(
                                      label: 'Filing From',
                                      controller: filingFromController,
                                      hint: 'dd/mm/yyyy',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _textField(
                                      label: 'TO',
                                      controller: filingToController,
                                      hint: 'dd/mm/yyyy',
                                    ),
                                  ),
                                ],
                              ),
                              _textField(
                                label: 'Next Date',
                                controller: nextDateController,
                                hint: 'dd/mm/yyyy',
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.grey.shade600,
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
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
                                      if (caseType != _caseTypeOptions.first) {
                                        parts.add(caseType);
                                      }
                                      if (proposedType !=
                                          _proposedTypeOptions.first) {
                                        parts.add(proposedType);
                                      }
                                      if (noController.text.trim().isNotEmpty) {
                                        parts.add(noController.text.trim());
                                      }
                                      if (cifController.text
                                          .trim()
                                          .isNotEmpty) {
                                        parts.add(cifController.text.trim());
                                      }
                                      if (caseNoController.text
                                          .trim()
                                          .isNotEmpty) {
                                        parts.add(caseNoController.text.trim());
                                      }
                                      if (district != _districtOptions.first) {
                                        parts.add(district);
                                      }
                                      final keyword = parts.join(' ').trim();
                                      setState(() {
                                        _searchQuery = keyword;
                                        _searchController.text = keyword;
                                        _isSearching = keyword.isNotEmpty;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.search_rounded,
                                      size: 18,
                                    ),
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

    noController.dispose();
    cifController.dispose();
    caseNoController.dispose();
    filingFromController.dispose();
    filingToController.dispose();
    nextDateController.dispose();
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
                  'Case Details Info',
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
            margin: const EdgeInsets.only(right: 4),
            child: IconButton(
              tooltip: _isSearching ? 'Close search' : 'Search',
              onPressed: _toggleSearch,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  _isSearching ? Icons.close_rounded : Icons.search_rounded,
                  key: ValueKey(_isSearching),
                ),
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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

class _SupremeCaseCardState extends State<_SupremeCaseCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _ctrl;
  late final Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
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
    final String status = _v('Case Status On The Previous Date');
    final bool isSpecialStatus =
        status.contains('Settled') ||
        status.contains('Complete') ||
        status.contains('Judgement');

    final Color accentColor = isSpecialStatus
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
                            _v('Name of Enterprise'),
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
                    _infoRow(
                      Icons.tag_rounded,
                      'Case Number',
                      _v('Case Number'),
                      accentColor,
                    ),
                    const SizedBox(height: 8),
                    _infoRow(
                      Icons.credit_card_rounded,
                      'A/C Number',
                      _v('A/C Number'),
                      accentColor,
                    ),
                    const SizedBox(height: 8),
                    _infoRow(
                      Icons.category_rounded,
                      'Type of Case',
                      _v('Type of Case (Long)'),
                      const Color(0xFF1552B0),
                    ),
                    const SizedBox(height: 8),
                    _infoRow(
                      Icons.monetization_on_rounded,
                      'Claim Amount',
                      '৳ ${_v('Case Claim Amount')}',
                      const Color(0xFF7C3AED),
                    ),
                    const SizedBox(height: 8),
                    _infoRow(
                      Icons.event_rounded,
                      'Filing Date',
                      _v('Filing Date'),
                      const Color(0xFFD97706),
                    ),
                    const SizedBox(height: 8),
                    _infoRow(
                      Icons.person_rounded,
                      'Lawyer Name',
                      _v('Lawyer\'s Name'),
                      const Color(0xFF0D9488),
                    ),
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
                      _sectionHead(
                        'Case Classification',
                        Icons.description_outlined,
                      ),
                      const SizedBox(height: 12),
                      _labelValueList([
                        ('Unique ID', _v('Unique ID')),
                        ('Proposed Type', _v('Proposed Type')),
                        ('Type of Case (Short)', _v('Type of Case (Short)')),
                        ('Type of Case (Long)', _v('Type of Case (Long)')),
                        ('Prev Filing Date', _v('Prev Filing Date')),
                        ('Filing Date', _v('Filing Date')),
                        ('Claim Amount', '৳ ${_v('Case Claim Amount')}'),
                        ('Portfolio', _v('Portfolio')),
                        ('District', _v('District')),
                        ('Territory', _v('Territory')),
                        ('Legal Region', _v('Legal Region')),
                      ]),
                      _divider(),
                      _sectionHead(
                        'Status & Last Activities',
                        Icons.history_rounded,
                      ),
                      const SizedBox(height: 12),
                      _statusDetailedCard(),
                      _divider(),
                      _sectionHead(
                        'Plaintiff & Officers',
                        Icons.people_alt_rounded,
                      ),
                      const SizedBox(height: 12),
                      _plaintiffOfficerCard(),
                      _divider(),
                      _sectionHead(
                        'Court Information',
                        Icons.account_balance_rounded,
                      ),
                      const SizedBox(height: 12),
                      _courtInfoCard(),
                      _divider(),
                      _sectionHead(
                        'Legal Cost Information',
                        Icons.account_balance_wallet_rounded,
                      ),
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
                  color:
                      (color == const Color(0xFFD97706) ||
                          color == const Color(0xFF7C3AED))
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

  Widget _actionBtn(
    IconData icon,
    String label,
    Color color,
    Color bg,
    VoidCallback onTap,
  ) {
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
              _isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 140,
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

  Widget _statusDetailedCard() {
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
            icon: Icons.calendar_today_rounded,
            label: 'Date Before Previous',
            value: _v('Date Before Previous Date'),
            iconColor: const Color(0xFF1552B0),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.alt_route_rounded,
            label: 'Step Before Previous',
            value: _v('Step Before Previous Step'),
            iconColor: const Color(0xFF7C3AED),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.event_available_rounded,
            label: 'Previous Date',
            value: _v('Previous Date'),
            iconColor: const Color(0xFFD97706),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.info_outline_rounded,
            label: 'Status (Prev)',
            value: _v('Case Status On The Previous Date'),
            iconColor: const Color(0xFF1552B0),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.task_alt_rounded,
            label: 'Activities (Prev)',
            value: _v('Activities Taken On The Previous Date'),
            iconColor: const Color(0xFF0D9488),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.update_rounded,
            label: 'Next Date',
            value: _v('Next Date'),
            iconColor: const Color(0xFF2563EB),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.help_outline_rounded,
            label: 'Status (Next)',
            value: _v('Case Status on the Next date'),
            iconColor: Colors.grey.shade600,
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.comment_rounded,
            label: 'Remarks (Prev)',
            value: _v('Remarks on Case Status on the Previous date'),
            iconColor: const Color(0xFF64748B),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.flag_rounded,
            label: 'Final Status',
            value: _v('Final Status (Running/Settled)'),
            iconColor: const Color(0xFFDC2626),
          ),
        ],
      ),
    );
  }

  Widget _plaintiffOfficerCard() {
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
            icon: Icons.person_add_rounded,
            label: 'Filling Plaintiff',
            value: _v('Filling Plaintiff'),
            iconColor: const Color(0xFF1E293B),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.person_rounded,
            label: 'Present Plaintiff',
            value: _v('Present Plaintiff'),
            iconColor: const Color(0xFF1E293B),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.assignment_ind_rounded,
            label: 'Dealing Officer',
            value: _v('Case Dealings officer'),
            iconColor: const Color(0xFF1552B0),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.phone_rounded,
            label: 'Officer Phone',
            value: _v('Case Dealings Phone'),
            iconColor: const Color(0xFF0D9488),
          ),
        ],
      ),
    );
  }

  Widget _courtInfoCard() {
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
            icon: Icons.account_balance_rounded,
            label: 'Prev Court',
            value: _v('Previous Name Of The Court'),
            iconColor: const Color(0xFF64748B),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.gavel_rounded,
            label: 'Present Court',
            value: _v('Present Name Of The Court'),
            iconColor: const Color(0xFF1552B0),
          ),
        ],
      ),
    );
  }

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
          _dividerThin(),
          _statusRow(
            icon: Icons.update_rounded,
            label: 'Last Updated',
            value: _v('Legal as per(last updated date)'),
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
            width: 140,
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

  Widget _dividerThin() {
    return Divider(
      height: 1,
      indent: 14,
      endIndent: 14,
      color: Colors.grey.shade100,
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

const List<String> _caseTypeOptions = [
  'Type Of Case',
  'ARA-2003',
  'NI Act-138',
];

const List<String> _proposedTypeOptions = [
  'Proposed Type',
  'Loan',
  'New',
  'Running',
  'Closed',
];

const List<String> _regionOptions = [
  'Select Region',
  'North',
  'South',
  'East',
  'West',
];

const List<String> _territoryOptions = [
  'Select Territory',
  'BARISAL',
  'DHAKA',
  'CHITTAGONG',
];

const List<String> _districtOptions = [
  'Select District',
  'Barishal',
  'Bagerhat',
  'Dhaka',
];

const List<String> _unitOptions = ['Select Unit Office', 'Unit 1', 'Unit 2'];

const List<String> _portfolioOptions = [
  'Select Portfolio',
  'SME',
  'Corporate',
  'Retail',
];

final List<Map<String, dynamic>> _dummySupremeCases = [
  {
    'Unique ID': '2',
    'Proposed Type': 'Loan',
    'A/C Number': '6038465600005',
    'Name of Enterprise': 'Sardar Communication',
    'Type of Case (Short)': 'ARA-2003',
    'Type of Case (Long)': 'Arthorin Adalot Ain-2003',
    'Prev Filing Date': '',
    'Filing Date': '26-Nov-20',
    'Case Number': 'Artho-46/15(Jari-19/20)(Mis-36/22)',
    'Case Claim Amount': '1109625.88',
    'Date Before Previous Date': '28-Apr-26',
    'Step Before Previous Step': 'Auction 33(4)',
    'Previous Date': '28-Apr-26',
    'Case Status On The Previous Date': 'Auction 33(4)',
    'Activities Taken On The Previous Date': 'Argument Complete',
    'Next Date': 'Yet To Fix',
    'Case Status on the Next date': '',
    'Remarks on Case Status on the Previous date': '',
    'Filling Plaintiff': 'Md. Hasib Morshed(22508)',
    'Present Plaintiff': 'Muhammad Saydur Rahman(12447)',
    'Case Dealings officer': 'Md. Faridul Islam(12203)',
    'Case Dealings Phone': '01713368699',
    'Lawyer\'s Name': 'SHAHEEN SIDDIQUEE',
    'Previous Name Of The Court': '1st Joint Dist & Session Judge Court',
    'Present Name Of The Court': '1st Joint Dist & Session Judge Court',
    'District': 'Barishal',
    'Territory': 'BARISAL',
    'Portfolio': 'SME',
    'Legal Region': 'South',
    'Final Status (Running/Settled)': 'Running',
    'Legal Cost': '0.00',
    'Legal as per(last updated date)': '04-Dec-25 11:47 AM',
  },
  {
    'Unique ID': '4',
    'Proposed Type': 'Loan',
    'A/C Number': '0201600930909001',
    'Name of Enterprise': 'Nazmul Garments',
    'Type of Case (Short)': 'ARA-2003',
    'Type of Case (Long)': 'Artho Jari',
    'Prev Filing Date': '',
    'Filing Date': '27-Nov-17',
    'Case Number': 'Artho-38/15(Jari-33/17)',
    'Case Claim Amount': '939781.57',
    'Date Before Previous Date': '03-May-23',
    'Step Before Previous Step': 'Warrant Of Arrest',
    'Previous Date': '21-Jun-23',
    'Case Status On The Previous Date': 'Case Withdrawal',
    'Activities Taken On The Previous Date': '12(3) Auction Legal Notice',
    'Next Date': '',
    'Case Status on the Next date': '',
    'Remarks on Case Status on the Previous date': 'Case Withdrawal Complete',
    'Filling Plaintiff': 'Gautam Kumar Roy(12208)',
    'Present Plaintiff': 'Md. Hasib Morshed(22508)',
    'Case Dealings officer': 'Md. Hasib Morshed(22508)',
    'Case Dealings Phone': '01730097973',
    'Lawyer\'s Name': 'SHAHEEN SIDDIQUEE',
    'Previous Name Of The Court': '2nd Joint Dist & Session Judge Court',
    'Present Name Of The Court': '2nd Joint Dist & Session Judge Court',
    'District': 'Bagerhat',
    'Territory': 'BARISAL',
    'Portfolio': 'SME',
    'Legal Region': 'South',
    'Final Status (Running/Settled)': 'Settled',
    'Legal Cost': '0.00',
    'Legal as per(last updated date)': '04-Dec-25 11:47 AM',
  },
];
