//lib/features/customer_360/presentation/views/cma_details_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class CMADetailsPage extends StatefulWidget {
  const CMADetailsPage({super.key});

  @override
  State<CMADetailsPage> createState() => _CMADetailsPageState();
}

class _CMADetailsPageState extends State<CMADetailsPage> {
  static const List<_CmaEntryBundle> _entries = [
    _CmaEntryBundle(
      record: _CmaRecord(
        slNo: '1001',
        territory: 'ELEPHANT ROAD',
        requisitionType: 'ARA-2003',
        district: 'DHAKA-ELEPHANT ROAD',
        proposedType: 'Loan',
        unitOffice: 'B. BARIA',
        loanAccountNo: '1111111111111111',
        moreAccountNo: '',
        cif: '11111111',
        loanSanctionDate: '31-Dec-01',
        branchSol: 'SITAKUNDO BRANCH(1111)',
        status: 'File Acknowledgement By Legal',
        loanAccountName: 'Bbl',
        initiateBy: 'Super Admin(7777777)',
        previousCmaApprovalType: '',
        previousCmaApprovalDate: '',
        previousCaseStatus: 'Argument',
        previousCaseType: 'ARA-2003',
        disposalStatus: 'Disposal',
        customerContact: '01727390673',
        borrowerName: 'Bbl',
        initiateDateTime: '16-Jan-22 10:16 AM',
        businessType: 'Personal',
        stcBy: 'Super Admin(7777777)',
        spouseName: 'N/A',
        stcDateTime: '01-Dec-21 10:16 AM',
        motherName: 'Asdf',
        recommendedBy: 'Super Admin(7777777)',
        loanSegment: 'SME',
        recommendDateTime: '2021-12-01 10:16:55',
        currentUpdatedAddress: '',
        hoAcknowledgeBy: 'Super Admin(7777777)',
        region: 'Central',
        hoAcknowledgeDateTime: '01-Dec-21 10:59 AM',
        callUpDate: '01-Dec-21',
        sendToHolmBy: 'Super Admin(7777777)',
        callUpFile: '',
        sendToHolmDateTime: '02-Dec-21 05:19 PM',
        chqExpiryDate: '30-Aug-02',
        verifyBy: 'Super Admin(7777777)',
        lastPaymentDate: '01-Dec-21',
        verifyDateTime: '19-Jan-22 05:19 PM',
        lastPaymentAmount: '0.00',
        auctionCompleteBy: 'Super Admin (7777777)',
        caseFileDistrict: 'Jamalpur',
        caseClaimAmount: '',
        remarks: 'as',
        auctionCompleteDate: '17-Jan-22 10:21 AM',
        previousAuctionStatus: 'Auction Successfully Completed',
        holdReason: '',
        currentAuctionStatus: 'Completed',
        previousCaseFilingDate: '01-Dec-21',
        currentDpd: '3DPD',
        legalRegion: 'Central',
        disposalRemarks: '',
        judgmentSummary: '',
        businessStatus: 'Closed',
        securityStatus: 'Registered Mortgage(Secured)',
        borrowerStatus: 'Abroad/ Migrated',
        interestRate: '24.00',
        logicForAraCase: 'Blind',
        chqStatus: 'Not Expire',
        aucAckBy: 'Super Admin (7777777)',
        aucAckDateTime: '01-Dec-21 10:17 AM',
        aucStcBy: 'Super Admin (7777777)',
        aucStcDateTime: '01-Dec-21 10:18 AM',
        aucVerifyBy: 'Super Admin (7777777)',
        aucVerifyDateTime: '01-Dec-21 10:18 AM',
        aucStlBy: 'Super Admin (7777777)',
        aucStlDateTime: '01-Dec-21 10:18 AM',
        legalResponseBy: 'Super Admin (7777777)',
        legalResponseDateTime: '01-Dec-21 10:19 AM',
        lawyer: 'MD RABIUL ALAM',
        lnScanCopy: '',
        lnServeDate: '01-Dec-21',
        lnExpiryDate: '01-Dec-21',
        paperVendor: 'Adv. Md. Jarif Hossain(Ortha Kari Enterprise)',
        paperName: 'Daily Sathmatha',
        paperDate: '01-Dec-21',
        auctionDate: '01-Dec-21',
        auctionTime: '01:01 AM',
        auctionAddress: 'asdf',
        auctionCompleteDateTime: '17-Jan-22 10:21 AM',
        auctionSignMemo: '',
        auctionCompleteRemarks: '',
        sendToHoopsBy: 'Super Admin(7777777)',
        sendToHoopsDateTime: '02-Dec-21 05:19 PM',
        fileDeliverBy: 'Super Admin(7777777)',
        fileDeliverDateTime: '05-Dec-21 10:09 AM',
        legalAckBy: 'Super Admin(7777777)',
        legalAckDateTime: '18-Oct-22 05:57 PM',
      ),
      borrowers: [
        _BorrowerInfo(
          type: 'Guarantor',
          name: 'Nur Nahar',
          fatherName: 'father name',
          presentAddress: 'Present Addresspresent Addresss Barguna',
          permanentAddress: 'Parmanent Addressparmanent Address Barguna',
          businessAddress: 'Business Addressbusiness Address Barguna',
          status: 'Abroad/Migrated',
          occupation: 'DIRECTOR IN BANKS',
        ),
        _BorrowerInfo(
          type: 'Borrower',
          name: 'Nur Nahar',
          fatherName: 'father name',
          presentAddress: 'Asdfsadf',
          permanentAddress: '',
          businessAddress: 'Business Addressbusiness Address Barguna',
          status: 'Abroad/Migrated',
          occupation: 'DIRECTOR IN BANKS',
        ),
        _BorrowerInfo(
          type: 'Guarantor',
          name: 'Nur Nahar',
          fatherName: 'Father name',
          presentAddress: 'Present Addresspresent Addresss Barguna',
          permanentAddress: 'Parmanent Addressparmanent Address Barguna',
          businessAddress: 'Business Addressbusiness Address Barguna',
          status: 'Absconded',
          occupation: 'DIRECTOR IN BANKS',
        ),
        _BorrowerInfo(
          type: 'Borrower',
          name: 'Nur Nahar',
          fatherName: 'Father name',
          presentAddress: 'Present Addresspresent Addresss Barguna',
          permanentAddress: 'Parmanent Addressparmanent Address Barguna',
          businessAddress: 'Business Addressbusiness Address Barguna',
          status: 'Deceased',
          occupation: 'DIRECTOR IN BANKS',
        ),
      ],
      facilities: [
        _FacilityInfo(
          facilityType: 'TermLoan',
          accountNumber: '1111111111111111',
          accountName: 'Bbl',
          scheduleDescription: 'APURBO LOAN - EMI - SME',
          interestRate: '3.00',
          disbursementDate: '28-Sep-18',
          disbursedAmount: '800000.00',
          expireDate: '31-Dec-01',
          tenure: '2',
          payable: '0.00',
          repayment: '0.00',
          outstandingBalance: '12.00',
          outstandingBalanceDate: '28-Sep-14',
          overdueBalance: '12.00',
          overdueBalanceDate: '',
          callUpDate: '',
          writeOffDate: '',
          writeOffAmount: '0.00',
          recoveryAfterWriteOff: '0.00',
          clBb: 'BL',
          clBbl: 'BL',
        ),
        _FacilityInfo(
          facilityType: 'TermLoan',
          accountNumber: '1111111111111111',
          accountName: 'Bbl',
          scheduleDescription: 'APURBO LOAN - EMI - SME',
          interestRate: '3.00',
          disbursementDate: '28-Sep-18',
          disbursedAmount: '800000.00',
          expireDate: '31-Dec-01',
          tenure: '2',
          payable: '0.00',
          repayment: '0.00',
          outstandingBalance: '12.00',
          outstandingBalanceDate: '28-Sep-14',
          overdueBalance: '12.00',
          overdueBalanceDate: '',
          callUpDate: '',
          writeOffDate: '',
          writeOffAmount: '0.00',
          recoveryAfterWriteOff: '0.00',
          clBb: 'DF',
          clBbl: 'DF',
        ),
        _FacilityInfo(
          facilityType: 'TermLoan',
          accountNumber: '1111111111111111',
          accountName: 'Bbl',
          scheduleDescription: 'APURBO LOAN - EMI - SME',
          interestRate: '3.00',
          disbursementDate: '28-Sep-18',
          disbursedAmount: '800000.00',
          expireDate: '31-Dec-01',
          tenure: '2',
          payable: '0.00',
          repayment: '0.00',
          outstandingBalance: '12.00',
          outstandingBalanceDate: '28-Sep-14',
          overdueBalance: '12.00',
          overdueBalanceDate: '',
          callUpDate: '',
          writeOffDate: '',
          writeOffAmount: '0.00',
          recoveryAfterWriteOff: '0.00',
          clBb: 'BL',
          clBbl: 'BL',
        ),
        _FacilityInfo(
          facilityType: 'TermLoan',
          accountNumber: '1111111111111111',
          accountName: 'Bbl',
          scheduleDescription: 'APURBO LOAN - EMI - SME',
          interestRate: '3.00',
          disbursementDate: '28-Sep-18',
          disbursedAmount: '800000.00',
          expireDate: '31-Dec-01',
          tenure: '2',
          payable: '0.00',
          repayment: '0.00',
          outstandingBalance: '12.00',
          outstandingBalanceDate: '28-Sep-14',
          overdueBalance: '12.00',
          overdueBalanceDate: '',
          callUpDate: '',
          writeOffDate: '',
          writeOffAmount: '0.00',
          recoveryAfterWriteOff: '0.00',
          clBb: 'DF',
          clBbl: 'BL',
        ),
      ],
      securedDocuments: [
        _SecuredDocumentFile(
          title: 'Copy of Call-up letter',
          fileLabel: 'View file',
        ),
        _SecuredDocumentFile(
          title: 'Copy of Deed of Mortgage',
          fileLabel: 'View file',
        ),
        _SecuredDocumentFile(
          title: 'Copy of Power of Attorney',
          fileLabel: 'View file',
        ),
        _SecuredDocumentFile(
          title: 'Copy of Sanction Letter',
          fileLabel: 'View file',
        ),
        _SecuredDocumentFile(
          title: 'Copy of served Legal notice under sec-12(3) & 12(5)',
          fileLabel: 'View file',
        ),
        _SecuredDocumentFile(
          title: 'Copy of Valuation Report',
          fileLabel: 'View file',
        ),
      ],
    ),
  ];

  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _primaryKeys = [];
  final List<List<GlobalKey>> _secondaryKeys = [];

  int _activePrimaryIndex = 0;
  int _activeSecondaryIndex = 0;
  bool _isContentCollapsed = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _entries.length; i++) {
      _primaryKeys.add(GlobalKey());
      _secondaryKeys.add(
        List.generate(_sectionsForEntry(_entries[i]).length, (_) => GlobalKey()),
      );
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
      if (box.localToGlobal(Offset.zero).dy <= threshold) {
        nextPrimary = i;
      }
    }

    final activeKeys = _secondaryKeys[nextPrimary];
    for (var i = 0; i < activeKeys.length; i++) {
      final context = activeKeys[i].currentContext;
      if (context == null) continue;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= threshold) {
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

  List<_SectionMeta> _sectionsForEntry(_CmaEntryBundle entry) {
    final sections = <_SectionMeta>[
      const _SectionMeta(title: 'CMA Record', icon: Icons.description_outlined),
      const _SectionMeta(
        title: 'Borrower / Guarantor / Director',
        icon: Icons.people_alt_outlined,
      ),
      const _SectionMeta(
        title: 'Facility Info',
        icon: Icons.account_balance_wallet_outlined,
      ),
    ];

    if (entry.securedDocuments.isNotEmpty) {
      sections.add(
        const _SectionMeta(
          title: 'Secured Document Files',
          icon: Icons.folder_copy_outlined,
        ),
      );
    }

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final activeEntry = _entries[_activePrimaryIndex];
    final activeSections = _sectionsForEntry(activeEntry);
    final safeSecondaryIndex = _activeSecondaryIndex.clamp(
      0,
      activeSections.length - 1,
    );
    final activeSecondary = activeSections[safeSecondaryIndex];

    return Customer360Scaffold(
      title: 'CMA Details',
      enableSearch: true,
      searchHintText: 'Search CMA details',
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 2)),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(
              title: 'CMA Entry ${_activePrimaryIndex + 1}',
              icon: Icons.assessment_outlined,
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
                cardColor: Customer360Tokens.softBlue,
              ),
            ),
            ...List.generate(_entries.length, (index) {
              final entry = _entries[index];
              final isLast = index == _entries.length - 1;

              return SliverToBoxAdapter(
                child: Padding(
                  key: _primaryKeys[index],
                  padding: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 2 : 8,
                    16,
                    isLast ? 20 : 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        key: _secondaryKeys[index][0],
                        child: _CmaRecordCard(record: entry.record),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        key: _secondaryKeys[index][1],
                        child: _BorrowerSectionCard(items: entry.borrowers),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        key: _secondaryKeys[index][2],
                        child: _FacilitySectionCard(items: entry.facilities),
                      ),
                      if (entry.securedDocuments.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Container(
                          key: _secondaryKeys[index][3],
                          child: _SecuredDocumentSectionCard(
                            items: entry.securedDocuments,
                          ),
                        ),
                      ],
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

class _CmaEntryBundle {
  const _CmaEntryBundle({
    required this.record,
    required this.borrowers,
    required this.facilities,
    required this.securedDocuments,
  });

  final _CmaRecord record;
  final List<_BorrowerInfo> borrowers;
  final List<_FacilityInfo> facilities;
  final List<_SecuredDocumentFile> securedDocuments;
}

class _CmaRecordCard extends StatelessWidget {
  const _CmaRecordCard({required this.record});

  final _CmaRecord record;

  @override
  Widget build(BuildContext context) {
    final primaryRows = [
      _DetailSpec(label: 'SL No.', value: record.slNo),
      _DetailSpec(label: 'Territory', value: record.territory),
      _DetailSpec(label: 'Requisition Type', value: record.requisitionType),
      _DetailSpec(label: 'District', value: record.district),
      _DetailSpec(label: 'Proposed Type', value: record.proposedType),
      _DetailSpec(label: 'Unit Office', value: record.unitOffice),
      _DetailSpec(label: 'Loan A/C No.', value: record.loanAccountNo),
      _DetailSpec(label: 'More A/C No.', value: record.moreAccountNo),
      _DetailSpec(label: 'CIF', value: record.cif),
      _DetailSpec(label: 'Loan Sanction Date', value: record.loanSanctionDate),
      _DetailSpec(label: 'Branch SOL', value: record.branchSol),
      _DetailSpec(label: 'Status', value: record.status),
      _DetailSpec(label: 'Loan A/C Name', value: record.loanAccountName),
      _DetailSpec(label: 'Borrower Name', value: record.borrowerName),
      _DetailSpec(label: 'Customer Contact', value: record.customerContact),
      _DetailSpec(label: 'Business Type', value: record.businessType),
      _DetailSpec(label: 'Loan Segment', value: record.loanSegment),
      _DetailSpec(label: 'Region', value: record.region),
      _DetailSpec(label: 'Legal Region', value: record.legalRegion),
      _DetailSpec(label: 'Current DPD', value: record.currentDpd),
      _DetailSpec(label: 'Security Status', value: record.securityStatus),
      _DetailSpec(label: 'Borrower Status', value: record.borrowerStatus),
      _DetailSpec(label: 'Business Status', value: record.businessStatus),
      _DetailSpec(label: 'Disposal Status', value: record.disposalStatus),
      _DetailSpec(label: 'Previous Case Status', value: record.previousCaseStatus),
      _DetailSpec(label: 'Previous Case Type', value: record.previousCaseType),
      _DetailSpec(
        label: 'Previous Case Filing Date',
        value: record.previousCaseFilingDate,
      ),
    ];

    final workflowRows = [
      _DetailSpec(label: 'Initiate By', value: record.initiateBy),
      _DetailSpec(label: 'Initiate Date Time', value: record.initiateDateTime),
      _DetailSpec(label: 'STC By', value: record.stcBy),
      _DetailSpec(label: 'STC Date Time', value: record.stcDateTime),
      _DetailSpec(label: 'Recommended By', value: record.recommendedBy),
      _DetailSpec(label: 'Recommend Date Time', value: record.recommendDateTime),
      _DetailSpec(label: 'HO Acknowledge By', value: record.hoAcknowledgeBy),
      _DetailSpec(
        label: 'HO Acknowledge Date Time',
        value: record.hoAcknowledgeDateTime,
      ),
      _DetailSpec(label: 'Send To HOLM By', value: record.sendToHolmBy),
      _DetailSpec(
        label: 'Send To HOLM Date Time',
        value: record.sendToHolmDateTime,
      ),
      _DetailSpec(label: 'Verify By', value: record.verifyBy),
      _DetailSpec(label: 'Verify Date Time', value: record.verifyDateTime),
      _DetailSpec(label: 'Auc Ack By', value: record.aucAckBy),
      _DetailSpec(label: 'Auc Ack Date Time', value: record.aucAckDateTime),
      _DetailSpec(label: 'Auc STC By', value: record.aucStcBy),
      _DetailSpec(label: 'Auc STC Date Time', value: record.aucStcDateTime),
      _DetailSpec(label: 'Auc Verify By', value: record.aucVerifyBy),
      _DetailSpec(
        label: 'Auc Verify Date Time',
        value: record.aucVerifyDateTime,
      ),
      _DetailSpec(label: 'Auc STL By', value: record.aucStlBy),
      _DetailSpec(label: 'Auc STL Date Time', value: record.aucStlDateTime),
      _DetailSpec(label: 'Legal Response By', value: record.legalResponseBy),
      _DetailSpec(
        label: 'Legal Response Date Time',
        value: record.legalResponseDateTime,
      ),
      _DetailSpec(label: 'Send To HOOPS By', value: record.sendToHoopsBy),
      _DetailSpec(
        label: 'Send To HOOPS Date Time',
        value: record.sendToHoopsDateTime,
      ),
      _DetailSpec(label: 'File Deliver By', value: record.fileDeliverBy),
      _DetailSpec(
        label: 'File Deliver Date Time',
        value: record.fileDeliverDateTime,
      ),
      _DetailSpec(label: 'Legal Ack By', value: record.legalAckBy),
      _DetailSpec(label: 'Legal Ack Date Time', value: record.legalAckDateTime),
    ];

    final noticeAuctionRows = [
      _DetailSpec(label: 'Lawyer', value: record.lawyer),
      _DetailSpec(label: 'LN Scan Copy', value: record.lnScanCopy),
      _DetailSpec(label: 'LN Serve Date', value: record.lnServeDate),
      _DetailSpec(label: 'LN Expiry Date', value: record.lnExpiryDate),
      _DetailSpec(label: 'Paper Vendor', value: record.paperVendor),
      _DetailSpec(label: 'Paper Name', value: record.paperName),
      _DetailSpec(label: 'Paper Date', value: record.paperDate),
      _DetailSpec(label: 'Auction Date', value: record.auctionDate),
      _DetailSpec(label: 'Auction Time', value: record.auctionTime),
      _DetailSpec(label: 'Auction Address', value: record.auctionAddress),
      _DetailSpec(label: 'Auction Complete By', value: record.auctionCompleteBy),
      _DetailSpec(label: 'Auction Complete Date', value: record.auctionCompleteDate),
      _DetailSpec(
        label: 'Auction Complete Date Time',
        value: record.auctionCompleteDateTime,
      ),
      _DetailSpec(label: 'Auction Sign Memo', value: record.auctionSignMemo),
      _DetailSpec(
        label: 'Auction Complete Remarks',
        value: record.auctionCompleteRemarks,
      ),
      _DetailSpec(
        label: 'Previous Auction Sts',
        value: record.previousAuctionStatus,
      ),
      _DetailSpec(
        label: 'Current Auction Sts',
        value: record.currentAuctionStatus,
      ),
      _DetailSpec(label: 'Hold Reason', value: record.holdReason),
    ];

    final profileRows = [
      _DetailSpec(
        label: 'Previous CMA Approval Type',
        value: record.previousCmaApprovalType,
      ),
      _DetailSpec(
        label: 'Previous CMA Approval Date',
        value: record.previousCmaApprovalDate,
      ),
      _DetailSpec(label: 'Spouse Name', value: record.spouseName),
      _DetailSpec(label: 'Mother Name', value: record.motherName),
      _DetailSpec(
        label: 'Current/Updated Address',
        value: record.currentUpdatedAddress,
      ),
      _DetailSpec(label: 'Call Up Date', value: record.callUpDate),
      _DetailSpec(label: 'Call Up File', value: record.callUpFile),
      _DetailSpec(label: 'Chq Expiry Date', value: record.chqExpiryDate),
      _DetailSpec(label: 'Chq. Status', value: record.chqStatus),
      _DetailSpec(label: 'Last Payment Date', value: record.lastPaymentDate),
      _DetailSpec(label: 'Last Payment Amount', value: record.lastPaymentAmount),
      _DetailSpec(label: 'Case File District', value: record.caseFileDistrict),
      _DetailSpec(label: 'Case Claim Amount', value: record.caseClaimAmount),
      _DetailSpec(label: 'Interest Rate', value: record.interestRate),
      _DetailSpec(label: 'Logic for ARA Case', value: record.logicForAraCase),
      _DetailSpec(label: 'Remarks', value: record.remarks),
      _DetailSpec(label: 'Disposal Remarks', value: record.disposalRemarks),
      _DetailSpec(label: 'Judgment Summary', value: record.judgmentSummary),
    ];

    return _SectionCard(
      title: 'CMA Record',
      trailing: _StatusChip(label: record.status),
      child: Column(
        children: [
          _LabelValueList(items: primaryRows),
          const SizedBox(height: 14),
          _InnerGroup(title: 'Workflow Trail', items: workflowRows),
          const SizedBox(height: 10),
          _InnerGroup(title: 'Legal & Auction', items: noticeAuctionRows),
          const SizedBox(height: 10),
          _InnerGroup(title: 'Additional Notes', items: profileRows),
        ],
      ),
    );
  }
}

class _BorrowerSectionCard extends StatelessWidget {
  const _BorrowerSectionCard({required this.items});

  final List<_BorrowerInfo> items;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Borrower / Guarantor / Director',
      trailing: _CountChip(count: items.length, label: 'Profiles'),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _EntityBlock(
              title: '${items[index].type} ${index + 1}',
              subtitle: items[index].name,
              items: [
                _DetailSpec(label: 'Type', value: items[index].type),
                _DetailSpec(label: 'Name', value: items[index].name),
                _DetailSpec(label: 'Father Name', value: items[index].fatherName),
                _DetailSpec(
                  label: 'Present Address',
                  value: items[index].presentAddress,
                ),
                _DetailSpec(
                  label: 'Permanent Address',
                  value: items[index].permanentAddress,
                ),
                _DetailSpec(
                  label: 'Business Address',
                  value: items[index].businessAddress,
                ),
                _DetailSpec(label: 'Status', value: items[index].status),
                _DetailSpec(
                  label: 'Occupation',
                  value: items[index].occupation,
                ),
              ],
            ),
            if (index != items.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _FacilitySectionCard extends StatelessWidget {
  const _FacilitySectionCard({required this.items});

  final List<_FacilityInfo> items;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Facility Info',
      trailing: _CountChip(count: items.length, label: 'Facilities'),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _EntityBlock(
              title: 'Facility ${index + 1}',
              subtitle: items[index].facilityType,
              items: [
                _DetailSpec(label: 'Facility Type', value: items[index].facilityType),
                _DetailSpec(label: 'A/C Number', value: items[index].accountNumber),
                _DetailSpec(label: 'A/C Name', value: items[index].accountName),
                _DetailSpec(
                  label: 'Sch Desc.',
                  value: items[index].scheduleDescription,
                ),
                _DetailSpec(label: 'Int. Rate', value: items[index].interestRate),
                _DetailSpec(
                  label: 'Disbursement Date',
                  value: items[index].disbursementDate,
                ),
                _DetailSpec(
                  label: 'Disbursed Amount',
                  value: items[index].disbursedAmount,
                ),
                _DetailSpec(label: 'Expire Date', value: items[index].expireDate),
                _DetailSpec(label: 'Tenure', value: items[index].tenure),
                _DetailSpec(label: 'Payable', value: items[index].payable),
                _DetailSpec(label: 'Repayment', value: items[index].repayment),
                _DetailSpec(
                  label: 'Outstanding Balance',
                  value: items[index].outstandingBalance,
                ),
                _DetailSpec(
                  label: 'Outstanding Balance Date',
                  value: items[index].outstandingBalanceDate,
                ),
                _DetailSpec(
                  label: 'Overdue Balance',
                  value: items[index].overdueBalance,
                ),
                _DetailSpec(
                  label: 'Overdue BL Date',
                  value: items[index].overdueBalanceDate,
                ),
                _DetailSpec(label: 'Call-up Date', value: items[index].callUpDate),
                _DetailSpec(label: 'Write-off Date', value: items[index].writeOffDate),
                _DetailSpec(
                  label: 'Write-off Amount',
                  value: items[index].writeOffAmount,
                ),
                _DetailSpec(
                  label: 'Recovery After Write-off',
                  value: items[index].recoveryAfterWriteOff,
                ),
                _DetailSpec(label: 'CL(BB)', value: items[index].clBb),
                _DetailSpec(label: 'CL(BBL)', value: items[index].clBbl),
              ],
            ),
            if (index != items.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _SecuredDocumentSectionCard extends StatelessWidget {
  const _SecuredDocumentSectionCard({required this.items});

  final List<_SecuredDocumentFile> items;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Secured Document Files',
      trailing: _CountChip(count: items.length, label: 'Files'),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _DocumentRowCard(item: items[index]),
            if (index != items.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
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
            child,
          ],
        ),
      ),
    );
  }
}

class _InnerGroup extends StatelessWidget {
  const _InnerGroup({
    required this.title,
    required this.items,
  });

  final String title;
  final List<_DetailSpec> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Customer360Tokens.scaffoldBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Customer360Tokens.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Customer360Tokens.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          _LabelValueList(items: items),
        ],
      ),
    );
  }
}

class _EntityBlock extends StatelessWidget {
  const _EntityBlock({
    required this.title,
    required this.subtitle,
    required this.items,
  });

  final String title;
  final String subtitle;
  final List<_DetailSpec> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Customer360Tokens.scaffoldBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Customer360Tokens.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Customer360Tokens.textPrimary,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    if (subtitle.trim().isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Customer360Tokens.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _LabelValueList(items: items),
        ],
      ),
    );
  }
}

class _DocumentRowCard extends StatelessWidget {
  const _DocumentRowCard({required this.item});

  final _SecuredDocumentFile item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Customer360Tokens.scaffoldBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Customer360Tokens.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Customer360Tokens.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.insert_drive_file_outlined,
              color: Customer360Tokens.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Customer360Tokens.textPrimary,
                        fontSize: 12.8,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.fileLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Customer360Tokens.textSecondary,
                        fontSize: 10.8,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Customer360Tokens.surface,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Customer360Tokens.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.remove_red_eye_outlined,
                  size: 15,
                  color: Customer360Tokens.primaryStrong,
                ),
                const SizedBox(width: 6),
                Text(
                  'View',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Customer360Tokens.primaryStrong,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ],
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

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label});

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
        label.isEmpty ? '-' : label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Customer360Tokens.primaryStrong,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _CountChip extends StatelessWidget {
  const _CountChip({
    required this.count,
    required this.label,
  });

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Customer360Tokens.softBlue,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Customer360Tokens.border),
      ),
      child: Text(
        '$count $label',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Customer360Tokens.textSecondary,
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

class _BorrowerInfo {
  const _BorrowerInfo({
    required this.type,
    required this.name,
    required this.fatherName,
    required this.presentAddress,
    required this.permanentAddress,
    required this.businessAddress,
    required this.status,
    required this.occupation,
  });

  final String type;
  final String name;
  final String fatherName;
  final String presentAddress;
  final String permanentAddress;
  final String businessAddress;
  final String status;
  final String occupation;
}

class _FacilityInfo {
  const _FacilityInfo({
    required this.facilityType,
    required this.accountNumber,
    required this.accountName,
    required this.scheduleDescription,
    required this.interestRate,
    required this.disbursementDate,
    required this.disbursedAmount,
    required this.expireDate,
    required this.tenure,
    required this.payable,
    required this.repayment,
    required this.outstandingBalance,
    required this.outstandingBalanceDate,
    required this.overdueBalance,
    required this.overdueBalanceDate,
    required this.callUpDate,
    required this.writeOffDate,
    required this.writeOffAmount,
    required this.recoveryAfterWriteOff,
    required this.clBb,
    required this.clBbl,
  });

  final String facilityType;
  final String accountNumber;
  final String accountName;
  final String scheduleDescription;
  final String interestRate;
  final String disbursementDate;
  final String disbursedAmount;
  final String expireDate;
  final String tenure;
  final String payable;
  final String repayment;
  final String outstandingBalance;
  final String outstandingBalanceDate;
  final String overdueBalance;
  final String overdueBalanceDate;
  final String callUpDate;
  final String writeOffDate;
  final String writeOffAmount;
  final String recoveryAfterWriteOff;
  final String clBb;
  final String clBbl;
}

class _SecuredDocumentFile {
  const _SecuredDocumentFile({
    required this.title,
    required this.fileLabel,
  });

  final String title;
  final String fileLabel;
}

class _CmaRecord {
  const _CmaRecord({
    required this.slNo,
    required this.territory,
    required this.requisitionType,
    required this.district,
    required this.proposedType,
    required this.unitOffice,
    required this.loanAccountNo,
    required this.moreAccountNo,
    required this.cif,
    required this.loanSanctionDate,
    required this.branchSol,
    required this.status,
    required this.loanAccountName,
    required this.initiateBy,
    required this.previousCmaApprovalType,
    required this.previousCmaApprovalDate,
    required this.previousCaseStatus,
    required this.previousCaseType,
    required this.disposalStatus,
    required this.customerContact,
    required this.borrowerName,
    required this.initiateDateTime,
    required this.businessType,
    required this.stcBy,
    required this.spouseName,
    required this.stcDateTime,
    required this.motherName,
    required this.recommendedBy,
    required this.loanSegment,
    required this.recommendDateTime,
    required this.currentUpdatedAddress,
    required this.hoAcknowledgeBy,
    required this.region,
    required this.hoAcknowledgeDateTime,
    required this.callUpDate,
    required this.sendToHolmBy,
    required this.callUpFile,
    required this.sendToHolmDateTime,
    required this.chqExpiryDate,
    required this.verifyBy,
    required this.lastPaymentDate,
    required this.verifyDateTime,
    required this.lastPaymentAmount,
    required this.auctionCompleteBy,
    required this.caseFileDistrict,
    required this.caseClaimAmount,
    required this.remarks,
    required this.auctionCompleteDate,
    required this.previousAuctionStatus,
    required this.holdReason,
    required this.currentAuctionStatus,
    required this.previousCaseFilingDate,
    required this.currentDpd,
    required this.legalRegion,
    required this.disposalRemarks,
    required this.judgmentSummary,
    required this.businessStatus,
    required this.securityStatus,
    required this.borrowerStatus,
    required this.interestRate,
    required this.logicForAraCase,
    required this.chqStatus,
    required this.aucAckBy,
    required this.aucAckDateTime,
    required this.aucStcBy,
    required this.aucStcDateTime,
    required this.aucVerifyBy,
    required this.aucVerifyDateTime,
    required this.aucStlBy,
    required this.aucStlDateTime,
    required this.legalResponseBy,
    required this.legalResponseDateTime,
    required this.lawyer,
    required this.lnScanCopy,
    required this.lnServeDate,
    required this.lnExpiryDate,
    required this.paperVendor,
    required this.paperName,
    required this.paperDate,
    required this.auctionDate,
    required this.auctionTime,
    required this.auctionAddress,
    required this.auctionCompleteDateTime,
    required this.auctionSignMemo,
    required this.auctionCompleteRemarks,
    required this.sendToHoopsBy,
    required this.sendToHoopsDateTime,
    required this.fileDeliverBy,
    required this.fileDeliverDateTime,
    required this.legalAckBy,
    required this.legalAckDateTime,
  });

  final String slNo;
  final String territory;
  final String requisitionType;
  final String district;
  final String proposedType;
  final String unitOffice;
  final String loanAccountNo;
  final String moreAccountNo;
  final String cif;
  final String loanSanctionDate;
  final String branchSol;
  final String status;
  final String loanAccountName;
  final String initiateBy;
  final String previousCmaApprovalType;
  final String previousCmaApprovalDate;
  final String previousCaseStatus;
  final String previousCaseType;
  final String disposalStatus;
  final String customerContact;
  final String borrowerName;
  final String initiateDateTime;
  final String businessType;
  final String stcBy;
  final String spouseName;
  final String stcDateTime;
  final String motherName;
  final String recommendedBy;
  final String loanSegment;
  final String recommendDateTime;
  final String currentUpdatedAddress;
  final String hoAcknowledgeBy;
  final String region;
  final String hoAcknowledgeDateTime;
  final String callUpDate;
  final String sendToHolmBy;
  final String callUpFile;
  final String sendToHolmDateTime;
  final String chqExpiryDate;
  final String verifyBy;
  final String lastPaymentDate;
  final String verifyDateTime;
  final String lastPaymentAmount;
  final String auctionCompleteBy;
  final String caseFileDistrict;
  final String caseClaimAmount;
  final String remarks;
  final String auctionCompleteDate;
  final String previousAuctionStatus;
  final String holdReason;
  final String currentAuctionStatus;
  final String previousCaseFilingDate;
  final String currentDpd;
  final String legalRegion;
  final String disposalRemarks;
  final String judgmentSummary;
  final String businessStatus;
  final String securityStatus;
  final String borrowerStatus;
  final String interestRate;
  final String logicForAraCase;
  final String chqStatus;
  final String aucAckBy;
  final String aucAckDateTime;
  final String aucStcBy;
  final String aucStcDateTime;
  final String aucVerifyBy;
  final String aucVerifyDateTime;
  final String aucStlBy;
  final String aucStlDateTime;
  final String legalResponseBy;
  final String legalResponseDateTime;
  final String lawyer;
  final String lnScanCopy;
  final String lnServeDate;
  final String lnExpiryDate;
  final String paperVendor;
  final String paperName;
  final String paperDate;
  final String auctionDate;
  final String auctionTime;
  final String auctionAddress;
  final String auctionCompleteDateTime;
  final String auctionSignMemo;
  final String auctionCompleteRemarks;
  final String sendToHoopsBy;
  final String sendToHoopsDateTime;
  final String fileDeliverBy;
  final String fileDeliverDateTime;
  final String legalAckBy;
  final String legalAckDateTime;
}
