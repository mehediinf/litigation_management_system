// lib/features/legal_team/appeal_and_bail_money/presentation/views/appeal_deposit_withdraw.dart

import 'package:flutter/material.dart';
import 'tabs/deposit_form_tab.dart';
import 'tabs/deposit_data_grid_tab.dart';
import 'tabs/withdraw_pending_grid_tab.dart';
import 'tabs/withdrawn_grid_tab.dart';

class AppealDepositWithdrawPage extends StatefulWidget {
  const AppealDepositWithdrawPage({super.key});

  @override
  State<AppealDepositWithdrawPage> createState() =>
      _AppealDepositWithdrawPageState();
}

class _AppealDepositWithdrawPageState extends State<AppealDepositWithdrawPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  String _selectedProposedType = 'Loan';
  final TextEditingController _loanAcController = TextEditingController();
  final TextEditingController _caseNumberController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();

  static const Color _primaryBlue = Color(0xFF1565C0);

  final List<_TabData> _tabs = const [
    _TabData(label: 'Deposit Form', icon: Icons.add_circle_outline),
    _TabData(label: 'Deposit Grid', icon: Icons.table_rows_outlined),
    _TabData(label: 'Pending Grid', icon: Icons.hourglass_empty_rounded),
    _TabData(label: 'Withdrawn Grid', icon: Icons.check_circle_outline),
  ];

  bool get _searchApplicable => _selectedIndex != 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging) {
          setState(() {
            _selectedIndex = _tabController.index;
            _clearSearch();
          });
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loanAcController.dispose();
    _caseNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _loanAcController.clear();
    _caseNumberController.clear();
    _accountNameController.clear();
  }

  void _showSearchDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(
            opacity: anim1.value,
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 10,
                  titlePadding: EdgeInsets.zero,
                  title: Container(
                    padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                    decoration: BoxDecoration(
                      color: _primaryBlue.withOpacity(0.05),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.manage_search_rounded,
                            color: _primaryBlue,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Search Filters',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A237E),
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                'Refine your results',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        _buildSearchField(
                          'Proposed Type',
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedProposedType,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: _primaryBlue,
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              items: ['Loan', 'Card', 'Other']
                                  .map(
                                    (v) => DropdownMenuItem(
                                      value: v,
                                      child: Text(v),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) {
                                  setDialogState(
                                    () => _selectedProposedType = v,
                                  );
                                }
                              },
                            ),
                          ),
                          icon: Icons.category_outlined,
                        ),
                        const SizedBox(height: 18),
                        _buildSearchField(
                          'Loan A/C',
                          TextField(
                            controller: _loanAcController,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter loan account...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          icon: Icons.account_balance_outlined,
                        ),
                        const SizedBox(height: 18),
                        _buildSearchField(
                          'Case Number',
                          TextField(
                            controller: _caseNumberController,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter case number...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          icon: Icons.gavel_rounded,
                        ),
                        const SizedBox(height: 18),
                        _buildSearchField(
                          'Account Name',
                          TextField(
                            controller: _accountNameController,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter account name...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          icon: Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              _clearSearch();
                              setDialogState(() {});
                              setState(() {});
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              'Clear All',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [_primaryBlue, Color(0xFF1976D2)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: _primaryBlue.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {});
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search_rounded, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Search',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                const DepositFormTab(),
                DepositDataGridTab(
                  loanAc: _selectedIndex == 1 ? _loanAcController.text : '',
                  caseNumber: _selectedIndex == 1
                      ? _caseNumberController.text
                      : '',
                  accountName: _selectedIndex == 1
                      ? _accountNameController.text
                      : '',
                ),
                WithdrawPendingGridTab(
                  loanAc: _selectedIndex == 2 ? _loanAcController.text : '',
                  caseNumber: _selectedIndex == 2
                      ? _caseNumberController.text
                      : '',
                  accountName: _selectedIndex == 2
                      ? _accountNameController.text
                      : '',
                ),
                WithdrawnGridTab(
                  loanAc: _selectedIndex == 3 ? _loanAcController.text : '',
                  caseNumber: _selectedIndex == 3
                      ? _caseNumberController.text
                      : '',
                  accountName: _selectedIndex == 3
                      ? _accountNameController.text
                      : '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(
    String label,
    Widget child, {
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5C6BC0),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey.shade400),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: Align(alignment: Alignment.centerLeft, child: child),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Deposit & Withdrawal',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.3,
        ),
      ),
      actions: [
        if (_searchApplicable)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 22),
            onPressed: _showSearchDialog,
          ),
        const SizedBox(width: 4),
      ],
      backgroundColor: _primaryBlue,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            // ── ফাঁকা কমানো: padding একদম ছোট রাখা হয়েছে ──
            padding: const EdgeInsets.only(
              left: 6,
              right: 6,
              top: 5,
              bottom: 5,
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 4),
            tabs: List.generate(_tabs.length, (i) => _buildTab(_tabs[i], i)),
            indicator: const BoxDecoration(),
            dividerColor: Colors.transparent,
            onTap: (i) => setState(() {
              _selectedIndex = i;
              _clearSearch();
            }),
          ),
          Container(height: 1, color: Colors.grey.shade200),
        ],
      ),
    );
  }

  Widget _buildTab(_TabData tab, int index) {
    final isSelected = _selectedIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      // ── margin শূন্য, padding ছোট ──
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? _primaryBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? _primaryBlue : Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            tab.icon,
            size: 13,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
          const SizedBox(width: 5),
          Text(
            tab.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabData {
  final String label;
  final IconData icon;

  const _TabData({required this.label, required this.icon});
}
