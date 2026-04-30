//lib/features/head_office/case_details/presentation/views/lower_court_case_details.dart

import 'package:flutter/material.dart';
import 'case_details_common_view.dart';

class LowerCourtCaseDetailsPage extends StatelessWidget {
  const LowerCourtCaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CaseDetailsCommonView(
      pageTitle: 'Lower Court Cases',
      advancedSearchConfig: const CaseDetailsAdvancedSearchConfig(
        caseTitle: 'Lower Court Case Details',
        showProposedType: false,
        showNo: true,
        showCif: true,
        showTerritory: true,
      ),

      builder: (searchQuery) {
        final filtered = _filterCases(searchQuery);
        if (filtered.isEmpty) return _buildEmptyState();
        return ListView.builder(
          itemCount: filtered.length,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          itemBuilder: (context, index) =>
              LowerCourtCaseCard(caseData: filtered[index]),
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

class LowerCourtCaseCard extends StatefulWidget {
  final Map<String, dynamic> caseData;
  const LowerCourtCaseCard({super.key, required this.caseData});

  @override
  State<LowerCourtCaseCard> createState() => _LowerCourtCaseCardState();
}

class _LowerCourtCaseCardState extends State<LowerCourtCaseCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _ctrl;
  late Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 280));
    _expandAnim =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
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
    if (val == null || val.toString() == '-' || val.toString().isEmpty)
      return '—';
    return val.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSettled =
        widget.caseData['Final Status (Running/ Settled)'] == 'Setteled';
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
                    _infoRow(Icons.gavel_rounded, 'Court',
                        _v('Present Name Of The Court'), const Color(0xFF1552B0)),
                    const SizedBox(height: 8),
                    _infoRow(Icons.monetization_on_rounded, 'Claim Amount',
                        '৳ ${_v('Case Claim Amount')}', const Color(0xFF7C3AED)),
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
                          Icons.picture_as_pdf_rounded,
                          'Export PDF',
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
                        ('Case Type (Main)', _v('3 Type of Case')),
                        ('Case Type (Sub)', _v('Type Of Case')),
                        ('Filing Date', _v('Filling Date')),
                        ('Previous Filing Date', _v('Prev Filling Date')),
                        ('Portfolio', _v('Portfolio')),
                        ('Unique ID', _v('Unique ID')),
                      ]),
                      _divider(),

                      // History Section
                      _sectionHead(
                          'History & Previous Steps', Icons.history_rounded),
                      const SizedBox(height: 12),
                      _historyCard(),
                      _divider(),

                      // Officers & Legal Section
                      _sectionHead(
                          'Officers & Legal', Icons.person_pin_outlined),
                      const SizedBox(height: 12),
                      _labelValueList([
                        ('Lawyer', _v("Lawyer's Name")),
                        ('Dealings Officer', _v('Case Dealings officer')),
                        ('Officer Phone', _v('Case Dealings officer Phone')),
                        ('Filing Plaintiff', _v('Filling Plaintiff')),
                        ('Present Plaintiff', _v('Present Plaintiff')),
                        ('Legal Region', _v('Legal Region')),
                      ]),
                      _divider(),

                      // Court & Location Section
                      _sectionHead(
                          'Court & Location', Icons.location_city_rounded),
                      const SizedBox(height: 12),
                      _labelValueList([
                        ('Present Court', _v('Present Name Of The Court')),
                        ('Previous Court', _v('Previous Name Of The Court')),
                        ('District', _v('District')),
                        ('Territory', _v('Territory')),
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
  Widget _actionBtn(IconData icon, String label, Color color, Color bg,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 11),
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
        // Previous date block
        _historyRow(
          icon: Icons.calendar_today_rounded,
          label: 'Previous Date',
          value: _v('Previous Date'),
          iconColor: const Color(0xFF1552B0),
        ),
        _histDivider(),
        _historyRow(
          icon: Icons.info_outline_rounded,
          label: 'Status on Previous Date',
          value: _v('Case Status On The Previous Date'),
          iconColor: const Color(0xFF7C3AED),
        ),
        _histDivider(),
        _historyRow(
          icon: Icons.task_alt_rounded,
          label: 'Activities Taken',
          value: _v('Activities Taken On The Previous Date'),
          iconColor: const Color(0xFF0D9488),
        ),
        if (widget.caseData[
        'Remarks on Case Status on the Previous date'] !=
            null &&
            widget.caseData[
            'Remarks on Case Status on the Previous date'] !=
                '-') ...[
          _histDivider(),
          _historyRow(
            icon: Icons.comment_outlined,
            label: 'Remarks',
            value: _v('Remarks on Case Status on the Previous date'),
            iconColor: const Color(0xFFD97706),
            italic: true,
          ),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Divider(height: 1, color: Colors.blue.shade100, thickness: 1.5),
        ),
        // Step before previous
        _historyRow(
          icon: Icons.history_rounded,
          label: 'Date Before Previous',
          value: _v('Date Before Previous Date'),
          iconColor: Colors.grey,
        ),
        _histDivider(),
        _historyRow(
          icon: Icons.undo_rounded,
          label: 'Step Before Previous',
          value: _v('Step Before Previous Step'),
          iconColor: Colors.grey,
          isLast: true,
        ),
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
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                  fontStyle:
                  italic ? FontStyle.italic : FontStyle.normal,
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
          Divider(height: 1, indent: 14, endIndent: 14, color: Colors.blue.shade100),
          _footerRow(
            icon: Icons.update_rounded,
            label: 'Last Updated',
            value: _v('Legal as per(last updated date)'),
            color: Colors.grey.shade600,
          ),
          if (hasLegalCost) ...[
            Divider(height: 1, indent: 14, endIndent: 14, color: Colors.blue.shade100),
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

  String _short(String v) => v.length <= 22 ? v : '${v.substring(0, 20)}…';
}

// DUMMY DATA
final List<Map<String, dynamic>> _dummyCases = [
  {
    'Unique ID': '1',
    'Proposed Type': 'Loan',
    'A/C Number': '0201600713859004',
    'Name of Enterprise': 'Tutul Enterprise',
    '3 Type of Case': 'ARA-2003',
    'Type Of Case': 'Arthorin Adalot Ain-2003',
    'Prev Filling Date': '30-april-23',
    'Filling Date': '14-Nov-18',
    'Case Number': 'Artho-13/18',
    'Case Claim Amount': '291,448.86',
    'Date Before Previous Date': '22-Jan-23',
    'Step Before Previous Step': 'Judgement',
    'Previous Date': '24-Jul-23',
    'Case Status On The Previous Date': 'Judgement',
    'Activities Taken On The Previous Date': 'Withdrawal of Certified Copy',
    'Next Date': '30-april-26',
    'Case Status on the Next date': '27-Sep-26',
    'Remarks on Case Status on the Previous date': 'Certified Copy Withdrawal Bill',
    'Filling Plaintiff': 'Md. Hasib Morshed(22508)',
    'Present Plaintiff': 'Md. Hasib Morshed(22508)',
    'Case Dealings officer': 'Md. Hasib Morshed(22508)',
    'Case Dealings officer Phone': '01714084503',
    "Lawyer's Name": 'MD.MUZIBUL HAQUE',
    'Previous Name Of The Court': '2nd Joint Dist & Session Judge Court',
    'Present Name Of The Court': '2nd Joint Dist & Session Judge Court',
    'District': 'Chandpur',
    'Territory': 'BARISAL',
    'Portfolio': 'SME',
    'Legal Region': 'South',
    'Final Status (Running/ Settled)': 'Setteled',
    'Legal Cost': '-',
    'Legal as per(last updated date)': '27-Sep-25',
  },
  {
    'Unique ID': '2',
    'Proposed Type': 'Loan',
    'A/C Number': '6038465600005',
    'Name of Enterprise': 'Sardar Communication',
    '3 Type of Case': 'ARA-2003',
    'Type Of Case': 'Arthorin Adalot Ain-2003',
    'Prev Filling Date': '-',
    'Filling Date': '26-Nov-20',
    'Case Number': 'Artho-46/15(Jari-19/20)(Mis-36/22)',
    'Case Claim Amount': '1,109,625.88',
    'Date Before Previous Date': '27-Sep-23',
    'Step Before Previous Step': '-',
    'Previous Date': '10-Jan-24',
    'Case Status On The Previous Date': 'Auction 33(4)',
    'Activities Taken On The Previous Date': 'Appeal/Revision/Review Hearing',
    'Next Date': 'Yet To Fix',
    'Case Status on the Next date': '-',
    'Remarks on Case Status on the Previous date': '-',
    'Filling Plaintiff': 'Md. Hasib Morshed(22508)',
    'Present Plaintiff': 'Md. Hasib Morshed(22508)',
    'Case Dealings officer': 'Md. Hasib Morshed(22508)',
    'Case Dealings officer Phone': '01714084503',
    "Lawyer's Name": 'SHAHEEN SIDDIQUEE',
    'Previous Name Of The Court': '1st Joint Dist & Session Judge Court',
    'Present Name Of The Court': '1st Joint Dist & Session Judge Court',
    'District': 'Bagerhat',
    'Territory': 'BARISAL',
    'Portfolio': 'SME',
    'Legal Region': 'South',
    'Final Status (Running/ Settled)': 'Running',
    'Legal Cost': '-',
    'Legal as per(last updated date)': '04-Dec-25 11:47 AM',
  },
];