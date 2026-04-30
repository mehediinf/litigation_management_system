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
import '../../../head_office/view_pending_bill/presentation/views/view_pending_bill_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.dashboardViewModel,
  });

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
            DrawerMenuNode(title: 'Arising From Original Case'),
            DrawerMenuNode(title: 'Case Status Update'),
            DrawerMenuNode(title: 'Case Details Info'),
            DrawerMenuNode(title: 'Authorization Request'),
          ],
        ),
        DrawerMenuNode(
          title: 'Compliance & Regulatory Case',
          icon: Icons.verified_outlined,
          children: [
            DrawerMenuNode(title: 'Case File'),
            DrawerMenuNode(title: 'Arising From Original Case'),
            DrawerMenuNode(title: 'Case Status Update'),
            DrawerMenuNode(title: 'Case Details'),
          ],
        ),
        DrawerMenuNode(
          title: 'Warrant Of Arrest',
          icon: Icons.gavel_outlined,
          children: [
            DrawerMenuNode(title: 'Warrant Of Arrest Process'),
            DrawerMenuNode(title: 'Settled'),
            DrawerMenuNode(title: 'Pending Incentive'),
            DrawerMenuNode(title: 'Executed Incentive'),
          ],
        ),
        DrawerMenuNode(
          title: 'Appeal and Bail Money',
          icon: Icons.account_balance_outlined,
          children: [
            DrawerMenuNode(title: 'Deposit & Withdraw'),
            DrawerMenuNode(title: 'Hearing Bill'),
            DrawerMenuNode(title: 'Data Details'),
          ],
        ),
      ],
    ),
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
            DrawerMenuNode(title: 'Bill Expenses'),
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
      _isCustomer360SearchMode =
          index == 2 ? _isCustomer360SearchMode : false;
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
          MaterialPageRoute<void>(
            builder: (_) => const ViewPendingBillPage(),
          ),
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
      default:
        _showInfoSnackBar('$title module is ready for dynamic page wiring.');
    }
  }

  void _showInfoSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }

  Future<void> _showChangePasswordDialog() async {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();

    var obscureCurrent = true;
    var obscureNew = true;
    var obscureConfirm = true;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              backgroundColor: AppColor.transparent,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 520),
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
                              color: AppColor.sectionBgBlue,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.lock_reset_rounded,
                              color: AppColor.primary,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Change Password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: AppColor.textDeepBlue,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Update your LMS login password with a stronger credential.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColor.textSecondary,
                                        height: 1.45,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      _PasswordField(
                        controller: _currentPasswordController,
                        label: 'Current Password',
                        hintText: 'Enter current password',
                        obscureText: obscureCurrent,
                        onToggleVisibility: () {
                          setLocalState(() {
                            obscureCurrent = !obscureCurrent;
                          });
                        },
                      ),
                      const SizedBox(height: 14),
                      _PasswordField(
                        controller: _newPasswordController,
                        label: 'New Password',
                        hintText: 'Enter new password',
                        obscureText: obscureNew,
                        onToggleVisibility: () {
                          setLocalState(() {
                            obscureNew = !obscureNew;
                          });
                        },
                      ),
                      const SizedBox(height: 14),
                      _PasswordField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hintText: 'Re-enter new password',
                        obscureText: obscureConfirm,
                        onToggleVisibility: () {
                          setLocalState(() {
                            obscureConfirm = !obscureConfirm;
                          });
                        },
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(dialogContext).pop(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColor.dynamicAppBarIcon,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                side: const BorderSide(color: AppColor.outlineBorder),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () {
                                final current = _currentPasswordController.text.trim();
                                final next = _newPasswordController.text.trim();
                                final confirm = _confirmPasswordController.text.trim();

                                if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
                                  _showInfoSnackBar('Please fill in all password fields.');
                                  return;
                                }
                                if (next.length < 6) {
                                  _showInfoSnackBar(
                                    'New password should be at least 6 characters.',
                                  );
                                  return;
                                }
                                if (next != confirm) {
                                  _showInfoSnackBar('New password and confirm password do not match.');
                                  return;
                                }

                                Navigator.of(dialogContext).pop();
                                _showInfoSnackBar('Password changed successfully.');
                              },
                              icon: const Icon(Icons.check_rounded, size: 18),
                              label: const Text('Update'),
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
          },
        );
      },
    );
  }

  Future<void> _showSessionInfoSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColor.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _SettingsBottomSheet(
          title: 'Session Info',
          subtitle: 'Operational session details for the current LMS access.',
          icon: Icons.verified_user_outlined,
          child: const Column(
            children: [
              _InfoLine(label: 'User Role', value: 'Legal Operations'),
              _InfoLine(label: 'Access Zone', value: 'BARC Bank LMS'),
              _InfoLine(label: 'Login Time', value: '28-Apr-26 09:30 AM'),
              _InfoLine(label: 'Last Activity', value: '28-Apr-26 11:42 AM'),
              _InfoLine(label: 'Session Status', value: 'Active'),
              _InfoLine(label: 'Device', value: 'Android App'),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showHelpAndSupportSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColor.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _SettingsBottomSheet(
          title: 'Help & Support',
          subtitle: 'Useful contacts for operational issues, password support, and legal workflow assistance.',
          icon: Icons.support_agent_rounded,
          child: const Column(
            children: [
              _InfoLine(label: 'IT Help Desk', value: '+880 2 5501 2345'),
              _InfoLine(label: 'LMS Support Mail', value: 'lms.support@barcbank.local'),
              _InfoLine(label: 'Escalation Desk', value: 'Head Office Operations'),
              _InfoLine(label: 'Support Window', value: 'Sun - Thu, 9:00 AM - 6:00 PM'),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showAboutLmsDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.panelBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          titlePadding: const EdgeInsets.fromLTRB(22, 22, 22, 10),
          contentPadding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.drawerInfoBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'About LMS',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColor.textDeepBlue,
                      ),
                ),
              ),
            ],
          ),
          content: Text(
            'BARC Bank LMS supports legal operations, case workflow tracking, compliance follow-up, and operational visibility for branch and head office teams.\n\nVersion: 1.0.0+1',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textSecondary,
                  height: 1.55,
                ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.panelBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          titlePadding: const EdgeInsets.fromLTRB(22, 22, 22, 10),
          contentPadding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColor.errorSoftBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: AppColor.error,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColor.textDeepBlue,
                      ),
                ),
              ),
            ],
          ),
          content: Text(
            'Do you want to sign out from the BARC Bank LMS session on this device?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textSecondary,
                  height: 1.5,
                ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColor.dynamicAppBarIcon,
                side: const BorderSide(color: AppColor.outlineBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColor.error,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.logout_rounded, size: 18),
              label: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true && mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
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
              subtitle: 'Find cost data by year, bill month, region, status, and portfolio.',
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
              subtitle: 'Search customer view by customer type, district, region, segment, and portfolio.',
              fields: [
                _DialogFieldConfig(
                  label: 'Customer Type',
                  values: ['All Type', 'Individual', 'SME', 'Corporate'],
                  initialValue: 'All Type',
                ),
                _DialogFieldConfig(
                  label: 'District',
                  values: ['All District', 'Dhaka', 'Chattogram', 'Khulna', 'Rajshahi'],
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
            borderSide: const BorderSide(
              color: AppColor.primary,
              width: 1.1,
            ),
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
            borderSide: const BorderSide(
              color: AppColor.primary,
              width: 1.1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColor.primary
                        : AppColor.transparent,
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
                      Icon(
                        tab.icon,
                        color: AppColor.white,
                        size: 18,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        tab.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
  const _AppBarActionButton({
    required this.onPressed,
    required this.icon,
  });

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
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColor.textDeepBlue,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ),
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

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: AppColor.sectionBg,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: IconButton(
              onPressed: onToggleVisibility,
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
              ),
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
    );
  }
}

class _SettingsBottomSheet extends StatelessWidget {
  const _SettingsBottomSheet({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.panelBg,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColor.panelBorder),
          boxShadow: AppColor.overlayShadowList,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColor.sectionBgBlue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: AppColor.primary),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColor.textDeepBlue,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColor.textSecondary,
                              height: 1.5,
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
            const SizedBox(height: 18),
            child,
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColor.sectionBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.fieldBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColor.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
