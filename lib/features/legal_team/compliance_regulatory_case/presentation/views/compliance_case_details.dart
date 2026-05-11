import 'package:flutter/material.dart';

class ComplianceCaseDetailsPage extends StatefulWidget {
  const ComplianceCaseDetailsPage({super.key});

  @override
  State<ComplianceCaseDetailsPage> createState() =>
      _ComplianceCaseDetailsPageState();
}

class _ComplianceCaseDetailsPageState extends State<ComplianceCaseDetailsPage> {
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
    String caseType = 'Type Of Case';
    String proposedType = 'Proposed Type';
    String suitType = 'Select Suit Type';
    String district = 'Select District';
    String monitoringDept = 'Select Monitoring Dept';
    String dependentType = 'Select Dependent Type';
    String riskFactor = 'Select Risk Factor';

    final noController = TextEditingController();
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
                                options: [
                                  'Type Of Case',
                                  'Criminal',
                                  'Civil',
                                  'Others'
                                ],
                                onChanged: (v) =>
                                    setLocalState(() => caseType = v),
                              ),
                              _dropdownField(
                                label: 'Proposed Type',
                                value: proposedType,
                                options: [
                                  'Proposed Type',
                                  'Loan',
                                  'New',
                                  'Running'
                                ],
                                onChanged: (v) =>
                                    setLocalState(() => proposedType = v),
                              ),
                              _textField(
                                label: 'No.',
                                controller: noController,
                                hint: 'Enter Number',
                              ),
                              _textField(
                                label: 'Case Number',
                                controller: caseNoController,
                                hint: 'Enter Case Number',
                              ),
                              _dropdownField(
                                label: 'Case Filed By/Against',
                                value: suitType,
                                options: [
                                  'Select Suit Type',
                                  'Against Bank',
                                  'By Bank'
                                ],
                                onChanged: (v) =>
                                    setLocalState(() => suitType = v),
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
                              const SizedBox(height: 10),
                              _sectionLabel('Other Details'),
                              const SizedBox(height: 12),
                              _dropdownField(
                                label: 'District',
                                value: district,
                                options: [
                                  'Select District',
                                  'Chandpur',
                                  'Jamalpur',
                                  'Bagerhat'
                                ],
                                onChanged: (v) =>
                                    setLocalState(() => district = v),
                              ),
                              _dropdownField(
                                label: 'Monitoring Dept.',
                                value: monitoringDept,
                                options: [
                                  'Select Monitoring Dept',
                                  'Monitoring 1',
                                  'Monitoring 2'
                                ],
                                onChanged: (v) =>
                                    setLocalState(() => monitoringDept = v),
                              ),
                              _dropdownField(
                                label: 'Dependent Type',
                                value: dependentType,
                                options: [
                                  'Select Dependent Type',
                                  'Type A',
                                  'Type B'
                                ],
                                onChanged: (v) =>
                                    setLocalState(() => dependentType = v),
                              ),
                              _dropdownField(
                                label: 'Risk Factor',
                                value: riskFactor,
                                options: [
                                  'Select Risk Factor',
                                  'Low',
                                  'Medium',
                                  'High'
                                ],
                                onChanged: (v) =>
                                    setLocalState(() => riskFactor = v),
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
                                onPressed: () =>
                                    Navigator.of(dialogContext).pop(),
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
                                  if (noController.text.trim().isNotEmpty) {
                                    parts.add(noController.text.trim());
                                  }
                                  if (caseNoController.text.trim().isNotEmpty) {
                                    parts.add(caseNoController.text.trim());
                                  }
                                  if (district != 'Select District') {
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
                  'Compliance Case Details',
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
                      return _ComplianceCaseCard(caseData: caseData);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ComplianceCaseCard extends StatefulWidget {
  const _ComplianceCaseCard({required this.caseData});

  final Map<String, dynamic> caseData;

  @override
  State<_ComplianceCaseCard> createState() => _ComplianceCaseCardState();
}

class _ComplianceCaseCardState extends State<_ComplianceCaseCard>
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
    final String status = _v('Case Status On The Previous');
    final bool isSpecialStatus = status.contains('Settled') ||
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
                            _v('A/C Name'),
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
                      _v('Type of Case'),
                      const Color(0xFF1552B0),
                    ),
                    const SizedBox(height: 8),
                    _infoRow(
                      Icons.monetization_on_rounded,
                      'Involvement Amount',
                      '৳ ${_v('Involvement Amount')}',
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
                      'Lawyer',
                      _v('Lawyer'),
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
                        'Case Information',
                        Icons.description_outlined,
                      ),
                      const SizedBox(height: 12),
                      _labelValueList([
                        ('Sl No', _v('Sl No')),
                        ('Suit Type', _v('Suit Type')),
                        ('Dependent Type', _v('Dependent Type')),
                        ('Loan Segment', _v('Loan Segment')),
                        ('Risk Factor/Contingent Liability',
                            _v('Risk Factor/Contingent Liability')),
                        ('Summon Receiving Date', _v('Summon Receiving Date')),
                        ('Monitoring Dept.', _v('Monitoring Dept.')),
                        ('3 Type of case', _v('3 Type of case')),
                      ]),
                      _divider(),
                      _sectionHead(
                        'Status & History',
                        Icons.history_rounded,
                      ),
                      const SizedBox(height: 12),
                      _statusDetailedCard(),
                      _divider(),
                      _sectionHead(
                        'Officers & Lawyer',
                        Icons.people_alt_rounded,
                      ),
                      const SizedBox(height: 12),
                      _officerLawyerCard(),
                      _divider(),
                      _sectionHead(
                        'Location & Remarks',
                        Icons.location_on_rounded,
                      ),
                      const SizedBox(height: 12),
                      _locationRemarksCard(),
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
                      width: 150,
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
            icon: Icons.event_note_rounded,
            label: 'Previous Date',
            value: _v('Previous Date'),
            iconColor: const Color(0xFF1552B0),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.info_outline_rounded,
            label: 'Status (Prev)',
            value: _v('Case Status On The Previous'),
            iconColor: const Color(0xFF7C3AED),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.update_rounded,
            label: 'Next Date',
            value: _v('Next Date'),
            iconColor: const Color(0xFFD97706),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.pending_actions_rounded,
            label: 'Status (Next)',
            value: _v('Case Status Next Date'),
            iconColor: const Color(0xFF1552B0),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.history_edu_rounded,
            label: 'Background/History',
            value: _v('Background /Case history'),
            iconColor: const Color(0xFF0D9488),
          ),
        ],
      ),
    );
  }

  Widget _officerLawyerCard() {
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
            icon: Icons.assignment_ind_rounded,
            label: 'Dealing Officer',
            value: _v('Dealing Officer'),
            iconColor: const Color(0xFF1552B0),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.gavel_rounded,
            label: 'Lawyer',
            value: _v('Lawyer'),
            iconColor: const Color(0xFF1E293B),
          ),
        ],
      ),
    );
  }

  Widget _locationRemarksCard() {
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
            icon: Icons.map_rounded,
            label: 'District',
            value: _v('District'),
            iconColor: const Color(0xFF1552B0),
          ),
          _dividerThin(),
          _statusRow(
            icon: Icons.comment_bank_rounded,
            label: 'Final Remarks',
            value: _v('Final Remarks'),
            iconColor: const Color(0xFF64748B),
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

final List<Map<String, dynamic>> _dummyComplianceCases = [
  {
    'Sl No': '1',
    'A/C Number': '111111111111111',
    'Suit Type': 'Against Bank',
    'Dependent Type': '',
    'Loan Segment': '',
    'Risk Factor/Contingent Liability': '',
    'Involvement Amount': '0.00',
    'Summon Receiving Date': '',
    'Monitoring Dept.': '',
    'A/C Name': 'Bbl',
    '3 Type of case': 'Criminal',
    'Type of Case': 'Title Suit',
    'Filing Date': '30-Mar-22',
    'Case Number': '/1111',
    'Previous Date': '',
    'Case Status On The Previous': '',
    'Next Date': '',
    'Case Status Next Date': 'Argument',
    'Background /Case history': '1',
    'Dealing Officer': '',
    'Lawyer': 'BLACK AND WHITE',
    'District': 'Chandpur',
    'Final Remarks': '',
    'Legal Cost': '0.00',
    'Legal as per(last updated date)': '06-Aug-25 03:36 PM',
  },
  {
    'Sl No': '4',
    'A/C Number': '111111111111111',
    'Suit Type': 'Against Bank',
    'Dependent Type': '',
    'Loan Segment': 'Corporate',
    'Risk Factor/Contingent Liability': '',
    'Involvement Amount': '0.00',
    'Summon Receiving Date': '',
    'Monitoring Dept.': '',
    'A/C Name': 'asdfsadf',
    '3 Type of case': 'Criminal',
    'Type of Case': 'Title Suit',
    'Filing Date': '06-Apr-22',
    'Case Number': 'ara/2022',
    'Previous Date': '10-Aug-25',
    'Case Status On The Previous': 'Auction 33(4)',
    'Next Date': 'Yet To Fix',
    'Case Status Next Date': '',
    'Background /Case history': '',
    'Dealing Officer': 'Ramprosad Mondal(13412)',
    'Lawyer': 'MD.MUZIBUL HAQUE',
    'District': 'Bagerhat',
    'Final Remarks': 'Running',
    'Legal Cost': '900.00',
    'Legal as per(last updated date)': '06-Aug-25 03:36 PM',
  },
];
