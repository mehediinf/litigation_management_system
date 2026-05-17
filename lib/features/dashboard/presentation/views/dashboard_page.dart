// lib/features/dashboard/presentation/views/dashboard_page.dart

import 'package:flutter/material.dart';

import '../../../../app/theme/app_color.dart';
import '../../../../shared/widgets/state_renderer.dart';
import '../viewmodels/dashboard_view_model.dart';
import '../widgets/dashboard_chart_widgets.dart';
import '../widgets/dashboard_shell_widgets.dart';
import '../widgets/dashboard_support_widgets.dart';
import 'disposal_case_information/disposal_case_information_preview.dart';
import 'instrument_delivery_status_cases/instrument_delivery_status_cases_page.dart';
import 'live_case_information/live_case_information_preview.dart';
import 'warrant_of_arrest_process/warrant_of_arrest_process_preview.dart';
import 'case_update_information/case_update_information_preview.dart';
import 'appeal_bail_money_recovery/appeal_bail_money_recovery_preview.dart';
import 'professionals_bill/professionals_bill_preview.dart';
import 'litigation_management_handbook/litigation_management_handbook_preview.dart';
import 'memos_notices/memos_notices_page.dart';
import 'case_schedule_today/case_schedule_today_preview.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.viewModel});

  final DashboardViewModel viewModel;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      body: SafeArea(child: DashboardContent(viewModel: widget.viewModel)),
    );
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key, required this.viewModel});

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
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  const InstrumentDeliveryStatusCasesPage(
                                    sectionTitle: 'Instrument Delivery',
                                  ),
                            ),
                          );
                        },
                        child: ComparisonChart(
                          items: summary.deliveryStatus,
                          onRowTap: (metric) {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (_) =>
                                    InstrumentDeliveryStatusCasesPage(
                                      sectionTitle: metric.label,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 14),
                      DashboardPanelCard(
                        title: 'Live Case Information',
                        icon: Icons.query_stats_outlined,
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => const LiveCaseInformationPreview(
                                sectionTitle: 'Total',
                              ),
                            ),
                          );
                        },
                        child: VerticalBarChart(
                          metrics: summary.liveCaseInformation,
                          onBarTap: (metric) {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (_) => LiveCaseInformationPreview(
                                  sectionTitle: metric.label,
                                ),
                              ),
                            );
                          },
                          colors: const [
                            AppColor.dashboardMetricIndigo,
                            AppColor.dashboardMetricMint,
                            AppColor.dashboardMetricCoral,
                            AppColor.dashboardMetricTeal,
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      DashboardPanelCard(
                        title: 'Disposal Case Information',
                        icon: Icons.auto_delete_outlined,
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  const DisposalCaseInformationPreview(
                                    sectionTitle: 'Total',
                                  ),
                            ),
                          );
                        },
                        child: VerticalBarChart(
                          metrics: summary.disposalCaseInformation,
                          onBarTap: (metric) {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (_) => DisposalCaseInformationPreview(
                                  sectionTitle: metric.label,
                                ),
                              ),
                            );
                          },
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
                            onPrimaryTap: () {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute<void>(
                                  builder: (_) => WarrantOfArrestProcessPreview(
                                    sectionTitle:
                                        summary.warrantProcess.primaryLabel,
                                  ),
                                ),
                              );
                            },
                            onSecondaryTap: () {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute<void>(
                                  builder: (_) => WarrantOfArrestProcessPreview(
                                    sectionTitle:
                                        summary.warrantProcess.secondaryLabel,
                                  ),
                                ),
                              );
                            },
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
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  const CaseUpdateInformationPreview(
                                    sectionTitle: 'Total Pending',
                                  ),
                            ),
                          );
                        },
                        child: VerticalBarChart(
                          metrics: summary.caseUpdateInformation,
                          onBarTap: (metric) {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (_) => CaseUpdateInformationPreview(
                                  sectionTitle: metric.label,
                                ),
                              ),
                            );
                          },
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
                          onTap: () {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (_) =>
                                    const AppealBailMoneyRecoveryPreview(
                                      sectionTitle: 'Appeal & Bail Recovery',
                                    ),
                              ),
                            );
                          },
                          child: DonutBreakdown(
                            ratio: summary.appealAndBailMoney,
                            onPrimaryTap: () {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      AppealBailMoneyRecoveryPreview(
                                        sectionTitle: summary
                                            .appealAndBailMoney
                                            .primaryLabel,
                                      ),
                                ),
                              );
                            },
                            onSecondaryTap: () {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      AppealBailMoneyRecoveryPreview(
                                        sectionTitle: summary
                                            .appealAndBailMoney
                                            .secondaryLabel,
                                      ),
                                ),
                              );
                            },
                            primaryColor: AppColor.dashboardAccentBlueStrong,
                            secondaryColor: AppColor.dashboardAccentPink,
                          ),
                        ),
                        right: DashboardPanelCard(
                          title: 'Professionals Bill',
                          icon: Icons.receipt_long_outlined,
                          onTap: () {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (_) => const ProfessionalsBillPreview(
                                  sectionTitle: 'Professionals Bill',
                                ),
                              ),
                            );
                          },
                          child: VerticalBarChart(
                            metrics: summary.professionalBills,
                            onBarTap: (metric) {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute<void>(
                                  builder: (_) => ProfessionalsBillPreview(
                                    sectionTitle: metric.label,
                                  ),
                                ),
                              );
                            },
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
                            value:
                                '${summary.legalCostCr.toStringAsFixed(2)} Cr.',
                            icon: Icons.account_balance_wallet_outlined,
                            accent: AppColor.dashboardAccentRose,
                          ),
                          DashboardMetricCard(
                            label: 'Litigation Management Handbook',
                            icon: Icons.auto_stories_outlined,
                            accent: AppColor.dashboardAccentOrange,
                            showValue: false,
                            onTap: () {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      const LitigationManagementHandbookPreview(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      DashboardPanelCard(
                        title: 'Memos & Notices',
                        icon: Icons.mail_outline_rounded,
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => MemosNoticesPage(
                                items: summary.memosAndNotices,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColor.primary.withValues(alpha: 0.08),
                                AppColor.primary.withValues(alpha: 0.02),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColor.primary.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const Icon(
                                      Icons.notifications_none_rounded,
                                      color: AppColor.primary,
                                      size: 24,
                                    ),
                                    if (summary.memosAndNotices.isNotEmpty)
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: AppColor.dashboardMetricRed,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColor.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${summary.memosAndNotices.length} New Messages',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: AppColor.textPrimary,
                                          ),
                                    ),
                                    Text(
                                      'Click to view active memos and notices',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColor.textSecondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: AppColor.textMuted,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      DashboardPanelCard(
                        title: 'Case Schedule Today',
                        icon: Icons.calendar_month_outlined,
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => CaseScheduleTodayPreview(
                                selectedDate: summary.scheduleMonthLabel,
                              ),
                            ),
                          );
                        },
                        child: MiniCalendar(
                          highlightedDays: summary.highlightedScheduleDays,
                          onDayTap: (day) {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (_) => CaseScheduleTodayPreview(
                                  selectedDate:
                                      '$day ${summary.scheduleMonthLabel}',
                                ),
                              ),
                            );
                          },
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
