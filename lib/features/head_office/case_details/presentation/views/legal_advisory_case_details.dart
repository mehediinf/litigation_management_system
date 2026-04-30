//lib/features/head_office/case_details/presentation/views/legal_advisory_case_details.dart

import 'package:flutter/material.dart';
import 'case_details_common_view.dart';

class LegalAdvisoryCaseDetailsPage extends StatelessWidget {
  const LegalAdvisoryCaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CaseDetailsCommonView(
      pageTitle: 'Legal Advisory Cases',
      advancedSearchConfig: const CaseDetailsAdvancedSearchConfig(
        caseTitle: 'Legal Advisory Case Details',
        showProposedType: true,
        showNo: true,
        showCif: false,
        showTerritory: false,
        showRegion: false,
        showUnit: false,
        showPortfolio: false,
        showSuitType: true,
        showNextDate: true,
        showMonitoringDept: true,
        showDependentType: true,
        showRiskFactor: true,
        caseTypeOptions: ['Type Of Case', 'Civil', 'Criminal', 'Others'],
        proposedTypeOptions: ['Proposed Type', 'New', 'Running', 'Closed'],
        suitTypeOptions: ['Select Suit Type', 'By Bank', 'Against Bank'],
        districtOptions: ['Select district', 'Dhaka', 'Bagerhat', 'Bhola'],
        monitoringDeptOptions: ['Select Monitoring Dept.', 'Corporate', 'Retail', 'SME'],
        dependentTypeOptions: ['Select dependent Type', 'Test 1', 'Test 2'],
        riskFactorOptions: ['Select Risk Factor', 'High', 'Medium', 'Low'],
      ),
      builder: (searchQuery) {
        final filtered = _filterCases(searchQuery);
        if (filtered.isEmpty) return _buildEmptyState();
        return ListView.builder(
          itemCount: filtered.length,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          itemBuilder: (context, index) =>
              LegalAdvisoryCaseCard(caseData: filtered[index]),
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterCases(String query) {
    if (query.trim().isEmpty) return _dummyCases;
    final q = query.toLowerCase();
    return _dummyCases.where((c) {
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

class LegalAdvisoryCaseCard extends StatefulWidget {
  final Map<String, dynamic> caseData;
  const LegalAdvisoryCaseCard({super.key, required this.caseData});

  @override
  State<LegalAdvisoryCaseCard> createState() => _LegalAdvisoryCaseCardState();
}

class _LegalAdvisoryCaseCardState extends State<LegalAdvisoryCaseCard>
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
    if (val == null || val.toString() == '-' || val.toString().isEmpty) {
      return '—';
    }
    return val.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSettled = widget.caseData['Final Remarks'] == 'Setteled';
    final Color statusColor =
        isSettled ? const Color(0xFF1B8A5A) : const Color(0xFFD97706);
    final Color statusBg =
        isSettled ? const Color(0xFFDCF5EB) : const Color(0xFFFEF3C7);
    final Color accentColor =
        isSettled ? const Color(0xFF1B8A5A) : const Color(0xFF1552B0);

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
                    // Row 1: accent stripe + name + status badge
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
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isSettled ? 'Settled' : 'Running',
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Summary Info: single column label-value
                    _infoRow(Icons.tag_rounded, 'Case Number',
                        _v('Case Number'), accentColor),
                    const SizedBox(height: 8),
                    _infoRow(Icons.credit_card_rounded, 'A/C Number',
                        _v('A/C Number'), accentColor),
                    const SizedBox(height: 8),
                    _infoRow(Icons.gavel_rounded, 'Suit Type', _v('Suit Type'),
                        const Color(0xFF1552B0)),
                    const SizedBox(height: 8),
                    _infoRow(Icons.monetization_on_rounded, 'Involvement Amount',
                        '৳ ${_v('Involvement Amount')}', const Color(0xFF7C3AED)),
                    const SizedBox(height: 8),
                    _infoRow(
                      Icons.event_rounded,
                      'Next Date',
                      _v('Next Date') == '—' ? 'TBD' : _v('Next Date'),
                      const Color(0xFFD97706),
                    ),
                    const SizedBox(height: 14),

                    // Action Row
                    Row(
                      children: [
                        _actionBtn(
                          Icons.preview,
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
                      // Case Details Section
                      _sectionHead('Case Details', Icons.description_outlined),
                      const SizedBox(height: 12),
                      _labelValueList([
                        ('Case Type (Main)', _v('3 Type of case')),
                        ('Case Type (Sub)', _v('Type Of Case')),
                        ('Filing Date', _v('Filing Date')),
                        ('Dependent Type', _v('Dependent Type')),
                        ('Loan Segment', _v('Loan Segment')),
                        ('Risk Factor', _v('Risk Factor')),
                      ]),
                      _divider(),

                      // History Section
                      _sectionHead(
                          'History & Steps', Icons.history_rounded),
                      const SizedBox(height: 12),
                      _historyCard(),
                      _divider(),

                      // Officers & Legal Section
                      _sectionHead(
                          'Officers & Legal', Icons.person_pin_outlined),
                      const SizedBox(height: 12),
                      _labelValueList([
                        ('Lawyer', _v('Lawyer')),
                        ('Dealing Officer', _v('Dealing Officer')),
                        ('Monitoring Dept.', _v('Monitoring Dept.')),
                      ]),
                      _divider(),

                      // Location Section
                      _sectionHead(
                          'Location', Icons.location_city_rounded),
                      const SizedBox(height: 12),
                      _labelValueList([
                        ('District', _v('District')),
                      ]),
                      _divider(),

                      _footer(),
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
                  color: color == const Color(0xFFD97706) ||
                          color == const Color(0xFF7C3AED)
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
  Widget _actionBtn(
      IconData icon, String label, Color color, Color bg, VoidCallback onTap) {
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

  //History card
  Widget _historyCard() => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFDDE5F7)),
        ),
        child: Column(
          children: [
            _historyRow(
              icon: Icons.calendar_today_rounded,
              label: 'Previous Date',
              value: _v('Previous Date'),
              iconColor: const Color(0xFF1552B0),
            ),
            _histDivider(),
            _historyRow(
              icon: Icons.info_outline_rounded,
              label: 'Status on Previous',
              value: _v('Case Status On The Previous'),
              iconColor: const Color(0xFF7C3AED),
            ),
            _histDivider(),
            _historyRow(
              icon: Icons.event_available_rounded,
              label: 'Summon Date',
              value: _v('Summon Receiving Date'),
              iconColor: const Color(0xFF0D9488),
            ),
            _histDivider(),
            _historyRow(
              icon: Icons.update_rounded,
              label: 'Next Status',
              value: _v('Case Status Next Date'),
              iconColor: const Color(0xFFD97706),
            ),
            if (widget.caseData['Background /Case history'] != null &&
                widget.caseData['Background /Case history'] != '-') ...[
              _histDivider(),
              _historyRow(
                icon: Icons.history_edu_rounded,
                label: 'Background',
                value: _v('Background /Case history'),
                iconColor: Colors.grey,
                isLast: true,
              ),
            ],
          ],
        ),
      );

  Widget _historyRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    bool italic = false,
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
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                  fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _histDivider() => Divider(
        height: 1,
        indent: 14,
        endIndent: 14,
        color: Colors.grey.shade100,
      );

  // Footer
  Widget _footer() {
    final hasLegalCost = widget.caseData['Legal Cost'] != null &&
        widget.caseData['Legal Cost'] != '-';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDE5F7)),
      ),
      child: Column(
        children: [
          _footerRow(
            icon: Icons.event_rounded,
            label: 'Next Date',
            value: _v('Next Date'),
            color: const Color(0xFF1552B0),
          ),
          Divider(
              height: 1, indent: 14, endIndent: 14, color: Colors.blue.shade100),
          _footerRow(
            icon: Icons.update_rounded,
            label: 'Last Updated',
            value: _v('Legal as per(last updated date)'),
            color: Colors.grey.shade600,
          ),
          if (hasLegalCost) ...[
            Divider(
                height: 1,
                indent: 14,
                endIndent: 14,
                color: Colors.blue.shade100),
            _footerRow(
              icon: Icons.payments_outlined,
              label: 'Legal Cost',
              value: _v('Legal Cost'),
              color: const Color(0xFF0D9488),
              isLast: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _footerRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool isLast = false,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 10),
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
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                value == '—' ? 'Not set' : value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
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

// DUMMY DATA FOR LEGAL ADVISORY
final List<Map<String, dynamic>> _dummyCases = [
  {
    'SI No': '46',
    'A/C Number': '1111111111111111',
    'Suit Type': 'Against Bank',
    'Dependent Type': '-',
    'Loan Segment': '-',
    'Risk Factor': '-',
    'Involvement Amount': '-',
    'Summon Receiving Date': '-',
    'Monitoring Dept.': 'Corporate',
    'A/C Name': 'Bbl',
    '3 Type of case': 'Criminal',
    'Type Of Case': 'Title Suit',
    'Filing Date': '11-Aug-25',
    'Case Number': '/1111(Criminal-444/2025)(Criminal-85/2025)',
    'Previous Date': '-',
    'Case Status On The Previous': 'Auction 33(4)',
    'Next Date': '11-Aug-25',
    'Case Status Next Date': '-',
    'Background /Case history': '-',
    'Dealing Officer': 'Md. Sohel Rana(22521)',
    'Lawyer': 'ALHAJ MD NASIR ADVOCATE',
    'District': 'Bhola',
    'Final Remarks': 'Setteled',
    'Legal Cost': '-',
    'Legal as per(last updated date)': '27-Sep-25',
  },
  {
    'SI No': '47',
    'A/C Number': '—',
    'Suit Type': 'Against Bank',
    'Dependent Type': 'Test 1',
    'Loan Segment': 'Corporate',
    'Risk Factor': 'High',
    'Involvement Amount': '666.00',
    'Summon Receiving Date': '-',
    'Monitoring Dept.': 'Corporate',
    'A/C Name': '—',
    '3 Type of case': 'Civil',
    'Type Of Case': 'Civil Suit',
    'Filing Date': '14-Oct-25',
    'Case Number': 'asdfsa-333/2025',
    'Previous Date': '14-Oct-25',
    'Case Status On The Previous': 'Auction 33(4)',
    'Next Date': 'Yet To Fix',
    'Case Status Next Date': '-',
    'Background /Case history': 'asdfsdf',
    'Dealing Officer': 'Ramprosad Mondal(13412)',
    'Lawyer': 'MD.MUZIBUL HAQUE',
    'District': 'Bagerhat',
    'Final Remarks': 'Running',
    'Legal Cost': '-',
    'Legal as per(last updated date)': '04-Dec-25 11:47 AM',
  },
  {
    'SI No': '48',
    'A/C Number': '—',
    'Suit Type': 'By Bank',
    'Dependent Type': 'Test 1',
    'Loan Segment': 'Corporate',
    'Risk Factor': 'High',
    'Involvement Amount': '3.00',
    'Summon Receiving Date': '14-Oct-25',
    'Monitoring Dept.': 'Corporate',
    'A/C Name': '—',
    '3 Type of case': 'Others',
    'Type Of Case': 'Arising',
    'Filing Date': '14-Oct-25',
    'Case Number': 'Arising-3/2025',
    'Previous Date': '14-Oct-25',
    'Case Status On The Previous': 'Auction 33(4)',
    'Next Date': 'Yet To Fix',
    'Case Status Next Date': '-',
    'Background /Case history': '-',
    'Dealing Officer': 'Ramprosad Mondal(13412)',
    'Lawyer': 'MD.MUZIBUL HAQUE',
    'District': 'Bagerhat',
    'Final Remarks': 'Running',
    'Legal Cost': '-',
    'Legal as per(last updated date)': '04-Dec-25 11:47 AM',
  },
];
