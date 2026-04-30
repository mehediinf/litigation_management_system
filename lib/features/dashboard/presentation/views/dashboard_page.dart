// lib/features/dashboard/presentation/views/dashboard_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/core/constants/app_strings.dart';
import 'package:litigation_management_system/features/dashboard/presentation/viewmodels/dashboard_view_model.dart';
import 'package:litigation_management_system/features/dashboard/presentation/widgets/dashboard_chart_widgets.dart';
import 'package:litigation_management_system/features/dashboard/presentation/widgets/dashboard_shell_widgets.dart';
import 'package:litigation_management_system/features/dashboard/presentation/widgets/dashboard_support_widgets.dart';
import 'package:litigation_management_system/shared/widgets/state_renderer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.viewModel,
  });

  final DashboardViewModel viewModel;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      body: SafeArea(
        child: DashboardContent(viewModel: widget.viewModel),
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({
    super.key,
    required this.viewModel,
  });

  final DashboardViewModel viewModel;

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, _) {
        final summary = widget.viewModel.summary;
        final width = MediaQuery.sizeOf(context).width;
        final horizontalPadding = width >= 1200
            ? 28.0
            : width >= 700
                ? 22.0
                : 16.0;
        final metricColumns = width >= 1200
            ? 4
            : width >= 800
                ? 3
                : 2;
        final metricAspectRatio = width >= 1200
            ? 1.34
            : width >= 800
                ? 1.18
                : width < 380
                    ? 0.82
                    : 0.9;

        return StateRenderer(
          isLoading: widget.viewModel.isLoading,
          errorMessage: widget.viewModel.errorMessage,
          onRetry: widget.viewModel.initialize,
          child: summary == null
              ? const SizedBox.shrink()
              : RefreshIndicator(
                  onRefresh: widget.viewModel.initialize,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      14,
                      horizontalPadding,
                      32,
                    ),
                    children: [
                      DashboardPanelCard(
                        title: 'Instrument Deli. & Case Pen.',
                        icon: Icons.local_shipping_outlined,
                        child: ComparisonChart(items: summary.deliveryStatus),
                      ),
                      const SizedBox(height: 14),
                      DashboardPanelCard(
                        title: 'Live Case Information',
                        icon: Icons.query_stats_outlined,
                          child: VerticalBarChart(
                          metrics: summary.liveCaseInformation,
                          colors: const [
                            AppColor.dashboardMetricIndigo,
                            AppColor.dashboardMetricMint,
                            AppColor.dashboardMetricCoral,
                            AppColor.dashboardMetricTeal,
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      DashboardDoubleSection(
                        left: DashboardPanelCard(
                          title: 'Warrant of Arrest Process',
                          icon: Icons.gavel_outlined,
                          child: DonutBreakdown(
                            ratio: summary.warrantProcess,
                            primaryColor: AppColor.dashboardAccentBlue,
                            secondaryColor: AppColor.borderSoft,
                          ),
                        ),
                        right: DashboardPanelCard(
                          title: 'HC & AD Matter',
                          icon: Icons.account_balance_outlined,
                          child: VerticalBarChart(
                            metrics: summary.hcAdMatter,
                            colors: const [
                              AppColor.dashboardMetricPurple,
                              AppColor.dashboardMetricSky,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      DashboardPanelCard(
                        title: 'Case Update Information',
                        icon: Icons.update_outlined,
                        child: VerticalBarChart(
                          metrics: summary.caseUpdateInformation,
                          colors: const [
                            AppColor.dashboardLegendSecondary,
                            AppColor.dashboardMetricRed,
                            AppColor.dashboardMetricLime,
                            AppColor.dashboardMetricLavender,
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      DashboardDoubleSection(
                        left: DashboardPanelCard(
                          title: 'Appeal & Bail Money Recovery',
                          icon: Icons.payments_outlined,
                          child: DonutBreakdown(
                            ratio: summary.appealAndBailMoney,
                            primaryColor: AppColor.dashboardAccentBlueStrong,
                            secondaryColor: AppColor.dashboardAccentPink,
                          ),
                        ),
                        right: DashboardPanelCard(
                          title: 'Professionals Bill',
                          icon: Icons.receipt_long_outlined,
                          child: VerticalBarChart(
                            metrics: summary.professionalBills,
                            colors: const [
                              AppColor.borderSoft,
                              AppColor.borderSoft,
                              AppColor.borderSoft,
                              AppColor.dashboardMetricCyan,
                              AppColor.dashboardMetricOlive,
                              AppColor.dashboardMetricViolet,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const DashboardSectionTitle(
                        title: 'Key Metrics',
                        subtitle: 'Litigation overview at a glance',
                        icon: Icons.grid_view_rounded,
                      ),
                      const SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: metricColumns,
                        childAspectRatio: metricAspectRatio,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children: [
                          DashboardMetricCard(
                            label: '1st Legal Notice',
                            value: '${summary.firstLegalNotice}',
                            icon: Icons.mark_email_read_outlined,
                            accent: AppColor.primaryStrong,
                          ),
                          DashboardMetricCard(
                            label: 'CMA Approved',
                            value: '${summary.cmaApproved}',
                            icon: Icons.check_circle_outline,
                            accent: AppColor.dashboardAccentGreen,
                          ),
                          DashboardMetricCard(
                            label: 'Auction Completed',
                            value: '${summary.auctionCompleted}',
                            icon: Icons.gavel_outlined,
                            accent: AppColor.dashboardAccentOrange,
                          ),
                          DashboardMetricCard(
                            label: 'Compliance & Regulatory',
                            value: '${summary.complianceRegulatory}',
                            icon: Icons.verified_user_outlined,
                            accent: AppColor.dashboardAccentPurple,
                          ),

                          DashboardMetricCard(
                            label: 'Legal Cost',
                            value: '${summary.legalCostCr.toStringAsFixed(2)} Cr.',
                            icon: Icons.account_balance_wallet_outlined,
                            accent: AppColor.dashboardAccentRose,
                          ),
                          DashboardMetricCard(
                            label: 'Litigation Management Handbook',
                            icon: Icons.auto_stories_outlined,
                            accent: AppColor.dashboardAccentOrange,
                            showValue: false,
                          ),

                        ],
                      ),
                      const SizedBox(height: 14),
                      DashboardPanelCard(
                        title: 'Memos & Notices',
                        icon: Icons.mail_outline_rounded,
                        child: Column(
                          children: summary.memosAndNotices
                              .map((memo) => MemoTile(item: memo))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      DashboardPanelCard(
                        title: 'Case Schedule Today',
                        icon: Icons.calendar_month_outlined,
                        child: MiniCalendar(
                          highlightedDays: summary.highlightedScheduleDays,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}




