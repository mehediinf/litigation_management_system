// lib/features/legal_team/appeal_and_bail_money/presentation/views/tabs/withdraw_pending_grid_tab.dart

import 'package:flutter/material.dart';
import '../../widgets/empty_state.dart';

class WithdrawPendingGridTab extends StatelessWidget {
  final String loanAc;
  final String caseNumber;
  final String accountName;

  const WithdrawPendingGridTab({
    super.key,
    this.loanAc = '',
    this.caseNumber = '',
    this.accountName = '',
  });

  static final List<Map<String, dynamic>> _allData = [
    {
      'Actions': ['W', 'P'],
      'Total Pending': '3',
      'Account Name': 'Abdul Momin Poultry Farm & Feeds',
      'Account': '5001603918479002',
      'Case Number': 'Artho-42/22(Artho Jari-133/2022)',
      'Deposited Amount': '87000.00',
      'Deposited Percent': '35.4',
      'Deposit Date': '13-10-2025',
      'Arrested': 'Yes',
      'Withdraw Date': '—',
      'status': 'Verified',
    },
    {
      'Actions': ['W', 'P'],
      'Total Pending': '1',
      'Account Name': 'M/S Enamul Engineering Workshop',
      'Account': '1901601719674002',
      'Case Number': 'CR-140/13(SC-268/13)(Appeal-250/14)',
      'Deposited Amount': '136922.50',
      'Deposited Percent': '50',
      'Deposit Date': '17-04-2025',
      'Arrested': 'Yes',
      'Withdraw Date': '—',
      'status': 'Verified',
    },
    {
      'Actions': ['W', 'P'],
      'Total Pending': '1',
      'Account Name': 'M/S Inpa Enterprise',
      'Account': '1518601637847001',
      'Case Number': 'CR-516/14(SC-5823/16)(Criminal A...)',
      'Deposited Amount': '21314.40',
      'Deposited Percent': '10',
      'Deposit Date': '17-04-2025',
      'Arrested': 'Yes',
      'Withdraw Date': '—',
      'status': 'Verified',
    },
    {
      'Actions': ['W', 'P'],
      'Total Pending': '1',
      'Account Name': 'Sazib Traders',
      'Account': '5601603596228001',
      'Case Number': 'CR-226/18(SC-174/19)(Appeal-210/20)',
      'Deposited Amount': '79602.50',
      'Deposited Percent': '50',
      'Deposit Date': '07-05-2024',
      'Arrested': 'Yes',
      'Withdraw Date': '—',
      'status': 'Verified',
    },
    {
      'Actions': ['W', 'P'],
      'Total Pending': '1',
      'Account Name': 'Manik Uzzaman',
      'Account': '1511600482920001',
      'Case Number': 'CR-93/11(SC-23662/18)(Appeal-17...)',
      'Deposited Amount': '188021.50',
      'Deposited Percent': '50',
      'Deposit Date': '07-05-2024',
      'Arrested': 'No',
      'Withdraw Date': '—',
      'status': 'Verified',
    },
  ];

  List<Map<String, dynamic>> get _filteredData {
    if (loanAc.isEmpty && caseNumber.isEmpty && accountName.isEmpty) {
      return _allData;
    }

    return _allData.where((r) {
      final matchLoan = loanAc.isEmpty ||
          r['Account']!.toLowerCase().contains(loanAc.toLowerCase());
      final matchCase = caseNumber.isEmpty ||
          r['Case Number']!.toLowerCase().contains(caseNumber.toLowerCase());
      final matchName = accountName.isEmpty ||
          r['Account Name']!.toLowerCase().contains(accountName.toLowerCase());

      return matchLoan && matchCase && matchName;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final data = _filteredData;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Record count badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F0FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${data.length} records found',
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF1565C0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),

          if (data.isEmpty)
            EmptyState(
              icon: (loanAc.isNotEmpty ||
                      caseNumber.isNotEmpty ||
                      accountName.isNotEmpty)
                  ? Icons.search_off
                  : Icons.inbox_outlined,
              message: (loanAc.isNotEmpty ||
                      caseNumber.isNotEmpty ||
                      accountName.isNotEmpty)
                  ? 'No records match your search criteria'
                  : 'No withdraw pending records found',
            )
          else
            ...data.map((row) => _WithdrawCard(data: row)),
        ],
      ),
    );
  }
}

class _WithdrawCard extends StatefulWidget {
  const _WithdrawCard({required this.data});

  final Map<String, dynamic> data;

  @override
  State<_WithdrawCard> createState() => _WithdrawCardState();
}

class _WithdrawCardState extends State<_WithdrawCard> {
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
    'W': {'icon': Icons.edit_note_rounded, 'desc': 'Withdraw'},
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
    final val = widget.data[key];
    if (val == null || val.toString().trim().isEmpty) return '—';
    return val.toString();
  }

  bool get _isNegativeStatus {
    final s = _v('status').toLowerCase();
    return s.contains('pending') ||
        s.contains('rejected') ||
        s.contains('decline');
  }

  static List<String> _actionKeysForData(Map<String, dynamic> data) {
    final raw = data['Actions'];
    if (raw == null || raw is! Iterable) return const ['P'];

    final out = <String>[];
    for (final e in raw) {
      if (e is String) {
        final k = e.trim();
        if (k.isNotEmpty) out.add(k);
      }
    }
    return out.toSet().toList();
  }

  void _openActionByCode(BuildContext context, String code) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Action: $code for ${_v('Account Name')}'),
      ),
    );
  }

  List<_WithdrawGridActionEntry> _buildActionEntries(BuildContext context) {
    var i = 0;
    final list = <_WithdrawGridActionEntry>[];
    for (final label in _actionKeysForData(widget.data)) {
      final meta = _kActionMeta[label];
      final descObj = meta?['desc'];
      final iconObj = meta?['icon'];
      if (meta == null || descObj is! String || iconObj is! IconData) {
        continue;
      }
      list.add(
        _WithdrawGridActionEntry(
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
                          child: _WithdrawStatusHeaderChip(
                            statusText: _v('status'),
                            isNegative: _isNegativeStatus,
                          ),
                        ),
                        const SizedBox(width: 70),
                        _WithdrawGridActionToggle(
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
                        _WithdrawDataFieldRow(
                            label: 'Total Pending',
                            value: _v('Total Pending')),
                        _WithdrawDataFieldRow(
                            label: 'Account Name', value: _v('Account Name')),
                        _WithdrawDataFieldRow(
                            label: 'Account', value: _v('Account')),
                        _WithdrawDataFieldRow(
                            label: 'Case Number', value: _v('Case Number')),
                        _WithdrawDataFieldRow(
                            label: 'Deposited Amount',
                            value: _v('Deposited Amount')),
                        _WithdrawDataFieldRow(
                            label: 'Deposited Percent',
                            value: _v('Deposited Percent')),
                        _WithdrawDataFieldRow(
                            label: 'Deposit Date', value: _v('Deposit Date')),
                        _WithdrawDataFieldRow(
                            label: 'Arrested', value: _v('Arrested')),
                        _WithdrawDataFieldRow(
                            label: 'Withdraw Date', value: _v('Withdraw Date')),
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
              child: _WithdrawActionsSlidePanel(
                primary: const Color(0xFF1565C0),
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

class _WithdrawStatusHeaderChip extends StatelessWidget {
  const _WithdrawStatusHeaderChip({
    required this.statusText,
    required this.isNegative,
  });

  final String statusText;
  final bool isNegative;

  @override
  Widget build(BuildContext context) {
    final dotColor =
        isNegative ? const Color(0xFFE53935) : const Color(0xFF43A047);
    final borderColor =
        isNegative ? const Color(0xFFEF9A9A) : const Color(0xFFA5D6A7);
    final bgColor =
        isNegative ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9);
    final textColor =
        isNegative ? const Color(0xFFB71C1C) : const Color(0xFF2E7D32);

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

class _WithdrawDataFieldRow extends StatelessWidget {
  const _WithdrawDataFieldRow({required this.label, required this.value});

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
            width: 110,
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

class _WithdrawGridActionToggle extends StatelessWidget {
  const _WithdrawGridActionToggle({
    required this.open,
    required this.badgeCount,
    required this.onTap,
  });

  final bool open;
  final int badgeCount;
  final VoidCallback onTap;

  static const Color _kBlue = Color(0xFF1565C0);

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
              color: open ? _kBlue : Colors.white,
              border: Border.all(
                color: open ? const Color(0xFF0D47A1) : const Color(0xFFE0E5F0),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: open
                      ? _kBlue.withValues(alpha: 0.35)
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
                  color: open ? Colors.white : _kBlue,
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

class _WithdrawActionsSlidePanel extends StatelessWidget {
  const _WithdrawActionsSlidePanel({
    required this.primary,
    required this.entries,
    required this.scrollController,
    required this.onClose,
  });

  final Color primary;
  final List<_WithdrawGridActionEntry> entries;
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
                      colors: [primary, const Color(0xFF1976D2)],
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
                ? const _WithdrawActionsEmptyHint()
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
                        child: _WithdrawCompactActionTile(entry: entries[i]),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _WithdrawActionsEmptyHint extends StatelessWidget {
  const _WithdrawActionsEmptyHint();

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

class _WithdrawGridActionEntry {
  const _WithdrawGridActionEntry({
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

class _WithdrawCompactActionTile extends StatefulWidget {
  const _WithdrawCompactActionTile({required this.entry});

  final _WithdrawGridActionEntry entry;

  @override
  State<_WithdrawCompactActionTile> createState() =>
      _WithdrawCompactActionTileState();
}

class _WithdrawCompactActionTileState extends State<_WithdrawCompactActionTile>
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
