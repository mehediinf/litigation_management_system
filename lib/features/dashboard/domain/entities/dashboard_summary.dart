class DashboardSummary {
  const DashboardSummary({
    required this.firstLegalNotice,
    required this.cmaApproved,
    required this.auctionCompleted,
    required this.complianceRegulatory,
    required this.legalCostCr,
    required this.deliveryStatus,
    required this.liveCaseInformation,
    required this.warrantProcess,
    required this.caseUpdateInformation,
    required this.hcAdMatter,
    required this.appealAndBailMoney,
    required this.professionalBills,
    required this.memosAndNotices,
    required this.highlightedScheduleDays,
    required this.scheduleMonthLabel,
  });

  final int firstLegalNotice;
  final int cmaApproved;
  final int auctionCompleted;
  final int complianceRegulatory;
  final double legalCostCr;
  final List<ComparisonMetric> deliveryStatus;
  final List<ChartMetric> liveCaseInformation;
  final RatioMetric warrantProcess;
  final List<ChartMetric> caseUpdateInformation;
  final List<ChartMetric> hcAdMatter;
  final RatioMetric appealAndBailMoney;
  final List<ChartMetric> professionalBills;
  final List<NoticeItem> memosAndNotices;
  final List<int> highlightedScheduleDays;
  final String scheduleMonthLabel;
}

class ComparisonMetric {
  const ComparisonMetric({
    required this.label,
    required this.primaryValue,
    required this.secondaryValue,
  });

  final String label;
  final int primaryValue;
  final int secondaryValue;
}

class ChartMetric {
  const ChartMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final double value;
}

class RatioMetric {
  const RatioMetric({
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.primaryValue,
    required this.secondaryValue,
  });

  final String primaryLabel;
  final String secondaryLabel;
  final double primaryValue;
  final double secondaryValue;
}

class NoticeItem {
  const NoticeItem({
    required this.title,
    required this.date,
  });

  final String title;
  final String date;
}
