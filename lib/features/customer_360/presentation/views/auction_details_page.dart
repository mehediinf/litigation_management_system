//lib/features/customer_360/presentation/views/auction_details_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class AuctionDetailsPage extends StatefulWidget {
  const AuctionDetailsPage({super.key});

  @override
  State<AuctionDetailsPage> createState() => _AuctionDetailsPageState();
}

class _AuctionDetailsPageState extends State<AuctionDetailsPage> {
  static const List<_AuctionEntryBundle> _entries = [
    _AuctionEntryBundle(
      record: _AuctionRecord(
        loanAccount: '1111111111111111',
        paperVendor: 'Adv. Md. Jarif Hossain (Ortha Kari Enterprise)',
        paperName: 'Daily Sathmatha',
        paperDate: '01-Dec-21',
        auctionDate: '01-Dec-21',
        auctionTime: '01:01 AM',
        cif: '11111111',
        auctionAddress: 'asdf',
        paperRemarks: 'asdf',
        auctionVerifyBy: 'Super Admin (7777777)',
        auctionVerifyDate: '01-Dec-21 10:18 AM',
        lawyerName: 'MD RABIUL ALAM',
        legalNoticeServeDate: '2021-12-01',
        legalNoticeExpiryDate: '01-Dec-21',
        auctionRemarks: 'asdf',
        auctionCompleteRemarks: '',
        auctionAcknowledgeBy: 'Super Admin (7777777)',
        acknowledgeDateTime: '01-Dec-21 10:17 AM',
      ),
      mortgage: _MortgageInfo(
        scheduleName: 'asdf',
        scheduleDescription: 'asdf',
        deedNumber: '33',
        mortgageDate: '01-Dec-21',
        valuatorName: 'valuator-1',
        valuatorDate: '01-Dec-21',
        valuatorMv: '3.00',
        valuatorFsv: '3.00',
        reValuatorName: 'revaluator-1',
        reValuatorDate: '01-Dec-21',
        reValuatorMv: '3.00',
        reValuatorFsv: '3.00',
        govtMouzaRate: '3.00',
        totalLandArea: '3.00',
        boundedBy: '3',
      ),
      security: _SecurityInfo(
        deedNumber: '33',
        regDate: '01-Dec-21',
        deedType: 'Declaration Deed',
        district: 'BAGERHAT',
        thana: 'Bagerhat Sadar',
        subRegOffice: 'BAGERHAT SADAR',
        mouza: 'ABDUL RASULPUR',
        landArea: '3',
        plotNumber: '3',
        holdingNumber: '3',
        joteNo: '3',
        csKhatianNo: '3',
        saPsKhatianNo: '3',
        rsMrrKhatianNo: '3',
        bsDpRorKhatianNo: '3',
        cityJoripKhatianNo: '3',
        mutationKhatianNo: '3',
        csDagNo: '3',
        saDagNo: '3',
        rsDagNo: '3',
        bsDpDagNo: '3',
        cityJoripDagNo: '3',
      ),
    ),
    _AuctionEntryBundle(
      record: _AuctionRecord(
        loanAccount: '2222222222222222',
        paperVendor: 'Adv. Samiha Rahman',
        paperName: 'Daily Observer',
        paperDate: '07-Dec-21',
        auctionDate: '08-Dec-21',
        auctionTime: '11:15 AM',
        cif: '22222222',
        auctionAddress: 'Dhaka',
        paperRemarks: 'Published',
        auctionVerifyBy: 'Branch Manager',
        auctionVerifyDate: '07-Dec-21 05:40 PM',
        lawyerName: 'Barrister T. Rahman',
        legalNoticeServeDate: '2021-12-05',
        legalNoticeExpiryDate: '10-Dec-21',
        auctionRemarks: 'Awaiting final review',
        auctionCompleteRemarks: '',
        auctionAcknowledgeBy: 'Super Admin (7777777)',
        acknowledgeDateTime: '07-Dec-21 05:10 PM',
      ),
      mortgage: _MortgageInfo(
        scheduleName: 'Block-B',
        scheduleDescription: 'Commercial plot',
        deedNumber: '44',
        mortgageDate: '07-Dec-21',
        valuatorName: 'valuator-2',
        valuatorDate: '07-Dec-21',
        valuatorMv: '4.50',
        valuatorFsv: '4.10',
        reValuatorName: 'revaluator-2',
        reValuatorDate: '08-Dec-21',
        reValuatorMv: '4.40',
        reValuatorFsv: '4.00',
        govtMouzaRate: '4.00',
        totalLandArea: '5.50',
        boundedBy: 'North side road',
      ),
      security: _SecurityInfo(
        deedNumber: '44',
        regDate: '07-Dec-21',
        deedType: 'Mortgage Deed',
        district: 'DHAKA',
        thana: 'Gulshan',
        subRegOffice: 'DHAKA SADAR',
        mouza: 'BANANI',
        landArea: '5.5',
        plotNumber: '7',
        holdingNumber: '12A',
        joteNo: '11',
        csKhatianNo: '7',
        saPsKhatianNo: '8',
        rsMrrKhatianNo: '9',
        bsDpRorKhatianNo: '10',
        cityJoripKhatianNo: '11',
        mutationKhatianNo: '12',
        csDagNo: '13',
        saDagNo: '14',
        rsDagNo: '15',
        bsDpDagNo: '16',
        cityJoripDagNo: '17',
      ),
    ),
  ];

  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _primaryKeys = [];
  final List<List<GlobalKey>> _secondaryKeys = [];

  int _activePrimaryIndex = 0;
  int _activeSecondaryIndex = 0;
  bool _isContentCollapsed = false;

  static const List<_SectionMeta> _secondarySections = [
    _SectionMeta(title: 'Auction Record', icon: Icons.description_outlined),
    _SectionMeta(title: 'Mortgage Info', icon: Icons.account_balance_outlined),
    _SectionMeta(title: 'Security Info', icon: Icons.shield_outlined),
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _entries.length; i++) {
      _primaryKeys.add(GlobalKey());
      _secondaryKeys.add(List.generate(3, (_) => GlobalKey()));
    }
    _scrollController.addListener(_syncStickyHeaders);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncStickyHeaders());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_syncStickyHeaders)
      ..dispose();
    super.dispose();
  }

  void _syncStickyHeaders() {
    const threshold = 150.0;
    var nextPrimary = 0;
    var nextSecondary = 0;

    for (var i = 0; i < _primaryKeys.length; i++) {
      final context = _primaryKeys[i].currentContext;
      if (context == null) continue;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= threshold) {
        nextPrimary = i;
      }
    }

    for (var i = 0; i < _secondaryKeys[nextPrimary].length; i++) {
      final context = _secondaryKeys[nextPrimary][i].currentContext;
      if (context == null) continue;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= threshold) {
        nextSecondary = i;
      }
    }

    if (nextPrimary != _activePrimaryIndex ||
        nextSecondary != _activeSecondaryIndex) {
      setState(() {
        _activePrimaryIndex = nextPrimary;
        _activeSecondaryIndex = nextSecondary;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final activeSecondary = _secondarySections[_activeSecondaryIndex];

    return Customer360Scaffold(
      title: 'Auction Details',
      enableSearch: true,
      searchHintText: 'Search auction details',
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 2)),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(
              title: 'Auction Entry ${_activePrimaryIndex + 1}',
              icon: Icons.gavel_rounded,
              onTap: () =>
                  setState(() => _isContentCollapsed = !_isContentCollapsed),
              isCollapsed: _isContentCollapsed,
            ),
          ),
          if (!_isContentCollapsed) ...[
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyHeaderDelegate(
                title: activeSecondary.title,
                icon: activeSecondary.icon,
                cardColor: const Color(0xFFF7FAFF),
              ),
            ),
            ...List.generate(_entries.length, (index) {
              final entry = _entries[index];
              final isLast = index == _entries.length - 1;

              return SliverToBoxAdapter(
                child: Padding(
                  key: _primaryKeys[index],
                  padding:
                      EdgeInsets.fromLTRB(16, index == 0 ? 2 : 8, 16, isLast ? 20 : 10),
                  child: Column(
                    children: [
                      Container(
                        key: _secondaryKeys[index][0],
                        child: _AuctionRecordCard(record: entry.record),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        key: _secondaryKeys[index][1],
                        child: _MortgageCard(item: entry.mortgage),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        key: _secondaryKeys[index][2],
                        child: _SecurityCard(item: entry.security),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _SectionMeta {
  const _SectionMeta({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
}

class _AuctionEntryBundle {
  const _AuctionEntryBundle({
    required this.record,
    required this.mortgage,
    required this.security,
  });

  final _AuctionRecord record;
  final _MortgageInfo mortgage;
  final _SecurityInfo security;
}

class _AuctionRecordCard extends StatelessWidget {
  const _AuctionRecordCard({required this.record});

  final _AuctionRecord record;

  @override
  Widget build(BuildContext context) {
    final rows = [
      _DetailSpec(label: 'Loan A/C', value: record.loanAccount),
      _DetailSpec(label: 'CIF', value: record.cif),
      _DetailSpec(label: 'Paper Name', value: record.paperName),
      _DetailSpec(label: 'Paper Vendor', value: record.paperVendor),
      _DetailSpec(label: 'Paper Date', value: record.paperDate),
      _DetailSpec(label: 'Auction Date', value: record.auctionDate),
      _DetailSpec(label: 'Auction Time', value: record.auctionTime),
      _DetailSpec(label: 'Auction Address', value: record.auctionAddress),
      _DetailSpec(label: 'Paper Remarks', value: record.paperRemarks),
      _DetailSpec(label: 'Auction Verify By', value: record.auctionVerifyBy),
      _DetailSpec(label: 'Auction Verify Date', value: record.auctionVerifyDate),
      _DetailSpec(label: 'Lawyer', value: record.lawyerName),
      _DetailSpec(
        label: 'Legal Notice Serve Date',
        value: record.legalNoticeServeDate,
      ),
      _DetailSpec(
        label: 'Legal Notice Expiry Date',
        value: record.legalNoticeExpiryDate,
      ),
      _DetailSpec(label: 'Auction Remarks', value: record.auctionRemarks),
      _DetailSpec(
        label: 'Auction Complete Remarks',
        value: record.auctionCompleteRemarks,
      ),
      _DetailSpec(
        label: 'Auction Acknowledge By',
        value: record.auctionAcknowledgeBy,
      ),
      _DetailSpec(
        label: 'Acknowledge Date Time',
        value: record.acknowledgeDateTime,
      ),
    ];

    return _SectionCard(
      title: 'Auction Record',
      trailing: const _AuctionStatusChip(label: 'Verified'),
      rows: rows,
    );
  }
}

class _MortgageCard extends StatelessWidget {
  const _MortgageCard({required this.item});

  final _MortgageInfo item;

  @override
  Widget build(BuildContext context) {
    final rows = [
      _DetailSpec(label: 'Schedule Name', value: item.scheduleName),
      _DetailSpec(label: 'Schedule Description', value: item.scheduleDescription),
      _DetailSpec(label: 'Deed Number', value: item.deedNumber),
      _DetailSpec(label: 'Mortgage Date', value: item.mortgageDate),
      _DetailSpec(label: 'Valuator Name', value: item.valuatorName),
      _DetailSpec(label: 'Valuator Date', value: item.valuatorDate),
      _DetailSpec(label: 'Valuator MV', value: item.valuatorMv),
      _DetailSpec(label: 'Valuator FSV', value: item.valuatorFsv),
      _DetailSpec(label: 'Re-Valuator Name', value: item.reValuatorName),
      _DetailSpec(label: 'Re-Valuator Date', value: item.reValuatorDate),
      _DetailSpec(label: 'Re-Valuator MV', value: item.reValuatorMv),
      _DetailSpec(label: 'Re-Valuator FSV', value: item.reValuatorFsv),
      _DetailSpec(label: 'Gov\'t Mouza Rate', value: item.govtMouzaRate),
      _DetailSpec(label: 'Total Land Area', value: item.totalLandArea),
      _DetailSpec(label: 'Butted and bounded by', value: item.boundedBy),
    ];

    return _SectionCard(
      title: 'Mortgage Info',
      rows: rows,
    );
  }
}

class _SecurityCard extends StatelessWidget {
  const _SecurityCard({required this.item});

  final _SecurityInfo item;

  @override
  Widget build(BuildContext context) {
    final rows = [
      _DetailSpec(label: 'Deed Number', value: item.deedNumber),
      _DetailSpec(label: 'Reg. Date', value: item.regDate),
      _DetailSpec(label: 'Deed Type', value: item.deedType),
      _DetailSpec(label: 'District', value: item.district),
      _DetailSpec(label: 'Thana', value: item.thana),
      _DetailSpec(label: 'Sub Reg Office', value: item.subRegOffice),
      _DetailSpec(label: 'Mouza', value: item.mouza),
      _DetailSpec(label: 'Land Area', value: item.landArea),
      _DetailSpec(label: 'Plot Number', value: item.plotNumber),
      _DetailSpec(label: 'Holding Number', value: item.holdingNumber),
      _DetailSpec(label: 'Jote No.', value: item.joteNo),
      _DetailSpec(label: 'CS Khatian No.', value: item.csKhatianNo),
      _DetailSpec(label: 'SA/PS Khatian No.', value: item.saPsKhatianNo),
      _DetailSpec(label: 'RS/MRR Khatian No.', value: item.rsMrrKhatianNo),
      _DetailSpec(label: 'BS/DP/ROR Khatian No.', value: item.bsDpRorKhatianNo),
      _DetailSpec(
        label: 'City Jorip Khatian No.',
        value: item.cityJoripKhatianNo,
      ),
      _DetailSpec(label: 'Mutation Khatian No.', value: item.mutationKhatianNo),
      _DetailSpec(label: 'CS Dag No.', value: item.csDagNo),
      _DetailSpec(label: 'SA Dag No.', value: item.saDagNo),
      _DetailSpec(label: 'RS Dag No.', value: item.rsDagNo),
      _DetailSpec(label: 'BS/DP Dag No.', value: item.bsDpDagNo),
      _DetailSpec(label: 'City Jorip Dag No.', value: item.cityJoripDagNo),
    ];

    return _SectionCard(
      title: 'Security Info',
      rows: rows,
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.rows,
    this.trailing,
  });

  final String title;
  final List<_DetailSpec> rows;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Customer360Tokens.border, width: 1.2),
        boxShadow: Customer360Tokens.softShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Customer360Tokens.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 14),
            _LabelValueList(items: rows),
          ],
        ),
      ),
    );
  }
}

class _LabelValueList extends StatelessWidget {
  const _LabelValueList({required this.items});

  final List<_DetailSpec> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < items.length; index++) ...[
          _LabelValueRow(item: items[index]),
          if (index != items.length - 1)
            const Divider(
              height: 14,
              thickness: 1,
              color: Customer360Tokens.divider,
            ),
        ],
      ],
    );
  }
}

class _LabelValueRow extends StatelessWidget {
  const _LabelValueRow({required this.item});

  final _DetailSpec item;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 360;
    final labelWidth = width >= 700
        ? 168.0
        : width >= 520
            ? 132.0
            : 108.0;

    final labelStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Customer360Tokens.textSecondary,
          fontSize: width >= 700 ? 11.6 : 11.2,
          fontWeight: FontWeight.w600,
          height: 1.3,
        );

    final valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Customer360Tokens.textPrimary,
          fontSize: width >= 700 ? 13.6 : 13.2,
          fontWeight: FontWeight.w700,
          height: 1.35,
        );

    if (isSmall) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.label, style: labelStyle),
          const SizedBox(height: 3),
          Text(item.displayValue, style: valueStyle),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: labelWidth,
          child: Text(item.label, style: labelStyle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(item.displayValue, style: valueStyle),
        ),
      ],
    );
  }
}

class _AuctionStatusChip extends StatelessWidget {
  const _AuctionStatusChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Customer360Tokens.emphasisBg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Customer360Tokens.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Customer360Tokens.primaryStrong,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _DetailSpec {
  const _DetailSpec({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  String get displayValue => value.trim().isEmpty ? '-' : value;
}

class _AuctionRecord {
  const _AuctionRecord({
    required this.loanAccount,
    required this.paperVendor,
    required this.paperName,
    required this.paperDate,
    required this.auctionDate,
    required this.auctionTime,
    required this.cif,
    required this.auctionAddress,
    required this.paperRemarks,
    required this.auctionVerifyBy,
    required this.auctionVerifyDate,
    required this.lawyerName,
    required this.legalNoticeServeDate,
    required this.legalNoticeExpiryDate,
    required this.auctionRemarks,
    required this.auctionCompleteRemarks,
    required this.auctionAcknowledgeBy,
    required this.acknowledgeDateTime,
  });

  final String loanAccount;
  final String paperVendor;
  final String paperName;
  final String paperDate;
  final String auctionDate;
  final String auctionTime;
  final String cif;
  final String auctionAddress;
  final String paperRemarks;
  final String auctionVerifyBy;
  final String auctionVerifyDate;
  final String lawyerName;
  final String legalNoticeServeDate;
  final String legalNoticeExpiryDate;
  final String auctionRemarks;
  final String auctionCompleteRemarks;
  final String auctionAcknowledgeBy;
  final String acknowledgeDateTime;
}

class _MortgageInfo {
  const _MortgageInfo({
    required this.scheduleName,
    required this.scheduleDescription,
    required this.deedNumber,
    required this.mortgageDate,
    required this.valuatorName,
    required this.valuatorDate,
    required this.valuatorMv,
    required this.valuatorFsv,
    required this.reValuatorName,
    required this.reValuatorDate,
    required this.reValuatorMv,
    required this.reValuatorFsv,
    required this.govtMouzaRate,
    required this.totalLandArea,
    required this.boundedBy,
  });

  final String scheduleName;
  final String scheduleDescription;
  final String deedNumber;
  final String mortgageDate;
  final String valuatorName;
  final String valuatorDate;
  final String valuatorMv;
  final String valuatorFsv;
  final String reValuatorName;
  final String reValuatorDate;
  final String reValuatorMv;
  final String reValuatorFsv;
  final String govtMouzaRate;
  final String totalLandArea;
  final String boundedBy;
}

class _SecurityInfo {
  const _SecurityInfo({
    required this.deedNumber,
    required this.regDate,
    required this.deedType,
    required this.district,
    required this.thana,
    required this.subRegOffice,
    required this.mouza,
    required this.landArea,
    required this.plotNumber,
    required this.holdingNumber,
    required this.joteNo,
    required this.csKhatianNo,
    required this.saPsKhatianNo,
    required this.rsMrrKhatianNo,
    required this.bsDpRorKhatianNo,
    required this.cityJoripKhatianNo,
    required this.mutationKhatianNo,
    required this.csDagNo,
    required this.saDagNo,
    required this.rsDagNo,
    required this.bsDpDagNo,
    required this.cityJoripDagNo,
  });

  final String deedNumber;
  final String regDate;
  final String deedType;
  final String district;
  final String thana;
  final String subRegOffice;
  final String mouza;
  final String landArea;
  final String plotNumber;
  final String holdingNumber;
  final String joteNo;
  final String csKhatianNo;
  final String saPsKhatianNo;
  final String rsMrrKhatianNo;
  final String bsDpRorKhatianNo;
  final String cityJoripKhatianNo;
  final String mutationKhatianNo;
  final String csDagNo;
  final String saDagNo;
  final String rsDagNo;
  final String bsDpDagNo;
  final String cityJoripDagNo;
}
