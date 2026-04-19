
class DashboardLocalDataSource {
  Future<Map<String, dynamic>> fetchSummary() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    return <String, dynamic>{
      'firstLegalNotice': 449,
      'cmaApproved': 151,
      'auctionCompleted': 37,
      'complianceRegulatory': 48,
      'legalCostCr': 0.09,
      'deliveryStatus': <Map<String, dynamic>>[
        {'label': 'Live Case', 'primaryValue': 21, 'secondaryValue': 19},
        {
          'label': 'Case Filing Pending',
          'primaryValue': 26,
          'secondaryValue': 18,
        },
        {
          'label': 'Instrument Delivered',
          'primaryValue': 49,
          'secondaryValue': 42,
        },
      ],
      'liveCaseInformation': <Map<String, dynamic>>[
        {'label': 'ARA', 'value': 12706},
        {'label': 'NI ACT', 'value': 3741},
        {'label': 'Others', 'value': 567},
        {'label': 'Total', 'value': 17014},
      ],
      'warrantProcess': <String, dynamic>{
        'primaryLabel': 'Pending Warrant',
        'secondaryLabel': 'Warrant Exe.',
        'primaryValue': 72,
        'secondaryValue': 28,
      },
      'caseUpdateInformation': <Map<String, dynamic>>[
        {'label': 'Status Update', 'value': 0},
        {'label': 'Pending Update', 'value': 14240},
        {'label': 'Yet To \n Fix', 'value': 2491},
        {'label': 'Not Available', 'value': 250},
      ],
      'hcAdMatter': <Map<String, dynamic>>[
        {'label': 'High Court', 'value': 31},
        {'label': 'Appeal Division', 'value': 0},
      ],
      'appealAndBailMoney': <String, dynamic>{
        'primaryLabel': 'Bail Money (Cr.)',
        'secondaryLabel': 'Appeal Money (Cr.)',
        'primaryValue': 96,
        'secondaryValue': 4,
      },
      'professionalBills': <Map<String, dynamic>>[
        {'label': 'Court Ent.', 'value': 0},
        {'label': 'Staff Con.', 'value': 0},
        {'label': 'Vendor Bill', 'value': 0},
        {'label': 'Lawyer Bill', 'value': 0.02},
        {'label': 'Court Fees', 'value': 0.01},
        {'label': 'Total Bill', 'value': 0.04},
      ],
      'memosAndNotices': <Map<String, dynamic>>[
        {
          'title': 'Legal notice sent for A/C 2342 against overdue facility',
          'date': '25-Sep-25',
        },
        {
          'title': 'Recovery memo update received from regional team',
          'date': '18-Sep-25',
        },
        {
          'title': 'Auction process status changed to completed review',
          'date': '02-Sep-25',
        },
      ],
      'highlightedScheduleDays': <int>[5, 10, 17, 24],
      'scheduleMonthLabel': 'APRIL 2026',
    };

  }
}
