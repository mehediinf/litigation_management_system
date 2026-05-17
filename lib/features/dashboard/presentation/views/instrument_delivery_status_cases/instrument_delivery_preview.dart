// lib/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_preview.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

import 'case_preview_sticky_section_delegate.dart';
import 'instrument_delivery_case_item.dart';
import 'instrument_delivery_cases_app_bar.dart';

class InstrumentDeliveryPreview extends StatelessWidget {
  const InstrumentDeliveryPreview({super.key, required this.item});

  final InstrumentDeliveryCaseItem item;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.drawerBg,
        appBar: buildInstrumentDeliveryCasesAppBar(
          context,
          title: 'Instrument Delivery Preview',
          bottom: TabBar(
            indicatorColor: AppColor.white,
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            labelColor: AppColor.white,
            unselectedLabelColor: AppColor.white.withValues(alpha: 0.7),
            tabs: const [
              Tab(text: 'Information'),
              Tab(text: 'Life Cycle'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _BasicInfoTab(item: item),
            _LifeCycleTab(),
          ],
        ),
      ),
    );
  }
}

class _BasicInfoTab extends StatelessWidget {
  const _BasicInfoTab({required this.item});

  final InstrumentDeliveryCaseItem item;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        _stickySectionGroup(
          context,
          title: 'Basic Identifiers',
          icon: Icons.assignment_outlined,
          details: [
            _DetailItem('SL No.', '${item.serialNumber}'),
            _DetailItem('Territory', item.territory),
            _DetailItem('District', item.district),
            _DetailItem('Requisition Type', item.reqType),
            _DetailItem('Proposed Type', item.proposedType),
            _DetailItem('Unit Office', 'B. BARIA'),
          ],
        ),
        _stickySectionGroup(
          context,
          title: 'Account & Borrower',
          icon: Icons.account_balance_outlined,
          details: [
            _DetailItem('Loan A/C No.', item.accountNumber),
            _DetailItem('More A/C No.', 'N/A'),
            _DetailItem('CIF', '11111111'),
            _DetailItem('Loan Sanction Date', '31-Dec-01'),
            _DetailItem('Branch SOL', 'SITAKUNDO BRANCH(1111)'),
            _DetailItem(
              'Status',
              'File Acknowledgement By Legal',
              isStatus: true,
            ),
            _DetailItem('Loan A/C Name', item.accountName),
            _DetailItem('Initiate By', 'Super Admin(7777777)'),
            _DetailItem('Customer Contact', '01727390673'),
            _DetailItem('Borrower Name', item.borrowerName),
            _DetailItem('Borrower Status', 'Abroad/ Migrated'),
            _DetailItem('Business Type', 'Personal'),
            _DetailItem('Business Status', 'Closed'),
            _DetailItem('Spouse Name', 'N/A'),
            _DetailItem('Mother Name', 'Asdf'),
            _DetailItem('Loan Segment', 'SME'),
          ],
        ),
        _stickySectionGroup(
          context,
          title: 'Case & Disposal Details',
          icon: Icons.folder_open_outlined,
          details: [
            _DetailItem('Prev CMA Appr Type', 'N/A'),
            _DetailItem('Prev CMA Appr Date', 'N/A'),
            _DetailItem('Previous Case Type', 'ARA-2003'),
            _DetailItem('Previous Case Status', 'Argument'),
            _DetailItem('Disposal Status', 'Settled'),
            _DetailItem('Disposal Remarks', 'N/A'),
            _DetailItem('Initiate Date Time', '16-Jan-22 10:16 AM'),
            _DetailItem('Region', 'Central'),
            _DetailItem('Legal Region', 'Central'),
            _DetailItem('Case File District', 'Jamalpur'),
            _DetailItem('Logic for ARA Case', 'Blind'),
            _DetailItem('Remarks', 'as'),
            _DetailItem('Current Address', 'N/A'),
            _DetailItem('Statement Balance', 'N/A'),
            _DetailItem('Statement Date', 'N/A'),
            _DetailItem('Hold Reason', 'N/A'),
          ],
        ),
        _stickySectionGroup(
          context,
          title: 'Auction Process',
          icon: Icons.gavel_rounded,
          details: [
            _DetailItem('Auction Status', 'N/A', isStatus: true),
            _DetailItem('Current Auction Sts', 'Completed'),
            _DetailItem('Previous Auction Sts', 'Complete'),
            _DetailItem('Auction Date', '01-Dec-21'),
            _DetailItem('Auction Time', '01:01 AM'),
            _DetailItem('Auction Address', 'asdf'),
            _DetailItem('Current DPD', '3DPD'),
            _DetailItem('Case Claim Amount', 'N/A'),
            _DetailItem('Auc Complete By', 'Super Admin (7777777)'),
            _DetailItem('Auc Complete Date', '17-Jan-22 10:21 AM'),
            _DetailItem('Auc Ack By', 'Super Admin (7777777)'),
            _DetailItem('Auc Ack Date Time', '01-Dec-21 10:17 AM'),
            _DetailItem('Auc Stc By', 'Super Admin (7777777)'),
            _DetailItem('Auc Stc Date Time', '01-Dec-21 10:18 AM'),
            _DetailItem('Auc Verify By', 'Super Admin (7777777)'),
            _DetailItem('Auc Verify Date Time', '01-Dec-21 10:18 AM'),
            _DetailItem('Auc STL By', 'Super Admin (7777777)'),
            _DetailItem('Auc STL Date Time', '01-Dec-21 10:18 AM'),
            _DetailItem('Auction Sign Memo', 'N/A'),
            _DetailItem('Auction Remarks', 'N/A'),
            _DetailItem('Auction Update By', 'N/A'),
            _DetailItem('Auction Update Date', 'N/A'),
          ],
        ),
        _stickySectionGroup(
          context,
          title: 'Legal & Notices',
          icon: Icons.policy_outlined,
          details: [
            _DetailItem('Lawyer', '12 BC LAW CHAMBERS'),
            _DetailItem('Selected Lawyer', '12 BC LAW CHAMBERS'),
            _DetailItem('Bill Type', 'Legal Notice'),
            _DetailItem('Interest Rate', '24.00 %'),
            _DetailItem('Security Status', 'Registered Mortgage(Secured)'),
            _DetailItem('Judgment Summary', 'N/A'),
            _DetailItem('Legal Response By', 'Super Admin (7777777)'),
            _DetailItem('Legal Resp Date Time', '01-Dec-21 10:19 AM'),
            _DetailItem('LN Sent Date', '17-Jan-22 12:00 AM'),
            _DetailItem('LN Valid Date', '17-Jan-22 12:00 AM'),
            _DetailItem('LN Serve Date', '01-Dec-21'),
            _DetailItem('LN Expiry Date', '01-Dec-21'),
            _DetailItem('Prev Case Fill Date', '01-Dec-21'),
            _DetailItem('LN Cost (Auction)', 'N/A'),
            _DetailItem('LN Scan Copy', 'N/A'),
            _DetailItem('Paper Vendor', 'Adv. Md. Jarif Hossain'),
            _DetailItem('Paper Name', 'Daily Sathmatha'),
            _DetailItem('Paper Date', '01-Dec-21'),
          ],
        ),
        _stickySectionGroup(
          context,
          title: 'Tracking & Payments',
          icon: Icons.history_rounded,
          details: [
            _DetailItem('File Deliver By', 'Super Admin(7777777)'),
            _DetailItem('File Deliver To', 'Md. Hassan Jahid (11040)'),
            _DetailItem('File Deliv Date Time', '05-Dec-21 10:09 AM'),
            _DetailItem('Verify By', 'Super Admin(7777777)'),
            _DetailItem('Verify Date Time', '19-Jan-22 05:19 PM'),
            _DetailItem('Call Up File', 'N/A'),
            _DetailItem('Call Up Date', '01-Dec-21'),
            _DetailItem('Chq Expiry Date', '30-Aug-02'),
            _DetailItem('Chq Status', 'Not Expire'),
            _DetailItem('Last Payment Date', '01-Dec-21'),
            _DetailItem('Last Payment Amount', '0.00'),
          ],
        ),
        ..._facilitySlivers(context),
        ..._borrowerGuarantorSlivers(context),
        ..._securitySlivers(context),
        ..._mortgageSlivers(context),
        ..._bidderSlivers(context),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
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
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ],
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
            delegate: CasePreviewStickySectionDelegate(
              title: title,
              icon: icon,
            ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.primaryStrong.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$itemCount Items',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
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
                          for (int i = 0; i < itemCount; i++)
                            itemBuilder(context, i),
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

  List<Widget> _facilitySlivers(BuildContext context) {
    final facilities = [
      {
        'type': 'TermLoan',
        'ac': '1111111111111111',
        'balance': '12.00',
        'rate': '3.00',
        'disbursed': '800000.00',
        'cl': 'BL',
      },
      {
        'type': 'TermLoan',
        'ac': '2222222222222222',
        'balance': '12.00',
        'rate': '3.00',
        'disbursed': '800000.00',
        'cl': 'DF',
      },
      {
        'type': 'Overdraft',
        'ac': '3333333333333333',
        'balance': '50.00',
        'rate': '9.00',
        'disbursed': '1000000.00',
        'cl': 'UC',
      },
    ];

    return _horizontalListSectionSlivers(
      context,
      title: 'Facility Info',
      icon: Icons.account_tree_outlined,
      itemCount: facilities.length,
      itemBuilder: (context, index) {
        final f = facilities[index];
        return _buildNestedCard(
          context,
          title: '${f['type']} - ${f['ac']}',
          details: [
            _DetailItem('Balance', '${f['balance']}'),
            _DetailItem('Int. Rate', '${f['rate']}%'),
            _DetailItem('Disbursed Amt', '${f['disbursed']}'),
            _DetailItem('CL (BBL)', '${f['cl']}', isStatus: true),
          ],
        );
      },
    );
  }

  List<Widget> _borrowerGuarantorSlivers(BuildContext context) {
    final parties = [
      {
        'type': 'Guarantor',
        'name': 'Nur Nahar',
        'age': '',
        'father': 'father name',
        'present_address': 'Present Addresspresent Addresss Barguna',
        'present_ps': '',
        'permanent_address': 'Parmanent Addressparmanent Address Barguna',
        'permanent_ps': '',
        'business_address': 'Business Addressbusiness Address Barguna',
        'status': 'Abroad/Migrated',
        'occ': 'DIRECTOR IN BANKS',
      },
      {
        'type': 'Borrower',
        'name': 'Nur Nahar',
        'age': '',
        'father': 'father name',
        'present_address': 'Asdfsadf',
        'present_ps': '',
        'permanent_address': '',
        'permanent_ps': '',
        'business_address': 'Business Addressbusiness Address Barguna',
        'status': 'Abroad/Migrated',
        'occ': 'DIRECTOR IN BANKS',
      },
      {
        'type': 'Guarantor',
        'name': 'Nur Nahar',
        'age': '',
        'father': 'Father name',
        'present_address': 'Present Addresspresent Addresss Barguna',
        'present_ps': '',
        'permanent_address': 'Parmanent Addressparmanent Address Barguna',
        'permanent_ps': '',
        'business_address': 'Business Addressbusiness Address Barguna',
        'status': 'Absconded',
        'occ': 'DIRECTOR IN BANKS',
      },
      {
        'type': 'Borrower',
        'name': 'Nur Nahar',
        'age': '',
        'father': 'Father name',
        'present_address': 'Present Addresspresent Addresss Barguna',
        'present_ps': '',
        'permanent_address': 'Parmanent Addressparmanent Address Barguna',
        'permanent_ps': '',
        'business_address': 'Business Addressbusiness Address Barguna',
        'status': 'Deceased',
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
            _DetailItem('Age', '${p['age']}'),
            _DetailItem('Father Name', '${p['father']}'),
            _DetailItem('Present Address', '${p['present_address']}'),
            _DetailItem('PS (Present)', '${p['present_ps']}'),
            _DetailItem('Permanent Addr', '${p['permanent_address']}'),
            _DetailItem('PS (Permanent)', '${p['permanent_ps']}'),
            _DetailItem('Business Addr', '${p['business_address']}'),
            _DetailItem('Status', '${p['status']}', isStatus: true),
            _DetailItem('Occupation', '${p['occ']}'),
          ],
        );
      },
    );
  }

  List<Widget> _securitySlivers(BuildContext context) {
    final securities = [
      {
        'deed': '33',
        'reg_date': '01-Dec-21',
        'type': 'Declaration Deed',
        'district': 'BAGERHAT',
        'mouza': 'ABDUL RASULPUR',
        'area': '3',
        'plot': '3',
        'cs': '3',
        'rs': '3',
      },
      {
        'deed': '45',
        'reg_date': '15-Jan-22',
        'type': 'Mortgage Deed',
        'district': 'DHAKA',
        'mouza': 'GULSHAN',
        'area': '5',
        'plot': '12',
        'cs': '102',
        'rs': '505',
      },
    ];

    return _horizontalListSectionSlivers(
      context,
      title: 'Security Info',
      icon: Icons.security_outlined,
      itemCount: securities.length,
      itemBuilder: (context, index) {
        final s = securities[index];
        return _buildNestedCard(
          context,
          title: 'Deed No: ${s['deed']}',
          details: [
            _DetailItem('Reg. Date', '${s['reg_date']}'),
            _DetailItem('Deed Type', '${s['type']}'),
            _DetailItem('District', '${s['district']}'),
            _DetailItem('Mouza', '${s['mouza']}'),
            _DetailItem('Land Area', '${s['area']}'),
            _DetailItem('Plot Number', '${s['plot']}'),
            _DetailItem('CS Khatian', '${s['cs']}'),
            _DetailItem('RS Dag No.', '${s['rs']}'),
          ],
        );
      },
    );
  }

  List<Widget> _mortgageSlivers(BuildContext context) {
    final mortgages = [
      {
        'schedule': 'Schedule A',
        'deed': '33',
        'date': '01-Dec-21',
        'valuator': 'valuator-1',
        'mv': '3.00',
        'fsv': '3.00',
        'revaluator': 'revaluator-1',
        'area': '3.00',
        'bounded': 'North: Road, South: Land',
      },
      {
        'schedule': 'Schedule B',
        'deed': '45',
        'date': '20-Jan-22',
        'valuator': 'valuator-2',
        'mv': '10.50',
        'fsv': '8.20',
        'revaluator': 'revaluator-2',
        'area': '1.50',
        'bounded': 'East: Plot 4, West: Plot 6',
      },
    ];

    return _horizontalListSectionSlivers(
      context,
      title: 'Mortgage Info',
      icon: Icons.home_work_outlined,
      itemCount: mortgages.length,
      itemBuilder: (context, index) {
        final m = mortgages[index];
        return _buildNestedCard(
          context,
          title: 'Schedule: ${m['schedule']}',
          details: [
            _DetailItem('Deed Number', '${m['deed']}'),
            _DetailItem('Mortgage Date', '${m['date']}'),
            _DetailItem('Valuator', '${m['valuator']}'),
            _DetailItem('Valuator MV', '${m['mv']}'),
            _DetailItem('Valuator FSV', '${m['fsv']}'),
            _DetailItem('Re-Valuator', '${m['revaluator']}'),
            _DetailItem('Land Area', '${m['area']}'),
            _DetailItem('Butted & Bounded', '${m['bounded']}'),
          ],
        );
      },
    );
  }

  List<Widget> _bidderSlivers(BuildContext context) {
    final bidders = [
      {
        'name': 'Hassan Ali',
        'bidder_details': 'Bidder Details',
        'rank': '1st',
        'selection': 'Selected',
        'po_no': 'PO-8822',
        'po_date': '01-Dec-21',
        'po_amt': '3.00',
        'bid_amt': '3.00',
        'plot_no': '3',
        'remarks': '3',
      },

      {
        'name': 'Rahim Uddin',
        'rank': '2nd',
        'selection': 'Waiting',
        'po_no': 'PO-9911',
        'po_date': '05-Dec-21',
        'bid_amt': '2.80',
        'po_amt': '2.80',
      },
    ];

    return _horizontalListSectionSlivers(
      context,
      title: 'Bidder Info',
      icon: Icons.how_to_reg_outlined,
      itemCount: bidders.length,
      itemBuilder: (context, index) {
        final b = bidders[index];
        return _buildNestedCard(
          context,
          title: 'Bidder: ${b['name']}',
          details: [
            _DetailItem('Bidder Details', '${b['bidder_details']}'),
            _DetailItem('Bidder Rank', '${b['rank']}'),
            _DetailItem('Selection', '${b['selection']}', isStatus: true),
            _DetailItem('Pay Order No', '${b['po_no']}'),
            _DetailItem('Pay Order Date', '${b['po_date']}'),
            _DetailItem('Pay Order Amt', '${b['po_amt']}'),
            _DetailItem('Bid Amount', '${b['bid_amt']}'),
            _DetailItem('Rs Plot No', '${b[' plot_no']}'),
            _DetailItem('Remarks', '${b['remarks']}'),
          ],
        );
      },
    );
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
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColor.textMuted,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      const Text(
                        ':',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColor.textMuted,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          details[i].value.isEmpty ? 'N/A' : details[i].value,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: details[i].isStatus
                                    ? AppColor.primaryStrong
                                    : AppColor.textPrimary,
                                fontWeight: details[i].isStatus
                                    ? FontWeight.w800
                                    : FontWeight.w700,
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
}

class _DetailItem {
  final String label;
  final String value;
  final bool isStatus;

  _DetailItem(this.label, this.value, {this.isStatus = false});
}

class _LifeCycleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = [
      _LifeCycleEvent(
        'Initiated',
        'Super Admin (7777777)',
        '01-Dec-21 10:16 AM',
        'Initiate CMA(1)',
      ),
      _LifeCycleEvent(
        'Send To Recommender',
        'Super Admin (7777777)',
        '01-Dec-21 10:16 AM',
        'Sentochecker CMA(1)',
      ),
      _LifeCycleEvent(
        'Recommended By RM',
        'Super Admin (7777777)',
        '01-Dec-21 10:16 AM',
        'Recommend CMA(1)',
      ),
      _LifeCycleEvent(
        'Acknowledged by HO (Auction)',
        'Super Admin (7777777)',
        '01-Dec-21 10:17 AM',
        'Acknowledgement CMA Auction(1)',
      ),
      _LifeCycleEvent(
        'Add Facility',
        'Super Admin (7777777)',
        '01-Dec-21 10:17 AM',
        'Add Facility Mortgage For CMA(1)',
      ),
      _LifeCycleEvent(
        'Auction Send To checker',
        'Super Admin (7777777)',
        '01-Dec-21 10:18 AM',
        'Send To checker Auction(1)',
      ),
      _LifeCycleEvent(
        'Auction Approved By Checker',
        'Super Admin (7777777)',
        '01-Dec-21 10:18 AM',
        'Approve Auction(1)',
      ),
      _LifeCycleEvent(
        'Auction Send To Legal',
        'Super Admin (7777777)',
        '01-Dec-21 10:18 AM',
        'Auction Send To Legal(1)',
      ),
      _LifeCycleEvent(
        'Acknowledge By Legal Checker',
        'Super Admin (7777777)',
        '01-Dec-21 10:18 AM',
        'Legal Acknowledgement CMA Auction(1)',
      ),
      _LifeCycleEvent(
        'Legal Response Send',
        'Super Admin (7777777)',
        '01-Dec-21 10:19 AM',
        'Legal Response CMA Auction(1)',
      ),
      _LifeCycleEvent(
        'Paper Info Updated',
        'Super Admin (7777777)',
        '01-Dec-21 10:21 AM',
        'Update Paper Info(1)',
      ),
      _LifeCycleEvent(
        'Bidder Details Updated',
        'Super Admin (7777777)',
        '01-Dec-21 10:21 AM',
        'Update Bidder Info(1)',
      ),
      _LifeCycleEvent(
        'Auction Completed',
        'Super Admin (7777777)',
        '01-Dec-21 10:21 AM',
        'Completed CMA Auction(1)',
      ),
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
                title: 'Life cycle',
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
                          const Icon(
                            Icons.person_pin_outlined,
                            size: 14,
                            color: AppColor.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.user,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
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
                          const Icon(
                            Icons.history_rounded,
                            size: 14,
                            color: AppColor.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            event.dateTime,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
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
