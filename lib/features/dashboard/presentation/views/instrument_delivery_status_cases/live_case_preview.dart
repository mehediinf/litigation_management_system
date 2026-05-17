// lib/features/dashboard/presentation/views/instrument_delivery_status_cases/live_case_preview.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

import 'case_preview_sticky_section_delegate.dart';
import 'instrument_delivery_case_item.dart';
import 'instrument_delivery_cases_app_bar.dart';

class LiveCasePreview extends StatelessWidget {
  const LiveCasePreview({super.key, required this.item});

  final InstrumentDeliveryCaseItem item;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.drawerBg,
        appBar: buildInstrumentDeliveryCasesAppBar(
          context,
          title: 'Live Case Preview',
          bottom: TabBar(
            indicatorColor: AppColor.white,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            labelColor: AppColor.white,
            unselectedLabelColor: AppColor.white.withValues(alpha: 0.7),
            tabs: const [
              Tab(text: 'Case Details'),
              Tab(text: 'Case Life Cycle'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _CaseDetailsTab(item: item),
            _LifeCycleTab(),
          ],
        ),
      ),
    );
  }
}

class _CaseDetailsTab extends StatelessWidget {
  const _CaseDetailsTab({required this.item});
  final InstrumentDeliveryCaseItem item;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        _stickyGridGroup(
          context,
          title: 'Case Identifiers',
          icon: Icons.fingerprint_rounded,
          details: [
            _DetailItem('Case Number', item.caseNumber, emphasize: true),
            _DetailItem('SL No.', '${item.serialNumber}'),
            _DetailItem('Requisition Type', item.reqType),
            _DetailItem('Proposed Type', item.proposedType),
          ],
        ),
        _stickyGridGroup(
          context,
          title: 'Entity Information',
          icon: Icons.business_center_outlined,
          details: [
            _DetailItem('Account Name', item.accountName),
            _DetailItem('Borrower Name', item.borrowerName),
            _DetailItem('Account Number', item.accountNumber),
            _DetailItem('CIF', '11111111'),
          ],
        ),
        _stickyGridGroup(
          context,
          title: 'Geography',
          icon: Icons.map_outlined,
          details: [
            _DetailItem('Region', item.region),
            _DetailItem('Territory', item.territory),
            _DetailItem('District', item.district),
            _DetailItem('Legal Region', 'Central'),
          ],
        ),
        _stickyGridGroup(
          context,
          title: 'Current Status',
          icon: Icons.hourglass_empty_rounded,
          details: [
            _DetailItem('Case Status', 'Active Litigation', isStatus: true),
            _DetailItem('Disposal Status', 'Pending'),
            _DetailItem('Initiate Date', '16-Jan-22'),
            _DetailItem('Last Hearing', '12-Feb-24'),
          ],
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }

  Widget _stickyGridGroup(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<_DetailItem> details,
  }) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: CasePreviewStickySectionDelegate(title: title, icon: icon),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
            child: _gridDetailsCard(context, details),
          ),
        ),
      ],
    );
  }

  Widget _gridDetailsCard(BuildContext context, List<_DetailItem> details) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.panelBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.borderSoft),
        boxShadow: const [
          BoxShadow(
            color: AppColor.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: details.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
            mainAxisExtent: 52,
          ),
          itemBuilder: (context, index) {
            final d = details[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  d.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColor.textMuted,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                ),
                const SizedBox(height: 5),
                if (d.isStatus)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColor.softBlue,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColor.primary.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      d.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.primaryStrong,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  )
                else
                  Text(
                    d.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: d.emphasize
                              ? AppColor.primaryStrong
                              : AppColor.textPrimary,
                          fontWeight:
                              d.emphasize ? FontWeight.w800 : FontWeight.w700,
                        ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DetailItem {
  final String label;
  final String value;
  final bool isStatus;
  final bool emphasize;

  _DetailItem(this.label, this.value, {this.isStatus = false, this.emphasize = false});
}

class _LifeCycleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = [
      _LifeCycleEvent('Case Filed', 'Super Admin (7777777)', '01-Jan-22 10:00 AM', 'Case successfully filed in district court'),
      _LifeCycleEvent('Summon Served', 'Court Clerk', '15-Jan-22 02:30 PM', 'Summons served to the borrower'),
      _LifeCycleEvent('Appearance', 'Super Admin (7777777)', '20-Feb-22 11:15 AM', 'Borrower appeared in court'),
      _LifeCycleEvent('Written Statement', 'Legal Team', '10-Mar-22 03:45 PM', 'Borrower filed written statement'),
      _LifeCycleEvent('Issues Framed', 'Judge', '05-Apr-22 10:15 AM', 'Court framed issues for trial'),
      _LifeCycleEvent('Evidence Started', 'Advocate', '12-May-22 02:00 PM', 'Bank evidence phase started'),
    ];

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverMainAxisGroup(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CasePreviewStickySectionDelegate(
                title: 'Case life cycle',
                icon: Icons.timeline_outlined,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _TimelineItem(
                    event: events[index],
                    isLast: index == events.length - 1,
                  ),
                  childCount: events.length,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.event, required this.isLast});
  final _LifeCycleEvent event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.primaryStrong, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primary.withValues(alpha: 0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColor.primaryStrong, AppColor.borderSoft],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.status,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColor.textPrimary,
                        height: 1.2,
                      ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.panelBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColor.borderSoft),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColor.textSlate,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.person_pin_outlined, size: 14, color: AppColor.textMuted),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.user,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColor.textMuted,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.history_rounded, size: 14, color: AppColor.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            event.dateTime,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColor.textMuted,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LifeCycleEvent {
  final String status;
  final String user;
  final String dateTime;
  final String description;

  _LifeCycleEvent(this.status, this.user, this.dateTime, this.description);
}
