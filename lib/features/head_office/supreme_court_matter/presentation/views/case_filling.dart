// lib/features/head_office/supreme_court_matter/presentation/views/case_filling.dart

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CaseFillingPage extends StatefulWidget {
  const CaseFillingPage({super.key});

  @override
  State<CaseFillingPage> createState() => _CaseFillingPageState();
}

class _CaseFillingPageState extends State<CaseFillingPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Case Filing',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            letterSpacing: 0.2,
          ),
        ),
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
              labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13.5),
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
        children: const [
          _FormTab(),
          _DataGridTab(),
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
                    side: const BorderSide(color: Color(0xFF1552B0), width: 1.5),
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
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('New'),
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
                      color: Color(0xFF1552B0), width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
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
                      horizontal: 12, vertical: 10),
                ),
              ),
              menuProps: MenuProps(
                borderRadius: BorderRadius.circular(14),
              ),
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
                borderSide: const BorderSide(color: Color(0xFF1552B0), width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
  const _DataGridTab();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: _dummyCases.length,
      itemBuilder: (context, index) {
        final item = _dummyCases[index];
        return _CaseGridCard(data: item, index: index);
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
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 260));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
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

  Color get _statusColor {
    final status = _v('Status');
    if (status.toLowerCase().contains('verified')) return const Color(0xFF059669);
    if (status.toLowerCase().contains('closed')) return const Color(0xFFEF4444);
    return const Color(0xFFD97706);
  }

  @override
  Widget build(BuildContext context) {
    final bool isVerified = _v('Status').toLowerCase().contains('verified');
    final Color accent = isVerified ? const Color(0xFF059669) : const Color(0xFF1552B0);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: Rule Number + Status badge
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 36,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _v('Rule Number'),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14.5,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _v('Division Name'),
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _StatusBadge(label: _v('Status'), color: _statusColor),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Quick info chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _InfoChip(
                        icon: Icons.category_rounded,
                        label: _v('Case Category'),
                        color: const Color(0xFF1552B0),
                      ),
                      _InfoChip(
                        icon: Icons.gavel_rounded,
                        label: _v('Case Type'),
                        color: const Color(0xFF7C3AED),
                      ),
                      _InfoChip(
                        icon: Icons.monetization_on_rounded,
                        label: '৳ ${_v('Case Claim')}',
                        color: const Color(0xFF059669),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Actions Wrap + Details button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _ActionIconBtn(
                            icon: Icons.delete_outline_rounded,
                            color: const Color(0xFFEF4444),
                            bg: const Color(0xFFFEE2E2),
                            onTap: () {},
                            tooltip: 'Delete (D)',
                            label: 'D',
                          ),
                          _ActionIconBtn(
                            icon: Icons.edit_outlined,
                            color: const Color(0xFF1552B0),
                            bg: const Color(0xFFE8EEF9),
                            onTap: () {},
                            tooltip: 'Edit (E)',
                            label: 'E',
                          ),
                          _ActionIconBtn(
                            icon: Icons.send_rounded,
                            color: const Color(0xFFD97706),
                            bg: const Color(0xFFFEF3C7),
                            onTap: () {},
                            tooltip: 'Send to Checker (STC)',
                            label: 'STC',
                          ),
                          _ActionIconBtn(
                            icon: Icons.verified_rounded,
                            color: const Color(0xFF059669),
                            bg: const Color(0xFFD1FAE5),
                            onTap: () {},
                            tooltip: 'Verify (V)',
                            label: 'V',
                          ),
                          _ActionIconBtn(
                            icon: Icons.swap_horiz_rounded,
                            color: const Color(0xFF0D9488),
                            bg: const Color(0xFFCCFBF1),
                            onTap: () {},
                            tooltip: 'Reassign File (RF)',
                            label: 'RF',
                          ),
                          _ActionIconBtn(
                            icon: Icons.how_to_reg_rounded,
                            color: const Color(0xFF7C3AED),
                            bg: const Color(0xFFEDE9FE),
                            onTap: () {},
                            tooltip: 'Approve Reassign (AR)',
                            label: 'AR',
                          ),
                          _ActionIconBtn(
                            icon: Icons.table_chart_rounded,
                            color: const Color(0xFF475569),
                            bg: const Color(0xFFF1F5F9),
                            onTap: () {},
                            tooltip: 'Preview (P)',
                            label: 'P',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
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
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Expanded Detail Section
          SizeTransition(
            sizeFactor: _anim,
            child: Column(
              children: [
                Divider(height: 1, color: Colors.grey.shade100),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailSection(
                        title: 'Case Information',
                        icon: Icons.info_outline_rounded,
                        items: [
                          ('Case Status', _v('Case Status')),
                          ('Case Category', _v('Case Category')),
                          ('Case Type', _v('Case Type')),
                          ('Rule Number', _v('Rule Number')),
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
                          ('Closing Status', _v('Account Closing Status')),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _DetailSection(
                        title: 'Activity & Location',
                        icon: Icons.history_rounded,
                        items: [
                          ('Filing Date', _v('Filing Date')),
                          ('Cause of Action', _v('Cause Action')),
                          ('Last Activities', _v('Last Activities')),
                          ('Remarks', _v('Remarks')),
                          ('District', _v('District Name')),
                          ('HC Bench', _v('HC Bench')),
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
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionIconBtn extends StatelessWidget {
  const _ActionIconBtn({
    required this.icon,
    required this.color,
    required this.bg,
    required this.onTap,
    required this.tooltip,
    required this.label,
  });
  final IconData icon;
  final Color color;
  final Color bg;
  final VoidCallback onTap;
  final String tooltip;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
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
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
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
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Type': 'First Appeal',
    'Case Status': 'Received Rule Copy From High Court',
    'Rule Number': 'HC-333333/2025',
    'Case Claim': '333.00',
    'Proposed Type': 'Loan',
    'Account Name': 'Bbl',
    'Account': '1111111111111111',
    'Cause Action': 'asdfsa',
    'Filing Date': '16-10-2025',
    'Last Activities': 'asdf',
    'Remarks': 'asdf',
    'Account Closing Status': 'Yes',
    'District Name': 'Bagerhat',
    'HC Bench': 'A',
  },
  {
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Type': 'First Appeal',
    'Case Status': 'Received Rule Copy From High Court',
    'Rule Number': 'HC-3333333333/2025',
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
    'HC Bench': 'A',
  },
  {
    'Status': 'Verified',
    'Division Name': 'Appellate Division',
    'Case Category': 'Civil Cases',
    'Case Type': 'Civil Appeal',
    'Case Status': 'Power/Authorization Submission',
    'Rule Number': 'HC-34242423/2025',
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
    'HC Bench': 'A',
  },
  {
    'Status': 'Verified',
    'Division Name': 'Appellate Division',
    'Case Category': 'Criminal Case(AD)',
    'Case Type': 'Criminal Appeal',
    'Case Status': 'Summon/Rule Copy Received By Bank',
    'Rule Number': 'HC-3455/2025',
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
    'HC Bench': 'A',
  },
  {
    'Status': 'Verified',
    'Division Name': 'Appellate Division',
    'Case Category': 'Criminal Case(AD)',
    'Case Type': 'Criminal Appeal',
    'Case Status': 'Summon/Rule Copy Received By Bank',
    'Rule Number': 'HC-33/2025',
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
    'HC Bench': 'A',
  },
  {
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Type': 'First Appeal',
    'Case Status': 'Power/Authorization Submission',
    'Rule Number': 'HC-11/2025',
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
    'HC Bench': 'A',
  },
  {
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Type': 'First Appeal',
    'Case Status': 'Power/Authorization Submission',
    'Rule Number': 'HC-2222222/2025',
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
    'HC Bench': 'A',
  },
  {
    'Status': 'Verified',
    'Division Name': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Type': 'First Appeal',
    'Case Status': 'Obtained Rule Copy From High Court Sec...',
    'Rule Number': 'HC-33333333/2025',
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
    'HC Bench': 'A',
  },
  {
    'Status': 'File Closed',
    'Division Name': 'High Court Division',
    'Case Category': 'Civil Appeal',
    'Case Type': 'First Misc Appeal',
    'Case Status': 'Obtained Rule Copy From High Court Sec...',
    'Rule Number': 'HC-444/2024',
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
    'HC Bench': 'A',
  },
  {
    'Status': 'Verified',
    'Division Name': 'Appellate Division',
    'Case Category': 'Civil Cases',
    'Case Type': 'Civil Appeal',
    'Case Status': 'Power/Authorization Submission',
    'Rule Number': 'HC-88888/2024',
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
    'HC Bench': 'A',
  },
];