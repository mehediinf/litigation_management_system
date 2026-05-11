//lib/features/legal_team/compliance_regulatory_case/presentation/views/compliance_case_file.dart

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'case_file/case_file_action_approve_reassign_page.dart';
import 'case_file/case_file_action_delete_page.dart';
import 'case_file/case_file_action_edit_page.dart';
import 'case_file/case_file_action_preview_page.dart';
import 'case_file/case_file_action_reassign_file_page.dart';
import 'case_file/case_file_action_send_to_checker_page.dart';
import 'case_file/case_file_action_update_next_date_page.dart';
import 'case_file/case_file_action_verify_page.dart';

class CaseFilePage extends StatefulWidget {
  const CaseFilePage({super.key});

  @override
  State<CaseFilePage> createState() => _CaseFilePageState();
}

class _CaseFilePageState extends State<CaseFilePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _fabAnimController;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  // Search filter controllers
  String _selectedCaseType = 'Type Of Case';
  String _selectedProposedType = 'Loan';
  String _selectedSuitType = 'Type Of Suit';
  String _selectedMonitoringDept = 'Monitoring Department';
  String _selectedDependentType = 'Type Of Dependent';
  String _selectedRiskFactor = 'Risk Factor';
  final TextEditingController _loanAcSearchController = TextEditingController();
  final TextEditingController _caseNoSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fabAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.index == 1) {
      _fabAnimController.forward();
    } else {
      _fabAnimController.reverse();
      _isSearching = false;
      _searchController.clear();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchController.dispose();
    _loanAcSearchController.dispose();
    _caseNoSearchController.dispose();
    _fabAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FB),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFF1552B0),
        foregroundColor: Colors.white,
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                onPressed: () => Navigator.of(context).pop(),
              ),
        title: _isSearching
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: 'Search ...',
                    hintStyle: TextStyle(
                      color: Colors.black.withValues(alpha: 0.6),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.blue.withValues(alpha: 0.7),
                      size: 18,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 11,
                    ),
                  ),
                  onChanged: (v) => setState(() {}),
                ),
              )
            : const Text(
                'Case File',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  letterSpacing: 0.2,
                ),
              ),
        actions: [
          if (_tabController.index == 1)
            _isSearching
                ? IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                        _searchController.clear();
                      });
                    },
                  )
                : FadeTransition(
                    opacity: _fabAnimController,
                    child: ScaleTransition(
                      scale: _fabAnimController,
                      child: IconButton(
                        icon: const Icon(Icons.search_rounded, size: 22),
                        onPressed: () => _showAdvancedSearchDialog(),
                      ),
                    ),
                  ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: const Color(0xFF1552B0),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.55),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13.5,
              ),
              tabs: const [
                Tab(text: 'Form'),
                Tab(text: 'Data Grid'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const _FormTab(),
          _DataGridTab(searchQuery: _searchController.text),
        ],
      ),
    );
  }

  void _showAdvancedSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => _AdvancedSearchDialog(
        caseTypeOptions: _caseTypeOptions,
        proposedTypeOptions: _proposedTypeOptions,
        suitTypeOptions: _suitTypeOptions,
        monitoringDeptOptions: _monitoringDeptOptions,
        dependentTypeOptions: _dependentTypeOptions,
        riskFactorOptions: _riskFactorOptions,
        initialCaseType: _selectedCaseType,
        initialProposedType: _selectedProposedType,
        initialSuitType: _selectedSuitType,
        initialMonitoringDept: _selectedMonitoringDept,
        initialDependentType: _selectedDependentType,
        initialRiskFactor: _selectedRiskFactor,
        onSearch:
            (
              caseType,
              proposedType,
              loanAc,
              caseNo,
              suitType,
              monitoringDept,
              dependentType,
              riskFactor,
            ) {
              setState(() {
                _selectedCaseType = caseType;
                _selectedProposedType = proposedType;
                _loanAcSearchController.text = loanAc;
                _caseNoSearchController.text = caseNo;
                _selectedSuitType = suitType;
                _selectedMonitoringDept = monitoringDept;
                _selectedDependentType = dependentType;
                _selectedRiskFactor = riskFactor;
              });
              Navigator.pop(context);
            },
      ),
    );
  }
}

// FORM TAB

class _FormTab extends StatefulWidget {
  const _FormTab();

  @override
  State<_FormTab> createState() => _FormTabState();
}

class _FormTabState extends State<_FormTab> {
  String _caseTypes = _caseTypeOptions.first;
  String _proposedType = _proposedTypeOptions.first;

  final _loanAcController = TextEditingController();
  final _caseNumberController = TextEditingController();
  final _acNameController = TextEditingController();

  @override
  void dispose() {
    _loanAcController.dispose();
    _caseNumberController.dispose();
    _acNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          _FormCard(
            child: Column(
              children: [
                _FormDropdown(
                  label: 'Type Of Case',
                  value: _caseTypes,
                  options: _caseTypeOptions,
                  onChanged: (v) => setState(() => _caseTypes = v),
                ),
                _FormDropdown(
                  label: 'Proposed Type',
                  value: _proposedType,
                  options: _proposedTypeOptions,
                  onChanged: (v) => setState(() => _proposedType = v),
                ),
                _FormTextField(
                  label: 'Loan A/C No.',
                  controller: _loanAcController,
                ),
                _FormTextField(
                  label: 'Case No.',
                  controller: _caseNumberController,
                ),
                _FormTextField(
                  label: 'AC Name',
                  controller: _acNameController,
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFFFFFFFF),
                    size: 18,
                  ),
                  label: const Text(
                    'Search',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ],
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: child,
    );
  }
}

class _FormDropdown extends StatefulWidget {
  const _FormDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  State<_FormDropdown> createState() => _FormDropdownState();
}

class _FormDropdownState extends State<_FormDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B),
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          DropdownSearch<String>(
            items: widget.options,
            selectedItem: widget.value,
            filterFn: (item, filter) =>
                item.toLowerCase().contains(filter.toLowerCase()),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
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
                  borderSide: const BorderSide(
                    color: Color(0xFF1552B0),
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
            ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search_rounded, size: 18),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              menuProps: MenuProps(borderRadius: BorderRadius.circular(14)),
              constraints: const BoxConstraints(maxHeight: 250),
            ),
            onChanged: (v) {
              if (v != null) widget.onChanged(v);
            },
          ),
          Divider(height: 16, color: Colors.grey.shade100),
        ],
      ),
    );
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    required this.label,
    required this.controller,
    this.isLast = false,
  });

  final String label;
  final TextEditingController controller;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B),
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            style: const TextStyle(fontSize: 13.5),
            decoration: InputDecoration(
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
                borderSide: const BorderSide(
                  color: Color(0xFF1552B0),
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
          if (!isLast) Divider(height: 16, color: Colors.grey.shade100),
        ],
      ),
    );
  }
}

// DATA GRID TAB

class _DataGridTab extends StatelessWidget {
  const _DataGridTab({this.searchQuery = ''});

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final filtered = searchQuery.isEmpty
        ? _dummyCases
        : _dummyCases.where((c) {
            final q = searchQuery.toLowerCase();
            return c.values.any((v) => v.toString().toLowerCase().contains(q));
          }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 52,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),
            Text(
              'No results for "$searchQuery"',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return _CaseGridCard(data: filtered[index], index: index);
      },
    );
  }
}

class _CaseGridCard extends StatefulWidget {
  const _CaseGridCard({required this.data, required this.index});

  final Map<String, dynamic> data;
  final int index;

  @override
  State<_CaseGridCard> createState() => _CaseGridCardState();
}

class _CaseGridCardState extends State<_CaseGridCard>
    with SingleTickerProviderStateMixin {
  bool _showActions = false;
  late final AnimationController _ctrl;
  late final ScrollController _actionScroll;

  static const List<Color> _kActionAccents = [
    Color(0xFF4361EE),
    Color(0xFF2EC4B6),
    Color(0xFFF77F00),
    Color(0xFF9B5DE5),
    Color(0xFFEF233C),
    Color(0xFF06D6A0),
    Color(0xFF118AB2),
    Color(0xFF43AA8B),
    Color(0xFFE9C46A),
    Color(0xFFE76F51),
  ];

  static const Map<String, Map<String, Object>> _kActionMeta = {
    'D': {'icon': Icons.delete, 'desc': 'Delete'},
    'E': {'icon': Icons.border_color, 'desc': 'Edit Suit File'},
    'STC': {'icon': Icons.fact_check, 'desc': 'Send To Checker'},
    'V': {'icon': Icons.verified, 'desc': 'Verify'},
    'RF': {'icon': Icons.assignment_return, 'desc': 'Reassign File'},
    'AR': {'icon': Icons.assignment, 'desc': 'Approve Reassign File'},
    'U': {'icon': Icons.system_update_alt, 'desc': 'Update Next Date'},
    'P': {'icon': Icons.preview, 'desc': 'Preview'},
  };

  static const List<String> _kDefaultActionKeys = [
    'D',
    'E',
    'STC',
    'V',
    'RF',
    'AR',
    'U',
    'P',
  ];

  static List<String> _actionKeysForCase(Map<String, dynamic> data) {
    final raw = data['Actions'];
    if (raw == null) return List<String>.from(_kDefaultActionKeys);
    if (raw is! Iterable) return List<String>.from(_kDefaultActionKeys);

    final out = <String>[];
    for (final e in raw) {
      if (e is String) {
        final k = e.trim();
        if (k.isNotEmpty) out.add(k);
      } else if (e is Map) {
        final code = e['code'] ?? e['key'] ?? e['label'];
        if (code != null) {
          final k = code.toString().trim();
          if (k.isNotEmpty) out.add(k);
        }
      }
    }
    final seen = <String>{};
    final deduped = <String>[];
    for (final k in out) {
      if (seen.add(k)) deduped.add(k);
    }
    return deduped;
  }

  @override
  void initState() {
    super.initState();
    _actionScroll = ScrollController();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
  }

  @override
  void dispose() {
    _actionScroll.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  String _v(String key) {
    final val = widget.data[key];
    if (val == null || val.toString().trim().isEmpty) return '—';
    return val.toString();
  }

  bool get _isNegativeStatus {
    final s = _v('Status').toLowerCase();
    final cs = _v('Case Status').toLowerCase();
    return s.contains('closed') ||
        s.contains('decline') ||
        cs.contains('decline');
  }

  void _openActionByCode(BuildContext context, String code) {
    final d = widget.data;
    switch (code) {
      case 'D':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseFileActionDeletePage(caseData: d),
          ),
        );
        return;
      case 'E':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseFileActionEditPage(caseData: d),
          ),
        );
        return;
      case 'STC':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseFileActionSendToCheckerPage(caseData: d),
          ),
        );
        return;
      case 'V':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseFileActionVerifyPage(caseData: d),
          ),
        );
        return;

      case 'RF':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseFileActionReassignFilePage(caseData: d),
          ),
        );
        return;

      case 'AR':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseFileActionApproveReassignPage(caseData: d),
          ),
        );
        return;
      case 'U':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseFileActionUpdateNextDatePage(caseData: d),
          ),
        );
        return;
      case 'P':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseFileActionPreviewPage(caseData: d),
          ),
        );
        return;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Unknown action: $code'),
          ),
        );
    }
  }

  List<_CaseGridActionEntry> _buildActionEntries(BuildContext context) {
    var i = 0;
    final list = <_CaseGridActionEntry>[];
    for (final label in _actionKeysForCase(widget.data)) {
      final meta = _kActionMeta[label];
      final descObj = meta?['desc'];
      final iconObj = meta?['icon'];
      if (meta == null || descObj is! String || iconObj is! IconData) {
        continue;
      }
      list.add(
        _CaseGridActionEntry(
          label: label,
          shortDesc: descObj,
          icon: iconObj,
          accent: _kActionAccents[i++ % _kActionAccents.length],
          onTap: () => _openActionByCode(context, label),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final actions = _buildActionEntries(context);
    final actionCount = actions.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: 0.22,
                        child: Image.asset(
                          'assets/images/lms_logo1.png',
                          fit: BoxFit.cover,
                          alignment: Alignment.centerRight,
                          errorBuilder: (_, _, _) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.92),
                              Colors.white.withValues(alpha: 0.76),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 12, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _CaseStatusHeaderChip(
                                statusText: _v('Status'),
                                isNegative: _isNegativeStatus,
                              ),
                            ),
                            const SizedBox(width: 70),
                            _CaseGridActionToggle(
                              open: _showActions,
                              badgeCount: actionCount,
                              onTap: () =>
                                  setState(() => _showActions = !_showActions),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 20, color: Color(0xFFEEF1F8)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Column(
                          children: [
                            _CaseDataFieldRow(
                              label: 'Suit Type',
                              value: _v('Suit Type'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Loan Segment',
                              value: _v('Loan Segment'),
                            ),

                            _CaseDataFieldRow(
                              label: 'Dependent Type',
                              value: _v('Dependent Type'),
                            ),

                            _CaseDataFieldRow(
                              label: 'Risk Factor/Contingent Liability',
                              value: _v('Risk Factor/Contingent Liability'),
                            ),

                            _CaseDataFieldRow(
                              label: 'Monitoring Department',
                              value: _v('Monitoring Department'),
                            ),

                            _CaseDataFieldRow(
                              label: 'Requisition',
                              value: _v('Requisition'),
                            ),

                            _CaseDataFieldRow(
                              label: 'District',
                              value: _v('District'),
                            ),

                            _CaseDataFieldRow(
                              label: 'Loan A/C or Card No.',
                              value: _v('Loan A/C or Card No.'),
                            ),

                            _CaseDataFieldRow(
                              label: 'A/C Name or Name on Card',
                              value: _v('A/C Name or Name on Card'),
                            ),

                            _CaseDataFieldRow(
                              label: 'Case Number',
                              value: _v('Case Number'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Involvement Amount',
                              value: _v('Involvement Amount'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Summon Receiving Date',
                              value: _v('Summon Receiving Date'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Case Section',
                              value: _v('Case Section'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Initiate By',
                              value: _v('Initiate By'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Initiate Date Time',
                              value: _v('Initiate Date Time'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (_showActions)
              Positioned(
                left: 0,
                right: 200,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => setState(() => _showActions = false),
                  behavior: HitTestBehavior.opaque,
                  child: Container(color: Colors.transparent),
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 290),
              curve: Curves.easeOutCubic,
              right: _showActions ? 0 : -200,
              top: 0,
              bottom: 0,
              width: 200,
              child: _CaseActionsSlidePanel(
                primary: const Color(0xFFFF6B35),
                entries: actions,
                scrollController: _actionScroll,
                onClose: () => setState(() => _showActions = false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CaseStatusHeaderChip extends StatelessWidget {
  const _CaseStatusHeaderChip({
    required this.statusText,
    required this.isNegative,
  });

  final String statusText;
  final bool isNegative;

  @override
  Widget build(BuildContext context) {
    final dotColor = isNegative
        ? const Color(0xFFE53935)
        : const Color(0xFF43A047);
    final borderColor = isNegative
        ? const Color(0xFFEF9A9A)
        : const Color(0xFFA5D6A7);
    final bgColor = isNegative
        ? const Color(0xFFFFEBEE)
        : const Color(0xFFE8F5E9);
    final textColor = isNegative
        ? const Color(0xFFB71C1C)
        : const Color(0xFF2E7D32);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              statusText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: textColor,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaseDataFieldRow extends StatelessWidget {
  const _CaseDataFieldRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF434549),
                fontWeight: FontWeight.w500,
                height: 1.25,
              ),
            ),
          ),
          const Text(
            '·  ',
            style: TextStyle(fontSize: 12, color: Color(0xFFB0BAD0)),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: value == '—'
                    ? const Color(0xFFB0BAD0)
                    : const Color(0xFF1A2340),
                height: 1.25,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _CaseGridActionToggle extends StatelessWidget {
  const _CaseGridActionToggle({
    required this.open,
    required this.badgeCount,
    required this.onTap,
  });

  final bool open;
  final int badgeCount;
  final VoidCallback onTap;

  static const Color _kOrange = Color(0xFFFF6B35);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: open ? _kOrange : Colors.white,
              border: Border.all(
                color: open ? const Color(0xFFCC3700) : const Color(0xFFE0E5F0),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: open
                      ? _kOrange.withValues(alpha: 0.35)
                      : Colors.black.withValues(alpha: 0.06),
                  blurRadius: open ? 12 : 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 190),
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: Icon(
                  open ? Icons.close_rounded : Icons.apps_rounded,
                  key: ValueKey<bool>(open),
                  size: 18,
                  color: open ? Colors.white : _kOrange,
                ),
              ),
            ),
          ),
          if (!open && badgeCount > 0)
            Positioned(
              top: -5,
              right: -5,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2ECC71).withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '$badgeCount',
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CaseActionsEmptyHint extends StatelessWidget {
  const _CaseActionsEmptyHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF4F6FB),
                border: Border.all(color: const Color(0xFFE0E5F0), width: 1),
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                size: 20,
                color: Color(0xFF8A96B0),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'No actions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8A96B0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CaseGridActionEntry {
  const _CaseGridActionEntry({
    required this.label,
    required this.shortDesc,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  final String label;
  final String shortDesc;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;
}

class _CaseActionsSlidePanel extends StatelessWidget {
  const _CaseActionsSlidePanel({
    required this.primary,
    required this.entries,
    required this.scrollController,
    required this.onClose,
  });

  final Color primary;
  final List<_CaseGridActionEntry> entries;
  final ScrollController scrollController;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFEFEFF), Color(0xFFF5F8FF)],
        ),
        border: Border(left: BorderSide(color: Color(0xFFE4E9F2), width: 1)),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(-4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFE8ECF5), width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [primary, Color(0xFFFF6B35)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.30),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.grid_view_rounded,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
                const SizedBox(width: 7),
                const Expanded(
                  child: Text(
                    'Actions',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A2340),
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xFFF4F6FB),
                      border: Border.all(
                        color: const Color(0xFFE0E5F0),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF8A96B0),
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: entries.isEmpty
                ? const _CaseActionsEmptyHint()
                : Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    thickness: 2.5,
                    radius: const Radius.circular(4),
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                      itemCount: entries.length,
                      itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: _CaseCompactActionTile(entry: entries[i]),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CaseCompactActionTile extends StatefulWidget {
  const _CaseCompactActionTile({required this.entry});

  final _CaseGridActionEntry entry;

  @override
  State<_CaseCompactActionTile> createState() => _CaseCompactActionTileState();
}

class _CaseCompactActionTileState extends State<_CaseCompactActionTile>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 130),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.94,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.entry;
    final accent = e.accent;

    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTapDown: (_) {
          _ctrl.forward();
          setState(() => _pressed = true);
        },
        onTapUp: (_) {
          _ctrl.reverse();
          setState(() => _pressed = false);
          e.onTap();
        },
        onTapCancel: () {
          _ctrl.reverse();
          setState(() => _pressed = false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _pressed ? accent.withValues(alpha: 0.07) : Colors.white,
            border: Border.all(
              color: _pressed
                  ? accent.withValues(alpha: 0.40)
                  : const Color(0xFFE8ECF5),
              width: 1,
            ),
            boxShadow: _pressed
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: accent.withValues(alpha: _pressed ? 0.18 : 0.10),
                ),
                child: Icon(e.icon, size: 14, color: accent),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      e.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _pressed ? accent : const Color(0xFF1A2340),
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      e.shortDesc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 8.5,
                        color: Color(0xFF8A96B0),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSlide(
                offset: _pressed ? const Offset(0.25, 0) : Offset.zero,
                duration: const Duration(milliseconds: 100),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 8,
                  color: _pressed ? accent : const Color(0xFFB8C4D8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ADVANCED SEARCH DIALOG

class _AdvancedSearchDialog extends StatefulWidget {
  const _AdvancedSearchDialog({
    required this.caseTypeOptions,
    required this.proposedTypeOptions,
    required this.suitTypeOptions,
    required this.monitoringDeptOptions,
    required this.dependentTypeOptions,
    required this.riskFactorOptions,
    required this.initialCaseType,
    required this.initialProposedType,
    required this.initialSuitType,
    required this.initialMonitoringDept,
    required this.initialDependentType,
    required this.initialRiskFactor,
    required this.onSearch,
  });

  final List<String> caseTypeOptions;
  final List<String> proposedTypeOptions;
  final List<String> suitTypeOptions;
  final List<String> monitoringDeptOptions;
  final List<String> dependentTypeOptions;
  final List<String> riskFactorOptions;

  final String initialCaseType;
  final String initialProposedType;
  final String initialSuitType;
  final String initialMonitoringDept;
  final String initialDependentType;
  final String initialRiskFactor;

  final Function(String, String, String, String, String, String, String, String)
  onSearch;

  @override
  State<_AdvancedSearchDialog> createState() => _AdvancedSearchDialogState();
}

class _AdvancedSearchDialogState extends State<_AdvancedSearchDialog> {
  late String _selectedCaseType;
  late String _selectedProposedType;
  late String _selectedSuitType;
  late String _selectedMonitoringDept;
  late String _selectedDependentType;
  late String _selectedRiskFactor;

  final TextEditingController _loanAcController = TextEditingController();
  final TextEditingController _caseNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCaseType = widget.caseTypeOptions.contains(widget.initialCaseType)
        ? widget.initialCaseType
        : widget.caseTypeOptions.first;
    _selectedProposedType =
        widget.proposedTypeOptions.contains(widget.initialProposedType)
        ? widget.initialProposedType
        : widget.proposedTypeOptions.first;
    _selectedSuitType = widget.suitTypeOptions.contains(widget.initialSuitType)
        ? widget.initialSuitType
        : widget.suitTypeOptions.first;
    _selectedMonitoringDept =
        widget.monitoringDeptOptions.contains(widget.initialMonitoringDept)
        ? widget.initialMonitoringDept
        : widget.monitoringDeptOptions.first;
    _selectedDependentType =
        widget.dependentTypeOptions.contains(widget.initialDependentType)
        ? widget.initialDependentType
        : widget.dependentTypeOptions.first;
    _selectedRiskFactor =
        widget.riskFactorOptions.contains(widget.initialRiskFactor)
        ? widget.initialRiskFactor
        : widget.riskFactorOptions.first;
  }

  @override
  void dispose() {
    _loanAcController.dispose();
    _caseNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Advanced Search',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _SearchField(
                label: 'Case Type',
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: _selectedCaseType,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                    items: widget.caseTypeOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCaseType = newValue ?? 'Type Of Case';
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SearchField(
                label: 'Proposed Type',
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: _selectedProposedType,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                    items: widget.proposedTypeOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedProposedType = newValue ?? 'Loan';
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SearchField(
                label: 'Loan A/C No.',
                child: TextField(
                  controller: _loanAcController,
                  style: const TextStyle(fontSize: 12.5),
                  decoration: InputDecoration(
                    hintText: 'Enter Loan A/C No.',
                    hintStyle: const TextStyle(fontSize: 12.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF1552B0),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SearchField(
                label: 'Case No.',
                child: TextField(
                  controller: _caseNoController,
                  style: const TextStyle(fontSize: 12.5),
                  decoration: InputDecoration(
                    hintText: 'Enter Case No.',
                    hintStyle: const TextStyle(fontSize: 12.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF1552B0),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SearchField(
                label: 'Case Filed By/Against',
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: _selectedSuitType,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                    items: widget.suitTypeOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSuitType = newValue ?? 'Type Of Suit';
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SearchField(
                label: 'Monitoring Department',
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: _selectedMonitoringDept,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                    items: widget.monitoringDeptOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMonitoringDept =
                            newValue ?? 'Monitoring Department';
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SearchField(
                label: 'Dependent Type',
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: _selectedDependentType,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                    items: widget.dependentTypeOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDependentType =
                            newValue ?? 'Type Of Dependent';
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SearchField(
                label: 'Risk Factor/Contingent Liability',
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: _selectedRiskFactor,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                    items: widget.riskFactorOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRiskFactor = newValue ?? 'Risk Factor';
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _loanAcController.clear();
                        _caseNoController.clear();
                        setState(() {
                          _selectedCaseType = 'Type Of Case';
                          _selectedProposedType = 'Loan';
                          _selectedSuitType = 'Type Of Suit';
                          _selectedMonitoringDept = 'Monitoring Department';
                          _selectedDependentType = 'Type Of Dependent';
                          _selectedRiskFactor = 'Risk Factor';
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(
                          color: Color(0xFF1552B0),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Clear',
                        style: TextStyle(
                          color: Color(0xFF1552B0),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        widget.onSearch(
                          _selectedCaseType,
                          _selectedProposedType,
                          _loanAcController.text,
                          _caseNoController.text,
                          _selectedSuitType,
                          _selectedMonitoringDept,
                          _selectedDependentType,
                          _selectedRiskFactor,
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF1552B0),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF64748B),
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

// BULK ACTION BUTTON

class _BulkActionButton extends StatelessWidget {
  const _BulkActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: color, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CONSTANTS

const List<String> _caseTypeOptions = [
  'Type Of Case',
  'Auction only',
  'Legal Notice',
  'NI Act-138',
  'ARA-2003',
  'Others',
];

const List<String> _proposedTypeOptions = ['Loan', 'Card'];

const List<String> _suitTypeOptions = [
  'Type Of Suit',
  'Against Bank',
  'By Bank',
];

const List<String> _monitoringDeptOptions = [
  'Monitoring Department',
  'Corporate',
  'Retail',
  'SME',
];

const List<String> _dependentTypeOptions = [
  'Type Of Dependent',
  'Borrower',
  'Guarantor',
];

const List<String> _riskFactorOptions = [
  'Risk Factor',
  'High',
  'Medium',
  'Low',
];

// DUMMY DATA

final List<Map<String, dynamic>> _dummyCases = [
  {
    'Actions': ['D', 'E', 'STC', 'V', 'RF', 'AR', 'U', 'P'],
    'Status': 'Approved',
    'Suit Type': 'Against Bank',
    'Loan Segment': '-',
    'Dependent Type': '-',
    'Risk Factor/Contingent Liability': '-',
    'Monitoring Department': 'Corporate',
    'Requisition': 'Criminal',
    'District': 'Dhaka',
    'Loan A/C or Card No.': '1111111111111111',
    'A/C Name or Name on Card': 'Bbl',
    'Case Number': '/1111(Arising-3/2025)',
    'Involvement Amount': '0.00',
    'Summon Receiving Date': '15-Oct-2025',
    'Case Section': '1',
    'Initiate By': 'Super Admin(7777777)',
    'Initiate Date Time': '15-Oct-25',
  },

  {
    'Actions': ['D', 'E', 'STC', 'V', 'RF', 'AR', 'U', 'P'],
    'Status': 'Approved',
    'Suit Type': 'Against Bank',
    'Loan Segment': '-',
    'Dependent Type': '-',
    'Risk Factor/Contingent Liability': '-',
    'Monitoring Department': 'Corporate',
    'Requisition': 'Criminal',
    'District': 'Dhaka',
    'Loan A/C or Card No.': '1111111111111111',
    'A/C Name or Name on Card': 'Bbl',
    'Case Number': '/1111(Arising-3/2025)',
    'Involvement Amount': '0.00',
    'Summon Receiving Date': '15-Oct-2025',
    'Case Section': '1',
    'Initiate By': 'Super Admin(7777777)',
    'Initiate Date Time': '15-Oct-25',
  },
  {
    'Actions': ['D', 'E', 'STC', 'V', 'RF', 'AR', 'U', 'P'],
    'Status': 'Approved',
    'Suit Type': 'Against Bank',
    'Loan Segment': '-',
    'Dependent Type': '-',
    'Risk Factor/Contingent Liability': '-',
    'Monitoring Department': 'Corporate',
    'Requisition': 'Criminal',
    'District': 'Dhaka',
    'Loan A/C or Card No.': '1111111111111111',
    'A/C Name or Name on Card': 'Bbl',
    'Case Number': '/1111(Arising-3/2025)',
    'Involvement Amount': '0.00',
    'Summon Receiving Date': '15-Oct-2025',
    'Case Section': '1',
    'Initiate By': 'Super Admin(7777777)',
    'Initiate Date Time': '15-Oct-25',
  },
  {
    'Actions': ['D', 'E', 'STC', 'V', 'RF', 'AR', 'U', 'P'],
    'Status': 'Approved',
    'Suit Type': 'Against Bank',
    'Loan Segment': '-',
    'Dependent Type': '-',
    'Risk Factor/Contingent Liability': '-',
    'Monitoring Department': 'Corporate',
    'Requisition': 'Criminal',
    'District': 'Dhaka',
    'Loan A/C or Card No.': '1111111111111111',
    'A/C Name or Name on Card': 'Bbl',
    'Case Number': '/1111(Arising-3/2025)',
    'Involvement Amount': '0.00',
    'Summon Receiving Date': '15-Oct-2025',
    'Case Section': '1',
    'Initiate By': 'Super Admin(7777777)',
    'Initiate Date Time': '15-Oct-25',
  },
  {
    'Actions': ['D', 'E', 'STC', 'V', 'RF', 'AR', 'U', 'P'],
    'Status': 'Approved',
    'Suit Type': 'Against Bank',
    'Loan Segment': '-',
    'Dependent Type': '-',
    'Risk Factor/Contingent Liability': '-',
    'Monitoring Department': 'Corporate',
    'Requisition': 'Criminal',
    'District': 'Dhaka',
    'Loan A/C or Card No.': '1111111111111111',
    'A/C Name or Name on Card': 'Bbl',
    'Case Number': '/1111(Arising-3/2025)',
    'Involvement Amount': '0.00',
    'Summon Receiving Date': '15-Oct-2025',
    'Case Section': '1',
    'Initiate By': 'Super Admin(7777777)',
    'Initiate Date Time': '15-Oct-25',
  },
];
