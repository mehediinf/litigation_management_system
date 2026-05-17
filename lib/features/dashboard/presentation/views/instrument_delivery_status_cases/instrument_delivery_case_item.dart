// lib/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_case_item.dart

class InstrumentDeliveryCaseItem {
  const InstrumentDeliveryCaseItem({
    required this.serialNumber,
    required this.proposedType,
    required this.reqType,
    required this.accountNumber,
    required this.accountName,
    required this.borrowerName,
    required this.region,
    required this.territory,
    required this.district,
    required this.caseNumber,
  });

  final int serialNumber;
  final String proposedType;
  final String reqType;
  final String accountNumber;
  /// AC Name (web table column).
  final String accountName;
  /// Borrower Name (separate column on web).
  final String borrowerName;
  final String region;
  final String territory;
  final String district;
  final String caseNumber;
}

/// Which dashboard row opened the list; controls borrower vs case number rows.
enum InstrumentDeliveryCasesSection {
  /// "Live Case" — Case Number row on card; no Borrower row; Preview always.
  liveCase,

  /// "Case Filing Pending" — Borrower row; no Case Number row on card; Preview always.
  caseFilingPending,

  /// "Instrument Delivered" — Borrower row; no Case Number row on card; Preview always.
  instrumentDelivered,

  /// Unknown label — borrower + Case Number rows on card; Preview always.
  other;

  static InstrumentDeliveryCasesSection fromDashboardLabel(String label) {
    switch (label.trim()) {
      case 'Live Case':
        return InstrumentDeliveryCasesSection.liveCase;
      case 'Case Filing Pending':
        return InstrumentDeliveryCasesSection.caseFilingPending;
      case 'Instrument Delivered':
        return InstrumentDeliveryCasesSection.instrumentDelivered;
      default:
        return InstrumentDeliveryCasesSection.other;
    }
  }

  /// Case Number row on the list card (hidden for Pending / Delivered).
  bool get showCaseNumberRow =>
      this == InstrumentDeliveryCasesSection.liveCase ||
      this == InstrumentDeliveryCasesSection.other;

  /// Borrower Name row (hidden for Live Case only).
  bool get showBorrowerNameRow =>
      this != InstrumentDeliveryCasesSection.liveCase;
}
