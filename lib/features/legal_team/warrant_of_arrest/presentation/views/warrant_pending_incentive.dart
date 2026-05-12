// lib/features/legal_team/warrant_of_arrest/presentation/views/warrant_pending_incentive.dart

import 'package:flutter/material.dart';

import 'pending_incentive/pending_incentive_action_preview_page.dart'
    show PendingIncentiveActionPreviewPage;
import 'pending_incentive/pending_incentive_action_stc_page.dart'
    show PendingIncentiveActionSendToCheckerPage;
import 'pending_incentive/pending_incentive_action_verify_page.dart';

class PendingIncentivePage extends StatefulWidget {
  const PendingIncentivePage({super.key});

  @override
  State<PendingIncentivePage> createState() => _PendingIncentivePageState();
}

class _PendingIncentivePageState extends State<PendingIncentivePage> {
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

  void _onQueryChanged(String value) => setState(() => _searchQuery = value);

  List<Map<String, dynamic>> _filterCases(String query) {
    if (query.trim().isEmpty) return _dummyCases;
    final q = query.toLowerCase();
    return _dummyCases
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
    final nameController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setLocalState) => Dialog(
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
                //  Dialog header
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
                //  Fields
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _dropdownField(
                          label: 'Proposed Type',
                          value: proposedType,
                          options: ['Proposed Type', 'Loan', 'New', 'Running'],
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
                // Footer
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
                          onPressed: () => setLocalState(() {
                            proposedType = 'Proposed Type';
                            loanAcController.clear();
                            caseNoController.clear();
                            nameController.clear();
                          }),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey.shade600,
                            side: BorderSide(color: Colors.grey.shade300),
                            padding: const EdgeInsets.symmetric(vertical: 14),
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
                            final parts = <String>[
                              if (loanAcController.text.trim().isNotEmpty)
                                loanAcController.text.trim(),
                              if (caseNoController.text.trim().isNotEmpty)
                                caseNoController.text.trim(),
                              if (nameController.text.trim().isNotEmpty)
                                nameController.text.trim(),
                              if (proposedType != 'Proposed Type') proposedType,
                            ];
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
      ),
    );

    loanAcController.dispose();
    caseNoController.dispose();
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
                  'Pending Incentive',
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
                    itemBuilder: (context, index) =>
                        _CaseCard(caseData: filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

// Case Card

class _CaseCard extends StatefulWidget {
  const _CaseCard({required this.caseData});

  final Map<String, dynamic> caseData;

  @override
  State<_CaseCard> createState() => _CaseCardState();
}

class _CaseCardState extends State<_CaseCard> {
  bool _showActions = false;
  late final ScrollController _actionScroll;

  static const List<Color> _kActionAccents = [
    Color(0xFF4361EE),
    Color(0xFF2EC4B6),
    Color(0xFFF77F00),
    Color(0xFF9B5DE5),
    Color(0xFFEF233C),
    Color(0xFF06D6A0),
  ];

  static const Map<String, Map<String, Object>> _kActionMeta = {
    'STC': {'icon': Icons.send, 'desc': 'Send To Checker'},
    'V': {'icon': Icons.verified, 'desc': 'Verify'},
    'P': {'icon': Icons.preview, 'desc': 'Preview'},
  };

  @override
  void initState() {
    super.initState();
    _actionScroll = ScrollController();
  }

  @override
  void dispose() {
    _actionScroll.dispose();
    super.dispose();
  }

  String _v(String key) {
    final val = widget.caseData[key];
    if (val == null || val.toString().trim().isEmpty) return '—';
    return val.toString();
  }

  bool get _isNegativeType {
    final s = _v('Type').toLowerCase();
    final cs = _v('Case Type').toLowerCase();
    return s.contains('closed') ||
        s.contains('decline') ||
        s.contains('rejected') ||
        cs.contains('decline');
  }

  static List<String> _actionKeysForCase(Map<String, dynamic> data) {
    final raw = data['Actions'];
    if (raw == null) return const ['STC', 'V', 'P'];
    if (raw is! Iterable) return const ['STC', 'V', 'P'];

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

  void _openActionByCode(BuildContext context, String code) {
    final d = widget.caseData;
    switch (code) {
      case 'STC':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) =>
                PendingIncentiveActionSendToCheckerPage(caseData: d),
          ),
        );
        return;
      case 'V':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => PendingIncentiveActionVerifyPage(caseData: d),
          ),
        );
        return;
      case 'P':
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => PendingIncentiveActionPreviewPage(caseData: d),
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
    for (final label in _actionKeysForCase(widget.caseData)) {
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
              child: Column(
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
                            statusText: _v('Type'),
                            isNegative: _isNegativeType,
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
                        _CaseDataFieldRow(label: 'Name', value: _v('Name')),

                        _CaseDataFieldRow(label: 'Pin', value: _v('Pin')),

                        // _CaseDataFieldRow(label: 'Type', value: _v('Type')),
                        _CaseDataFieldRow(
                          label: 'Account Name',
                          value: _v('Account Name'),
                        ),

                        _CaseDataFieldRow(
                          label: 'Account',
                          value: _v('Account'),
                        ),

                        _CaseDataFieldRow(
                          label: 'Case Number',
                          value: _v('Case Number'),
                        ),

                        _CaseDataFieldRow(label: 'Amount', value: _v('Amount')),

                        _CaseDataFieldRow(
                          label: 'Particulars',
                          value: _v('Particulars'),
                        ),
                      ],
                    ),
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
                      colors: [primary, const Color(0xFFFF6B35)],
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

final List<Map<String, dynamic>> _dummyCases = [
  {
    'Actions': ['STC', 'V', 'P'],
    'Name': 'Admin Recovery Maker',
    'Pin': '7777777',
    'Type': 'HOOPS',
    'Account Name': 'Bbl',
    'Account': '1111111111111111',
    'Case Number': 'Artho-01/15',
    'Amount': '33.00',
    'Particulars': 'tere',
  },
  {
    'Actions': ['STC', 'V', 'P'],
    'Name': 'Admin Recovery Maker',
    'Pin': '7777777',
    'Type': 'HOOPS',
    'Account Name': 'Bbl',
    'Account': '1111111111111111',
    'Case Number': 'Artho-01/15',
    'Amount': '33.00',
    'Particulars': 'tere',
  },
  {
    'Actions': ['STC', 'V', 'P'],
    'Name': 'Admin Recovery Maker',
    'Pin': '7777777',
    'Type': 'HOOPS',
    'Account Name': 'Bbl',
    'Account': '1111111111111111',
    'Case Number': 'Artho-01/15',
    'Amount': '33.00',
    'Particulars': 'tere',
  },
  {
    'Actions': ['STC', 'V', 'P'],
    'Name': 'Admin Recovery Maker',
    'Pin': '7777777',
    'Type': 'HOOPS',
    'Account Name': 'Bbl',
    'Account': '1111111111111111',
    'Case Number': 'Artho-01/15',
    'Amount': '33.00',
    'Particulars': 'tere',
  },
];
