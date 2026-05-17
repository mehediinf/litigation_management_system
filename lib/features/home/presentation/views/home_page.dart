//lib/features/home/presentation/views/home_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/router/app_router.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/core/constants/app_strings.dart';
import 'package:litigation_management_system/features/dashboard/presentation/viewmodels/dashboard_view_model.dart';
import 'package:litigation_management_system/features/dashboard/presentation/widgets/dashboard_shell_widgets.dart';
import 'package:litigation_management_system/features/dashboard/presentation/views/dashboard_page.dart';
import 'package:litigation_management_system/features/legal_cost/presentation/views/legal_cost_page.dart';
import 'package:litigation_management_system/shared/widgets/app_shell/app_shell_drawer.dart';
import 'package:litigation_management_system/shared/widgets/app_shell/dynamic_app_bar.dart';

import '../../../customer_360/presentation/views/customer_360_page.dart';

import '../../../head_office/supreme_court_matter/presentation/views/arising_from_original_case.dart';
import '../../../head_office/supreme_court_matter/presentation/views/billing.dart';
import '../../../head_office/supreme_court_matter/presentation/views/case_details.dart';
import '../../../head_office/supreme_court_matter/presentation/views/case_filling.dart';
import '../../../head_office/supreme_court_matter/presentation/views/case_status_update.dart';

import '../../../head_office/view_pending_bill/presentation/views/view_pending_bill_page.dart';

import '../../../legal_team/appeal_and_bail_money/presentation/views/appeal_data_details.dart';
import '../../../legal_team/appeal_and_bail_money/presentation/views/appeal_deposit_withdraw.dart';
import '../../../legal_team/appeal_and_bail_money/presentation/views/appeal_hearing_bill.dart';

import '../../../legal_team/case_management/presentation/views/case_manage_arising_from_original_case.dart';
import '../../../legal_team/case_management/presentation/views/case_manage_authorization_request.dart';
import '../../../legal_team/case_management/presentation/views/case_manage_case_details_info.dart';

import '../../../legal_team/case_management/presentation/views/case_manage_case_status_update.dart';
import '../../../legal_team/compliance_regulatory_case/presentation/views/compliance_arising_from_original_case.dart';
import '../../../legal_team/compliance_regulatory_case/presentation/views/compliance_case_details.dart';
import '../../../legal_team/compliance_regulatory_case/presentation/views/compliance_case_file.dart';

import '../../../legal_team/compliance_regulatory_case/presentation/views/compliance_case_status_update.dart';
import '../../../legal_team/warrant_of_arrest/presentation/views/warrant_executed_incentive.dart';
import '../../../legal_team/warrant_of_arrest/presentation/views/warrant_of_arrest_process.dart';
import '../../../legal_team/warrant_of_arrest/presentation/views/warrant_pending_incentive.dart';
import '../../../legal_team/warrant_of_arrest/presentation/views/warrant_settled.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.dashboardViewModel});

  final DashboardViewModel dashboardViewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isLegalCostSearchMode = false;
  bool _isCustomer360SearchMode = false;
  final TextEditingController _legalCostSearchController =
      TextEditingController();
  final TextEditingController _customer360SearchController =
      TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late final List<_HomeTabItem> _tabs = [
    _HomeTabItem(
      title: AppStrings.dashboardTitle,
      icon: Icons.dashboard_customize_outlined,
      page: DashboardContent(viewModel: widget.dashboardViewModel),
    ),
    _HomeTabItem(
      title: AppStrings.legalCostTitle,
      icon: Icons.account_balance_wallet_outlined,
      page: ValueListenableBuilder<TextEditingValue>(
        valueListenable: _legalCostSearchController,
        builder: (context, value, _) {
          return LegalCostPage(searchQuery: value.text);
        },
      ),
    ),
    _HomeTabItem(
      title: AppStrings.customer360Title,
      icon: Icons.people_alt_outlined,
      page: ValueListenableBuilder<TextEditingValue>(
        valueListenable: _customer360SearchController,
        builder: (context, value, _) {
          return Customer360Page(searchQuery: value.text);
        },
      ),
    ),
  ];

  late final List<DrawerMenuNode> _menuSections = [
    const DrawerMenuNode(
      title: 'Legal Team',
      icon: Icons.groups_2_outlined,
      children: [
        DrawerMenuNode(
          title: 'Case Management',
          icon: Icons.folder_copy_outlined,
          children: [
            DrawerMenuNode(title: 'Case Management Arising From Original Case'),
            DrawerMenuNode(title: 'Case Management Case Status Update'),
            DrawerMenuNode(title: 'Case Management Case Details Info'),
            DrawerMenuNode(title: 'Case Management Authorization Request'),
          ],
        ),
        DrawerMenuNode(
          title: 'Compliance & Regulatory Case',
          icon: Icons.verified_outlined,
          children: [
            DrawerMenuNode(title: 'Compliance Case File'),
            DrawerMenuNode(title: 'Compliance Arising From Original Case'),
            DrawerMenuNode(title: 'Compliance Case Status Update'),
            DrawerMenuNode(title: 'Compliance Case Details'),
          ],
        ),
        DrawerMenuNode(
          title: 'Warrant Of Arrest',
          icon: Icons.gavel_outlined,
          children: [
            DrawerMenuNode(title: 'Warrant Of Arrest Process'),
            DrawerMenuNode(title: 'Warrant Settled'),
            DrawerMenuNode(title: 'Warrant Pending Incentive'),
            DrawerMenuNode(title: 'Warrant Executed Incentive'),
          ],
        ),
        DrawerMenuNode(
          title: 'Appeal and Bail Money',
          icon: Icons.account_balance_outlined,
          children: [
            DrawerMenuNode(title: 'Appeal Deposit & Withdraw'),
            DrawerMenuNode(title: 'Appeal Hearing Bill'),
            DrawerMenuNode(title: 'Appeal Data Details'),
          ],
        ),
      ],
    ),

    // Head Office
    const DrawerMenuNode(
      title: 'Head Office',
      icon: Icons.business_outlined,
      children: [
        DrawerMenuNode(
          title: 'Case Details',
          icon: Icons.description_outlined,
          children: [
            DrawerMenuNode(title: 'Lower Court Case Details'),
            DrawerMenuNode(title: 'Legal Advisory Case Details'),
            DrawerMenuNode(title: 'HC/AD Case Details'),
          ],
        ),
        DrawerMenuNode(
          title: 'Supreme Court Matter',
          icon: Icons.account_balance_outlined,
          children: [
            DrawerMenuNode(title: 'Case Filling'),
            DrawerMenuNode(title: 'Arising From Original Case'),
            DrawerMenuNode(title: 'Case Status Update'),
            DrawerMenuNode(title: 'Billing'),
            DrawerMenuNode(title: 'Case Details'),
          ],
        ),
        DrawerMenuNode(
          title: 'View Pending Bill',
          icon: Icons.receipt_long_outlined,
        ),
      ],
    ),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
      _isLegalCostSearchMode = index == 1 ? _isLegalCostSearchMode : false;
      _isCustomer360SearchMode = index == 2 ? _isCustomer360SearchMode : false;
    });
  }

  @override
  void dispose() {
    _legalCostSearchController.dispose();
    _customer360SearchController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onDrawerMenuTap(String title) {
    switch (title) {
      case 'Settings':
        Navigator.of(context).pushNamed(AppRouter.settings);
        return;
      case 'View Pending Bill':
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const ViewPendingBillPage()),
        );
        return;
      case 'Lower Court Case Details':
        Navigator.of(context).pushNamed(AppRouter.lowerCourtCaseDetails);
        return;
      case 'Legal Advisory Case Details':
        Navigator.of(context).pushNamed(AppRouter.legalAdvisoryCaseDetails);
        return;
      case 'HC/AD Case Details':
        Navigator.of(context).pushNamed(AppRouter.hcAdCaseDetails);
        return;

      // Legal Team -> Case Management

      case 'Case Management Arising From Original Case':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const CaseManageArisingFromOriginalCasePage(),
          ),
        );
        return;
      case 'Case Management Case Status Update':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const CaseManagementCaseStatusUpdatePage(),
          ),
        );
        return;
      case 'Case Management Case Details Info':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const CaseManagementCaseDetailsInfoPage(),
          ),
        );
        return;
      case 'Case Management Authorization Request':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const CaseManagementAuthorizationRequestPage(),
          ),
        );
        return;

      // Legal Team -> Compliance & Regulatory Case
      case 'Compliance Case File':
        Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => const CaseFilePage()));
        return;

      case 'Compliance Arising From Original Case':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ComplianceArisingFromOriginalCasePage(),
          ),
        );
        return;

      case 'Compliance Case Status Update':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ComplianceCaseStatusUpdatePage(),
          ),
        );
        return;
      case 'Compliance Case Details':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ComplianceCaseDetailsPage(),
          ),
        );
        return;

      // Legal Team -> Warrant Of Arrest
      case 'Warrant Of Arrest Process':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const WarrantOfArrestProcessPage(),
          ),
        );
        return;
      case 'Warrant Settled':
        Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => const SettledPage()));
        return;
      case 'Warrant Pending Incentive':
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const PendingIncentivePage()),
        );
        return;
      case 'Warrant Executed Incentive':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ExecutedIncentivePage(),
          ),
        );
        return;

      // Legal Team -> Appeal and Bail Money
      case 'Appeal Deposit & Withdraw':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const AppealDepositWithdrawPage(),
          ),
        );
        return;
      case 'Appeal Hearing Bill':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const AppealHearingBillPage(),
          ),
        );
        return;
      case 'Appeal Data Details':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const AppealDataDetailsPage(),
          ),
        );
        return;

      // Head Office -> Supreme Court Matter
      case 'Case Filling':
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const CaseFillingPage()),
        );
        return;
      case 'Arising From Original Case':
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const ArisingFromOriginalCasePage(),
          ),
        );
        return;
      case 'Case Status Update':
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const CaseStatusUpdatePage()),
        );
        return;
      case 'Billing':
        Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => const BillingPage()));
        return;
      case 'Case Details':
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const CaseDetailsPage()),
        );
        return;

      default:
        _showInfoSnackBar('$title module is ready for dynamic page wiring.');
    }
  }

  void _showInfoSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(behavior: SnackBarBehavior.floating, content: Text(message)),
    );
  }

  Future<void> _showActiveSearchDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        switch (_currentIndex) {
          case 0:
            return const DashboardSearchDialog();
          case 1:
            return const _ModuleSearchDialog(
              title: 'Legal Cost Search',
              subtitle:
                  'Find cost data by year, bill month, region, status, and portfolio.',
              fields: [
                _DialogFieldConfig(
                  label: 'Year',
                  values: ['2024', '2025', '2026', '2027'],
                  initialValue: '2026',
                ),
                _DialogFieldConfig(
                  label: 'Bill Month',
                  values: ['January', 'February', 'March', 'April', 'May'],
                  initialValue: 'April',
                ),
                _DialogFieldConfig(
                  label: 'Region',
                  values: ['All Regions', 'North', 'South', 'Central', 'Metro'],
                  initialValue: 'All Regions',
                ),
                _DialogFieldConfig(
                  label: 'Status',
                  values: ['All Status', 'Pending', 'Approved', 'Paid'],
                  initialValue: 'All Status',
                ),
                _DialogFieldConfig(
                  label: 'Portfolio',
                  values: ['All Portfolio', 'Retail', 'SME', 'Corporate'],
                  initialValue: 'All Portfolio',
                ),
              ],
            );
          default:
            return const _ModuleSearchDialog(
              title: 'Customer 360 Search',
              subtitle:
                  'Search customer view by customer type, district, region, segment, and portfolio.',
              fields: [
                _DialogFieldConfig(
                  label: 'Customer Type',
                  values: ['All Type', 'Individual', 'SME', 'Corporate'],
                  initialValue: 'All Type',
                ),
                _DialogFieldConfig(
                  label: 'District',
                  values: [
                    'All District',
                    'Dhaka',
                    'Chattogram',
                    'Khulna',
                    'Rajshahi',
                  ],
                  initialValue: 'All District',
                ),
                _DialogFieldConfig(
                  label: 'Region',
                  values: ['All Region', 'North', 'South', 'Central', 'Metro'],
                  initialValue: 'All Region',
                ),
                _DialogFieldConfig(
                  label: 'Segment',
                  values: ['All Segment', 'Premium', 'Standard', 'Recovery'],
                  initialValue: 'All Segment',
                ),
                _DialogFieldConfig(
                  label: 'Portfolio',
                  values: ['All Portfolio', 'Retail', 'SME', 'Corporate'],
                  initialValue: 'All Portfolio',
                ),
              ],
            );
        }
      },
    );
  }

  void _handleSearchTap() {
    if (_currentIndex == 1) {
      setState(() {
        _isLegalCostSearchMode = true;
      });
      return;
    }

    if (_currentIndex == 2) {
      setState(() {
        _isCustomer360SearchMode = true;
      });
      return;
    }

    _showActiveSearchDialog();
  }

  void _closeLegalCostSearch() {
    setState(() {
      _isLegalCostSearchMode = false;
    });
    _legalCostSearchController.clear();
  }

  void _closeCustomer360Search() {
    setState(() {
      _isCustomer360SearchMode = false;
    });
    _customer360SearchController.clear();
  }

  Widget _buildLegalCostSearchTitle() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColor.panelBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.panelBorderStrong),
      ),
      child: TextField(
        controller: _legalCostSearchController,
        autofocus: true,
        cursorColor: AppColor.primary,
        decoration: InputDecoration(
          hintText: 'Search legal cost records',
          hintStyle: const TextStyle(
            color: AppColor.textBlueMuted,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColor.dynamicAppBarIcon,
            size: 20,
          ),
          suffixIcon: IconButton(
            onPressed: _closeLegalCostSearch,
            icon: const Icon(
              Icons.close_rounded,
              color: AppColor.dynamicAppBarIcon,
              size: 20,
            ),
            splashRadius: 18,
          ),
          isDense: true,
          filled: true,
          fillColor: AppColor.panelBg,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.primary, width: 1.1),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomer360SearchTitle() {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColor.panelBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.panelBorderStrong),
      ),
      child: TextField(
        controller: _customer360SearchController,
        autofocus: true,
        cursorColor: AppColor.primary,
        decoration: InputDecoration(
          hintText: 'Search A/C no, card no, or account name',
          hintStyle: const TextStyle(
            color: AppColor.textBlueMuted,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColor.dynamicAppBarIcon,
            size: 20,
          ),
          suffixIcon: IconButton(
            onPressed: _closeCustomer360Search,
            icon: const Icon(
              Icons.close_rounded,
              color: AppColor.dynamicAppBarIcon,
              size: 20,
            ),
            splashRadius: 18,
          ),
          isDense: true,
          filled: true,
          fillColor: AppColor.panelBg,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.primary, width: 1.1),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 45),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        decoration: BoxDecoration(
          color: AppColor.textPrimary,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: AppColor.textShadow,
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final tab = _tabs[index];
            final isSelected = _currentIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => _onDestinationSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.primary : AppColor.transparent,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: AppColor.primaryShadow,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(tab.icon, color: AppColor.white, size: 18),
                      const SizedBox(height: 3),
                      Text(
                        tab.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColor.white,
                              fontSize: 10.5,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeTab = _tabs[_currentIndex];

    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      appBar: DynamicAppBar(
        title: activeTab.title,
        titleContent: _currentIndex == 1 && _isLegalCostSearchMode
            ? _buildLegalCostSearchTitle()
            : _currentIndex == 2 && _isCustomer360SearchMode
            ? _buildCustomer360SearchTitle()
            : null,
        actions: [
          _AppBarActionButton(
            onPressed: _handleSearchTap,
            icon: Icons.search_rounded,
          ),
          const SizedBox(width: 8),
          _AppBarActionButton(
            onPressed: () {},
            icon: Icons.notifications_none_rounded,
          ),
          const SizedBox(width: 6),
        ],
      ),
      drawer: AppShellDrawer(
        items: const [
          DrawerDestinationItem(
            title: 'Settings',
            icon: Icons.settings_outlined,
            // subtitle: 'Security, support and session options',
          ),
        ],
        appVersion: '1.0.0+1',
        menuSections: _menuSections,
        onMenuTap: _onDrawerMenuTap,
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: _tabs.map((tab) => tab.page).toList(),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}

class _HomeTabItem {
  const _HomeTabItem({
    required this.title,
    required this.icon,
    required this.page,
  });

  final String title;
  final IconData icon;
  final Widget page;
}

class _AppBarActionButton extends StatelessWidget {
  const _AppBarActionButton({required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColor.sectionBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.actionBorder),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        iconSize: 22,
        splashRadius: 18,
      ),
    );
  }
}

class _DialogFieldConfig {
  const _DialogFieldConfig({
    required this.label,
    required this.values,
    required this.initialValue,
  });

  final String label;
  final List<String> values;
  final String initialValue;
}

class _ModuleSearchDialog extends StatefulWidget {
  const _ModuleSearchDialog({
    required this.title,
    required this.subtitle,
    required this.fields,
  });

  final String title;
  final String subtitle;
  final List<_DialogFieldConfig> fields;

  @override
  State<_ModuleSearchDialog> createState() => _ModuleSearchDialogState();
}

class _ModuleSearchDialogState extends State<_ModuleSearchDialog> {
  late final Map<String, String> _selectedValues = {
    for (final field in widget.fields) field.label: field.initialValue,
  };

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 760;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      backgroundColor: AppColor.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 720),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColor.panelBg,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColor.panelBorder),
          boxShadow: AppColor.overlayShadowList,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColor.cardGradientStart,
                          AppColor.cardGradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.search_rounded,
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColor.textDeepBlue,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColor.textSecondary,
                                height: 1.45,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: widget.fields.map((field) {
                  return _SearchDropdownField(
                    width: isWide ? 320 : double.infinity,
                    label: field.label,
                    value: _selectedValues[field.label],
                    items: field.values,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedValues[field.label] = value;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          for (final field in widget.fields) {
                            _selectedValues[field.label] = field.initialValue;
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColor.dynamicAppBarIcon,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColor.outlineBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.search_rounded, size: 18),
                      label: const Text('Apply Filters'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        foregroundColor: AppColor.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
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

class _SearchDropdownField extends StatelessWidget {
  const _SearchDropdownField({
    required this.width,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final double width;
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColor.textSteel,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            items: items
                .map(
                  (item) =>
                      DropdownMenuItem<String>(value: item, child: Text(item)),
                )
                .toList(),
            onChanged: onChanged,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.sectionBg,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColor.fieldBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColor.fieldBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColor.primary,
                  width: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
