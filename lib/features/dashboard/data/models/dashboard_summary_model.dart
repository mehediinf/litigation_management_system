import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';

class DashboardSummaryModel extends DashboardSummary {
  const DashboardSummaryModel({
    required super.firstLegalNotice,
    required super.cmaApproved,
    required super.auctionCompleted,
    required super.complianceRegulatory,
    required super.legalCostCr,
    required super.deliveryStatus,
    required super.liveCaseInformation,
    required super.warrantProcess,
    required super.caseUpdateInformation,
    required super.hcAdMatter,
    required super.appealAndBailMoney,
    required super.professionalBills,
    required super.memosAndNotices,
    required super.highlightedScheduleDays,
    required super.scheduleMonthLabel,
  });

  factory DashboardSummaryModel.fromMap(Map<String, dynamic> map) {
    return DashboardSummaryModel(
      firstLegalNotice: map['firstLegalNotice'] as int? ?? 0,
      cmaApproved: map['cmaApproved'] as int? ?? 0,
      auctionCompleted: map['auctionCompleted'] as int? ?? 0,
      complianceRegulatory: map['complianceRegulatory'] as int? ?? 0,
      legalCostCr: (map['legalCostCr'] as num?)?.toDouble() ?? 0,
      deliveryStatus: _comparisonMetrics(
        map['deliveryStatus'] as List<dynamic>? ?? const [],
      ),
      liveCaseInformation: _chartMetrics(
        map['liveCaseInformation'] as List<dynamic>? ?? const [],
      ),
      warrantProcess: _ratioMetric(
        map['warrantProcess'] as Map<String, dynamic>? ?? const {},
      ),
      caseUpdateInformation: _chartMetrics(
        map['caseUpdateInformation'] as List<dynamic>? ?? const [],
      ),
      hcAdMatter: _chartMetrics(
        map['hcAdMatter'] as List<dynamic>? ?? const [],
      ),
      appealAndBailMoney: _ratioMetric(
        map['appealAndBailMoney'] as Map<String, dynamic>? ?? const {},
      ),
      professionalBills: _chartMetrics(
        map['professionalBills'] as List<dynamic>? ?? const [],
      ),
      memosAndNotices: _noticeItems(
        map['memosAndNotices'] as List<dynamic>? ?? const [],
      ),
      highlightedScheduleDays: List<int>.from(
        map['highlightedScheduleDays'] as List<dynamic>? ?? const [],
      ),
      scheduleMonthLabel: map['scheduleMonthLabel'] as String? ?? 'APRIL 2026',
    );
  }

  static List<ComparisonMetric> _comparisonMetrics(List<dynamic> items) {
    return items
        .map(
          (item) => ComparisonMetric(
            label: item['label'] as String? ?? '',
            primaryValue: item['primaryValue'] as int? ?? 0,
            secondaryValue: item['secondaryValue'] as int? ?? 0,
          ),
        )
        .toList();
  }

  static List<ChartMetric> _chartMetrics(List<dynamic> items) {
    return items
        .map(
          (item) => ChartMetric(
            label: item['label'] as String? ?? '',
            value: (item['value'] as num?)?.toDouble() ?? 0,
          ),
        )
        .toList();
  }

  static RatioMetric _ratioMetric(Map<String, dynamic> map) {
    return RatioMetric(
      primaryLabel: map['primaryLabel'] as String? ?? '',
      secondaryLabel: map['secondaryLabel'] as String? ?? '',
      primaryValue: (map['primaryValue'] as num?)?.toDouble() ?? 0,
      secondaryValue: (map['secondaryValue'] as num?)?.toDouble() ?? 0,
    );
  }

  static List<NoticeItem> _noticeItems(List<dynamic> items) {
    return items
        .map(
          (item) => NoticeItem(
            title: item['title'] as String? ?? '',
            date: item['date'] as String? ?? '',
          ),
        )
        .toList();
  }
}
