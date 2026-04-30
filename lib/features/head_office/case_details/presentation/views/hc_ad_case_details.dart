// lib/features/head_office/case_details/presentation/views/hc_ad_case_details.dart

import 'package:flutter/material.dart';
import 'case_details_common_view.dart';

class HcAdCaseDetailsPage extends StatelessWidget {
  const HcAdCaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CaseDetailsCommonView(
      pageTitle: 'HC/AD Case Details',
      advancedSearchConfig: const CaseDetailsAdvancedSearchConfig(
        caseTitle: 'HC/AD Case Details',
        showDivision: true,
        showCategory: true,
        showCaseType: true,
        showProposedType: true,
        showNo: true,
        showCif: false,
        showTerritory: false,
        showRegion: false,
        showDistrict: false,
        showUnit: false,
        showFilingDate: false,
        showPortfolio: false,
        showCaseNo: false,
        caseTypeOptions: ['Select Case Type', 'First Appeal', 'First Misc Appeal', 'Civil Revision'],
        divisionOptions: ['Select Division', 'High Court Division', 'Appellate Division'],
        categoryOptions: ['Select Case Category', 'Civil Appeal', 'Criminal Appeal', 'Writ Petition'],
      ),
      builder: (searchQuery) {
        final filtered = _filterCases(searchQuery);
        if (filtered.isEmpty) return _buildEmptyState();
        return ListView.builder(
          itemCount: filtered.length,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          itemBuilder: (context, index) {
            final caseData = filtered[index];
            return HcAdCaseCard(caseData: caseData);
          },
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterCases(String query) {
    if (query.trim().isEmpty) return _dummyHcCases;
    final q = query.toLowerCase();
    return _dummyHcCases.where((c) {
      return c.values
          .any((v) => v != null && v.toString().toLowerCase().contains(q));
    }).toList();
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
            child: const Icon(Icons.search_off_rounded,
                size: 36, color: Color(0xFF1552B0)),
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
}

// CASE CARD

class HcAdCaseCard extends StatefulWidget {
  final Map<String, dynamic> caseData;
  const HcAdCaseCard({super.key, required this.caseData});

  @override
  State<HcAdCaseCard> createState() => _HcAdCaseCardState();
}

class _HcAdCaseCardState extends State<HcAdCaseCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _ctrl;
  late Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 280));
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

  // safe getter — never returns null
  String _v(String key) {
    final val = widget.caseData[key];
    if (val == null || val.toString().isEmpty) return '—';
    return val.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSpecialStatus =
        widget.caseData['Status']?.toString().contains('Received') ?? false;
    final Color accentColor =
    isSpecialStatus ? const Color(0xFF1B8A5A) : const Color(0xFF1552B0);
    final Color statusBg =
    isSpecialStatus ? const Color(0xFFDCF5EB) : const Color(0xFFE8EEF9);
    final Color statusColor =
    isSpecialStatus ? const Color(0xFF1B8A5A) : const Color(0xFF1552B0);

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
          // HEADER
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
                    // accent stripe + name + status badge
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

                    _infoRow(Icons.tag_rounded, 'Case No',
                        _v('CASE NO'), accentColor),
                    const SizedBox(height: 8),
                    _infoRow(Icons.credit_card_rounded, 'A/C Number',
                        _v('A/C NO'), accentColor),
                    const SizedBox(height: 8),
                    _infoRow(Icons.account_balance_rounded, 'Division',
                        _v('Division'), const Color(0xFF1552B0)),
                    const SizedBox(height: 8),
                    _infoRow(Icons.monetization_on_rounded, 'Claim Amount',
                        '৳ ${_v('Case Claim')}', const Color(0xFF7C3AED)),
                    const SizedBox(height: 8),
                    _infoRow(Icons.event_rounded, 'Filing Date',
                        _v('Filing Date'), const Color(0xFFD97706)),
                    const SizedBox(height: 14),

                    // Action Row
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

          // EXPANDED DETAILS
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
                      // ── Case Classification Section ──
                      _sectionHead(
                          'Case Classification', Icons.description_outlined),
                      const SizedBox(height: 12),
                      _labelValueList([
                        ('Sl', _v('Sl')),
                        ('Case Category', _v('Case Category')),
                        ('Case Types', _v('Case Types')),
                        ('Filing Date', _v('Filing Date')),
                        ('Claim Amount', '৳ ${_v('Case Claim')}'),
                        ('Portfolio', _v('Portfolio')),
                        ('District', _v('NAME OF DIST')),
                      ]),
                      _divider(),

                      // Status & Activities Section
                      _sectionHead(
                          'Status & Last Activities', Icons.history_rounded),
                      const SizedBox(height: 12),
                      _statusCard(),
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

  // Single-row info item
  Widget _infoRow(
      IconData icon, String label, String value, Color color) {
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
                  color: (color == const Color(0xFFD97706) ||
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

  // Action button
  Widget _actionBtn(IconData icon, String label, Color color, Color bg,
      VoidCallback onTap) {
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

  // Expand / Collapse button
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

  // Section heading
  Widget _sectionHead(String title, IconData icon) => Row(
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

  // Single-column label → value list
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
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label column — fixed width
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
                    // Separator
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Value column — takes remaining space
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

  // Status card
  Widget _statusCard() => Container(
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
        Divider(
            height: 1,
            indent: 14,
            endIndent: 14,
            color: Colors.grey.shade100),
        _statusRow(
          icon: Icons.task_alt_rounded,
          label: 'Last Activity',
          value: _v('LAST ACTIVITIES'),
          iconColor: const Color(0xFF0D9488),
        ),
        Divider(
            height: 1,
            indent: 14,
            endIndent: 14,
            color: Colors.grey.shade100),
        _statusRow(
          icon: Icons.gavel_rounded,
          label: 'Cause of Action',
          value: _v('PRESENT CAUSE OF ACTION'),
          iconColor: const Color(0xFF7C3AED),
          isLast: true,
        ),
      ],
    ),
  );

  Widget _statusRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    bool isLast = false,
  }) =>
      Padding(
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


  Widget _divider() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 18),
    child: Divider(height: 1, color: Colors.grey.shade100),
  );
}

// DUMMY DATA
final List<Map<String, dynamic>> _dummyHcCases = [
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
    'Status': 'Received Rule Copy From High Court',
    'LAST ACTIVITIES': 'asdf',
    'PRESENT CAUSE OF ACTION': 'asdfsa',
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
    'Status': 'Power/Authorization Submission',
    'LAST ACTIVITIES': 'sf',
    'PRESENT CAUSE OF ACTION': 'asdfsdf',
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
    'Status': 'Obtained Judgment & Judgment Copy',
    'LAST ACTIVITIES': 'asdf',
    'PRESENT CAUSE OF ACTION': 'asdf',
  },
];