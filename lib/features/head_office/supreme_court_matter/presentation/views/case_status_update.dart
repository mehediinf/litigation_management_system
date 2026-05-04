//lib/features/head_office/supreme_court_matter/presentation/views/case_status_update.dart

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'case_status_update_action/case_status_action_approve_reassign_page.dart';
import 'case_status_update_action/case_status_action_delete_page.dart';
import 'case_status_update_action/case_status_action_edit_page.dart';
import 'case_status_update_action/case_status_action_preview_page.dart';
import 'case_status_update_action/case_status_action_reassign_file_page.dart';
import 'case_status_update_action/case_status_action_send_to_checker_page.dart';
import 'case_status_update_action/case_status_action_verify_page.dart';

class CaseStatusUpdatePage extends StatefulWidget {
  const CaseStatusUpdatePage({super.key});

  @override
  State<CaseStatusUpdatePage> createState() => _CaseStatusUpdatePageState();
}

class _CaseStatusUpdatePageState extends State<CaseStatusUpdatePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
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
                'Case Status Update',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  letterSpacing: 0.2,
                ),
              ),
        actions: [
          _isSearching
              ? IconButton(
                  icon: const Icon(Icons.close_rounded, size: 20),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search_rounded, size: 22),
                  onPressed: () {
                    setState(() => _isSearching = true);
                  },
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
}

// FORM TAB

class _FormTab extends StatefulWidget {
  const _FormTab();

  @override
  State<_FormTab> createState() => _FormTabState();
}

class _FormTabState extends State<_FormTab> {
  String _division = _divisionOptions.first;
  String _caseCategory = _caseCategoryOptions.first;
  String _caseTypes = _caseTypeOptions.first;
  String _proposedType = _proposedTypeOptions.first;

  final _loanAcController = TextEditingController();
  final _caseNumberController = TextEditingController();

  @override
  void dispose() {
    _loanAcController.dispose();
    _caseNumberController.dispose();
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
                  label: 'Division',
                  value: _division,
                  options: _divisionOptions,
                  onChanged: (v) => setState(() => _division = v),
                ),
                _FormDropdown(
                  label: 'Case Category',
                  value: _caseCategory,
                  options: _caseCategoryOptions,
                  onChanged: (v) => setState(() => _caseCategory = v),
                ),
                _FormDropdown(
                  label: 'Case Types',
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
                  label: 'Loan A/C or Card',
                  controller: _loanAcController,
                ),
                _FormTextField(
                  label: 'Case Number',
                  controller: _caseNumberController,
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
                  icon: const Icon(Icons.search_rounded, size: 18),
                  label: const Text('Search'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1552B0),
                    side: const BorderSide(
                      color: Color(0xFF1552B0),
                      width: 1.5,
                    ),
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
  bool _expanded = false;
  bool _showActions = false;
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
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
    'E': {'icon': Icons.edit, 'desc': 'Edit'},
    'STC': {'icon': Icons.send_and_archive, 'desc': 'Send to Checker'},
    'V': {'icon': Icons.verified, 'desc': 'Verify'},
    'P': {'icon': Icons.preview, 'desc': 'Preview'},
  };
  static const List<String> _kDefaultActionKeys = ['D', 'E', 'STC', 'V', 'P'];

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
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _actionScroll.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
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

  String _formatClaimAmount(String raw) {
    final t = raw.trim();
    if (t.isEmpty || t == '—') return '—';
    final d = double.tryParse(t.replaceAll(',', ''));
    if (d == null) return raw;
    final parts = d.toStringAsFixed(2).split('.');
    var intPart = parts[0];
    final neg = intPart.startsWith('-');
    if (neg) intPart = intPart.substring(1);
    final buf = StringBuffer(neg ? '-' : '');
    final len = intPart.length;
    for (var i = 0; i < len; i++) {
      if (i > 0 && (len - i) % 3 == 0) buf.write(',');
      buf.write(intPart[i]);
    }
    return '${buf.toString()}.${parts[1]}';
  }

  void _openActionByCode(BuildContext context, String code) {
    final d = widget.data;
    switch (code) {
      case 'D':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseStatusActionDeletePage(caseData: d),
          ),
        );
        return;
      case 'E':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseStatusActionEditPage(caseData: d),
          ),
        );
        return;
      case 'STC':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseStatusActionSendToCheckerPage(caseData: d),
          ),
        );
        return;
      case 'V':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseStatusActionVerifyPage(caseData: d),
          ),
        );
        return;
      case 'P':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => CaseStatusActionPreviewPage(caseData: d),
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
                              label: 'Case Number',
                              value: _v('Case Number'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Division Name',
                              value: _v('Division Name'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Case Type',
                              value: _v('Case Type'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Case Claim',
                              value: _formatClaimAmount(_v('Case Claim')),
                            ),
                            _CaseDataFieldRow(
                              label: 'Account Name',
                              value: _v('Account Name'),
                            ),
                            _CaseDataFieldRow(
                              label: 'Filing Date',
                              value: _v('Filing Date'),
                            ),
                            _CaseDataFieldRow(
                              label: 'District Name',
                              value: _v('District Name'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _toggle,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8EEF9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _expanded ? 'Collapse' : 'Details',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1552B0),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    _expanded
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down_rounded,
                                    size: 16,
                                    color: const Color(0xFF1552B0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizeTransition(
                        sizeFactor: _anim,
                        child: Column(
                          children: [
                            Divider(height: 1, color: Colors.grey.shade100),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                14,
                                16,
                                14,
                                16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _DetailSection(
                                    title: 'Case Information',
                                    icon: Icons.info_outline_rounded,
                                    items: [
                                      ('Case Status', _v('Case Status')),
                                      ('Case Type', _v('Case Type')),
                                      ('Case Number', _v('Case Number')),
                                      ('Division', _v('Division Name')),
                                      ('Proposed Type', _v('Proposed Type')),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  _DetailSection(
                                    title: 'Account Details',
                                    icon: Icons.credit_card_rounded,
                                    items: [
                                      ('Account Name', _v('Account Name')),
                                      ('Account No', _v('Account')),
                                      ('Case Claim', '৳ ${_v('Case Claim')}'),
                                      (
                                        'Closing Status',
                                        _v('Account Closing Status'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  _DetailSection(
                                    title: 'Activity & Location',
                                    icon: Icons.history_rounded,
                                    items: [
                                      ('Filing Date', _v('Filing Date')),
                                      ('Cause of Action', _v('Cause Action')),
                                      (
                                        'Last Activities',
                                        _v('Last Activities'),
                                      ),
                                      ('Remarks', _v('Remarks')),
                                      ('District', _v('District Name')),
                                      ('Bench Name', _v('Bench Name')),
                                      ('Bench Number', _v('Bench Number')),
                                    ],
                                  ),
                                ],
                              ),
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
          // const SizedBox(width: 4),
          // Icon(
          //   Icons.open_in_new_rounded,
          //   size: 12,
          //   color: dotColor,
          // ),
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
          duration: const Duration(milliseconds: 150),
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
                duration: const Duration(milliseconds: 150),
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
                duration: const Duration(milliseconds: 150),
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

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<(String, String)> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFE8EEF9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 13, color: const Color(0xFF1552B0)),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF334155),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFF),
            borderRadius: BorderRadius.circular(12),
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
                      horizontal: 12,
                      vertical: 9,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 105,
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          ':',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 12,
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
                      indent: 12,
                      endIndent: 12,
                      color: Colors.grey.shade100,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

// CONSTANTS

const List<String> _divisionOptions = [
  'Select Division',
  'High Court Division',
  'Appellate Division',
];

const List<String> _caseCategoryOptions = [
  'Select Case Category',
  'Civil Appeal',
  'Civil Cases',
  'Criminal Case(AD)',
  'Writ Petition',
];

const List<String> _caseTypeOptions = [
  'Select Case Type',
  'First Appeal',
  'First Misc Appeal',
  'Civil Appeal',
  'Criminal Appeal',
  'Civil Revision',
];

const List<String> _proposedTypeOptions = [
  'Proposed Type',
  'Loan',
  'New',
  'Running',
  'Closed',
];

// DUMMY DATA

final List<Map<String, dynamic>> _dummyCases = [
  {
    'Actions': ['D', 'E', 'STC', 'V', 'P'],
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Proposed Type': 'Loan',
    'Account Name': 'Bbl',
    'Account': '1111111111111111',
    'Case Number': 'HC-333333/2025',
    'Case Claim': '333.00',
    'Case Type': 'First Appeal',
    'Case Status': 'Received Rule Copy From High Court',
    'Cause Action': 'asdfsa',
    'Filing Date': '16-10-2025',
    'Last Activities': 'asdf',
    'Remarks': 'asdf',
    'Account Closing Status': 'Yes',
    'District Name': 'Bagerhat',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
  {
    'Actions': ['E', 'P'],
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Case Type': 'First Appeal',
    'Case Status': 'Received Rule Copy From High Court',
    'Case Number': 'HC-3333333333/2025',
    'Case Claim': '333.00',
    'Proposed Type': 'Loan',
    'Account Name': 'asdf',
    'Account': '1111111111111111',
    'Cause Action': 'asdfasdf',
    'Filing Date': '08-10-2025',
    'Last Activities': 'sdf',
    'Remarks': 'asdf',
    'Account Closing Status': 'Yes',
    'District Name': 'Bagerhat',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
  {
    'Actions': <String>[],
    'Status': 'Verified',
    'Division Name': 'Appellate Division',
    'Case Type': 'Civil Appeal',
    'Case Status': 'Power/Authorization Submission',
    'Case Number': 'HC-34242423/2025',
    'Case Claim': '0.00',
    'Proposed Type': '',
    'Account Name': 'sadfasfd',
    'Account': '8888888888888888',
    'Cause Action': 'sadfa',
    'Filing Date': '23-07-2025',
    'Last Activities': 'sadfsa',
    'Remarks': 'asdf',
    'Account Closing Status': 'Yes',
    'District Name': 'Bagerhat',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
  {
    'Actions': ['STC', 'V'],
    'Status': 'Verified',
    'Division Name': 'Appellate Division',
    'Case Type': 'Criminal Appeal',
    'Case Status': 'Summon/Rule Copy Received By Bank',
    'Case Number': 'HC-3455/2025',
    'Case Claim': '0.00',
    'Proposed Type': '',
    'Account Name': 'fsadfsad',
    'Account': '8888888888888888',
    'Cause Action': '555',
    'Filing Date': '23-07-2025',
    'Last Activities': '55',
    'Remarks': '555',
    'Account Closing Status': 'Yes',
    'District Name': 'Bagerhat',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
  {
    'Actions': [
      {'code': 'D'},
      {'code': 'P'},
    ],
    'Status': 'Verified',
    'Division Name': 'Appellate Division',
    'Case Type': 'Criminal Appeal',
    'Case Status': 'Summon/Rule Copy Received By Bank',
    'Case Number': 'HC-33/2025',
    'Case Claim': '333.00',
    'Proposed Type': '',
    'Account Name': 'asdfasdf',
    'Account': '3333333333333333',
    'Cause Action': '33',
    'Filing Date': '20-07-2025',
    'Last Activities': '33',
    'Remarks': '33',
    'Account Closing Status': 'No',
    'District Name': 'Bagerhat',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
  {
    'Actions': ['V'],
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Case Type': 'First Appeal',
    'Case Status': 'Power/Authorization Submission',
    'Case Number': 'HC-11/2025',
    'Case Claim': '1.00',
    'Proposed Type': 'Loan',
    'Account Name': '111',
    'Account': '1111111111111111',
    'Cause Action': '1',
    'Filing Date': '07-07-2025',
    'Last Activities': '1',
    'Remarks': '1',
    'Account Closing Status': 'Yes',
    'District Name': 'Bagerhat',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
  {
    'Actions': ['D', 'E', 'STC', 'P'],
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Case Type': 'First Appeal',
    'Case Status': 'Power/Authorization Submission',
    'Case Number': 'HC-2222222/2025',
    'Case Claim': '33.00',
    'Proposed Type': 'Loan',
    'Account Name': '33',
    'Account': '3333333333333333',
    'Cause Action': 'asdfsadf',
    'Filing Date': '19-02-2025',
    'Last Activities': 'asdf',
    'Remarks': 'asdf',
    'Account Closing Status': 'No',
    'District Name': 'Bagerhat',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
  {
    'Actions': ['D', 'E', 'STC', 'V'],
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Case Type': 'First Appeal',
    'Case Status': 'Obtained Rule Copy From High Court Sec...',
    'Case Number': 'HC-33333333/2025',
    'Case Claim': '333333.00',
    'Proposed Type': 'Loan',
    'Account Name': 'asdfasfd',
    'Account': '3333333333333333',
    'Cause Action': 'fasdf',
    'Filing Date': '19-02-2025',
    'Last Activities': 'asd',
    'Remarks': 'asdfasfd',
    'Account Closing Status': 'No',
    'District Name': 'Bagerhat',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
  {
    'Actions': ['P', 'STC', 'V'],
    'Status': 'File Closed',
    'Division Name': 'High Court Division',
    'Case Type': 'First Misc Appeal',
    'Case Status': 'Obtained Rule Copy From High Court Sec...',
    'Case Number': 'HC-444/2024',
    'Case Claim': '342324.00',
    'Proposed Type': 'Loan',
    'Account Name': 'dsdsf',
    'Account': '1236547893214562',
    'Cause Action': 'sdf ds fd',
    'Filing Date': '22-10-2024',
    'Last Activities': 'zx zx',
    'Remarks': 's fsd f',
    'Account Closing Status': 'No',
    'District Name': 'Bandarban',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
  {
    'Actions': ['E'],
    'Status': 'Verified',
    'Division Name': 'Appellate Division',
    'Case Type': 'Civil Appeal',
    'Case Status': 'Power/Authorization Submission',
    'Case Number': 'HC-88888/2024',
    'Case Claim': '0.00',
    'Proposed Type': '',
    'Account Name': '888',
    'Account': '',
    'Cause Action': '888',
    'Filing Date': '15-05-2024',
    'Last Activities': '88',
    'Remarks': '',
    'Account Closing Status': 'Yes',
    'District Name': 'Bagerhat',
    'Bench Name': 'A',
    'Bench Number': '54654647',
  },
];
