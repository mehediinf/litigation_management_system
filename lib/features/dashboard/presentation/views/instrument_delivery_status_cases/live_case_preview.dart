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
        _stickySectionGroup(
          context,
          title: 'Case Basic Info',
          icon: Icons.fingerprint_rounded,
          details: [
            _DetailItem('SL No.', '1183'),
            _DetailItem('Territory', 'ELEPHANT ROAD'),
            _DetailItem('Requisition Type', 'ARA-2003'),
            _DetailItem('District', 'DHAKA-ELEPHANT ROAD'),
            _DetailItem('Proposed Type', 'Loan'),
            _DetailItem('Unit Office', 'ATI BAZAR'),
            _DetailItem('Loan A/C No.', '1111111111111111'),
            _DetailItem('More A/C No.', ''),
            _DetailItem('CIF', '11111111'),
            _DetailItem('Loan Sanction Date', '31-Dec-01'),
            _DetailItem('Branch SOL', 'AGRABAD BRANCH(1101)'),
            _DetailItem('Status', 'Suit Filing Added By Legal', isStatus: true),
            _DetailItem('Loan A/C Name', 'Bbl'),
            _DetailItem('Initiate By', 'Super Admin(7777777)'),
            _DetailItem('Borrower Name', 'Bbl'),
            _DetailItem('Initiate Date Time', '04-Feb-25 02:53 PM'),
            _DetailItem('Loan Segment', 'Corporate'),
            _DetailItem('Call Up File', ''),
            _DetailItem('Chq Expiry Date', '30-Aug-02'),
            _DetailItem('Last Payment Date', ''),
            _DetailItem('Current DPD', '33DPD'),
            _DetailItem('Legal Region', 'East'),
            _DetailItem('File Deliver By', 'Super Admin(7777777)'),
            _DetailItem('File Deliver Date Time', '04-Feb-25 02:54 PM'),
            _DetailItem('Legal Ack By', 'Super Admin(7777777)'),
            _DetailItem('Legal Ack Date Time', '04-Feb-25 02:55 PM'),
          ],
        ),
        ..._borrowerGuarantorSlivers(context),
        _stickySectionGroup(
          context,
          title: 'Suit File Info',
          icon: Icons.folder_shared_outlined,
          details: [
            _DetailItem('Case Name', ''),
            _DetailItem('Case Number', 'Artho-333/2025', emphasize: true),
            _DetailItem('Case Claim Amount', '500000000000.00'),
            _DetailItem('Previous Date', '10-Dec-25'),
            _DetailItem('Case Status Prev Date', 'Auction 33(1)'),
            _DetailItem('Activities Prev Date', 'Certificate'),
            _DetailItem('Next Date', ''),
            _DetailItem('Case Status Next Date', ''),
            _DetailItem('Remarks Next Date', ''),
            _DetailItem('Filling Plaintiff', 'Md. Abdul Bari(4444)'),
            _DetailItem('Filling Date', '10-Dec-25'),
            _DetailItem('Suit File Entry Date', '10-Dec-25'),
            _DetailItem('Case Deal Officer', 'Md. Abdul Bari(4444)'),
            _DetailItem('Previous Lawyer Name', ''),
            _DetailItem('Present Lawyer Name', 'A.K. FAZLUL HOQUE CHOWDHURY'),
            _DetailItem('Previous Court Name', ''),
            _DetailItem('Present Court Name', '1st Joint Dist & Session Judge Court'),
            _DetailItem('Suit File Entry By', 'Super Admin(7777777)'),
            _DetailItem('Arji Copy', 'Available'),
            _DetailItem('Judge Name', ''),
            _DetailItem('Judge Phone', ''),
          ],
        ),
        ..._expenseInfoSlivers(context),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }

  List<Widget> _borrowerGuarantorSlivers(BuildContext context) {
    final parties = [
      {
        'type': 'Guarantor',
        'name': 'Nur Nahar',
        'father': 'Father name',
        'present': 'Present Addresspresent Addresss Barguna',
        'permanent': 'Parmanent Addressparmanent Address Barguna',
        'business': 'Business Addressbusiness Address Barguna',
        'status': 'Available',
        'occ': 'DIRECTOR IN BANKS',
      },
      {
        'type': 'Borrower',
        'name': 'Nur Nahar',
        'father': 'Father name',
        'present': 'Present Addresspresent Addresss Barguna',
        'permanent': 'Parmanent Addressparmanent Address Barguna',
        'business': 'Business Addressbusiness Address Barguna',
        'status': 'Available',
        'occ': 'DIRECTOR IN BANKS',
      },
      {
        'type': 'Guarantor',
        'name': 'Nur Nahar',
        'father': 'Father name',
        'present': 'Present Addresspresent Addresss Barguna',
        'permanent': 'Parmanent Addressparmanent Address Barguna',
        'business': 'Business Addressbusiness Address Barguna',
        'status': 'Available',
        'occ': 'DIRECTOR IN BANKS',
      },
      {
        'type': 'Borrower',
        'name': 'Nur Nahar',
        'father': 'Father name',
        'present': 'Present Addresspresent Addresss Barguna',
        'permanent': 'Parmanent Addressparmanent Address Barguna',
        'business': 'Business Addressbusiness Address Barguna',
        'status': 'Absconded',
        'occ': 'DIRECTOR IN BANKS',
      },
    ];

    return _horizontalListSectionSlivers(
      context,
      title: 'Borrower/Guarantor/Company Director/Owner',
      icon: Icons.people_alt_outlined,
      itemCount: parties.length,
      itemBuilder: (context, index) {
        final p = parties[index];
        return _buildNestedCard(
          context,
          title: '${p['type']}: ${p['name']}',
          details: [
            _DetailItem('Father Name', '${p['father']}'),
            _DetailItem('Present Address', '${p['present']}'),
            _DetailItem('Permanent Address', '${p['permanent']}'),
            _DetailItem('Business Address', '${p['business']}'),
            _DetailItem('Status', '${p['status']}', isStatus: true),
            _DetailItem('Occupation', '${p['occ']}'),
          ],
        );
      },
    );
  }

  List<Widget> _expenseInfoSlivers(BuildContext context) {
    final expenses = [
      {
        'type': 'Lawyer',
        'vendor': 'A.K. FAZLUL HOQUE CHOWDHURY',
        'activity': 'Filing',
        'date': '10-Dec-25',
        'amount': '1000.00',
        'remarks': '',
      },
      {
        'type': 'Lawyer',
        'vendor': 'A.K. FAZLUL HOQUE CHOWDHURY',
        'activity': 'Drafting',
        'date': '10-Dec-25',
        'amount': '2000.00',
        'remarks': '',
      },
      {
        'type': 'Lawyer',
        'vendor': 'A.K. FAZLUL HOQUE CHOWDHURY',
        'activity': 'Drafting of Summons Notice',
        'date': '10-Dec-25',
        'amount': '500.00',
        'remarks': '',
      },
    ];

    return _horizontalListSectionSlivers(
      context,
      title: 'Expense Info',
      icon: Icons.payments_outlined,
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final e = expenses[index];
        return _buildNestedCard(
          context,
          title: '${e['type']} Expense',
          details: [
            _DetailItem('Vendor Name', '${e['vendor']}'),
            _DetailItem('Activities Name', '${e['activity']}'),
            _DetailItem('Activities Date', '${e['date']}'),
            _DetailItem('Amount', '${e['amount']}'),
            _DetailItem('Remarks', '${e['remarks']}'),
          ],
        );
      },
    );
  }

  List<Widget> _horizontalListSectionSlivers(
    BuildContext context, {
    required String title,
    required IconData icon,
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return [
      SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CasePreviewStickySectionDelegate(title: title, icon: icon),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
              child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                      child: Row(
                        children: [
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColor.primaryStrong.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$itemCount Items',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColor.primaryStrong,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < itemCount; i++) itemBuilder(context, i),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildNestedCard(
    BuildContext context, {
    required String title,
    required List<_DetailItem> details,
  }) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppColor.softBlue,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColor.textPrimary,
                  ),
            ),
          ),
          Divider(height: 1, color: AppColor.divider),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                for (var i = 0; i < details.length; i++) ...[
                  if (i > 0) const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 95,
                        child: Text(
                          details[i].label,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColor.textMuted,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      const Text(
                        ':',
                        style: TextStyle(fontSize: 11, color: AppColor.textMuted),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          details[i].value.isEmpty ? 'N/A' : details[i].value,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: details[i].isStatus ? AppColor.primaryStrong : AppColor.textPrimary,
                                fontWeight: details[i].isStatus ? FontWeight.w800 : FontWeight.w700,
                                fontSize: 11,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stickySectionGroup(
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
            child: _sectionDetailsCard(context, details),
          ),
        ),
      ],
    );
  }

  Widget _sectionDetailsCard(BuildContext context, List<_DetailItem> details) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            for (var i = 0; i < details.length; i++) ...[
              if (i > 0)
                Divider(
                  height: 20,
                  color: AppColor.divider.withValues(alpha: 0.5),
                ),
              _detailValueRow(context, details[i]),
            ],
          ],
        ),
      ),
    );
  }

  Widget _detailValueRow(BuildContext context, _DetailItem d) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            d.label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.textMuted,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.1,
                ),
          ),
        ),
        const Text(
          ':',
          style: TextStyle(
            color: AppColor.textMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: d.isStatus
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.softBlue,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColor.primary.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      d.value,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.primaryStrong,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                )
              : Text(
                  d.value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: d.emphasize ? AppColor.primaryStrong : AppColor.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
        ),
      ],
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
