// lib/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_status_cases_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

import 'case_filing_pending_preview.dart';
import 'instrument_delivery_case_item.dart';
import 'instrument_delivery_cases_app_bar.dart';
import 'instrument_delivery_preview.dart';
import 'live_case_preview.dart';

class InstrumentDeliveryStatusCasesPage extends StatelessWidget {
  const InstrumentDeliveryStatusCasesPage({
    super.key,
    required this.sectionTitle,
  });

  final String sectionTitle;

  static List<InstrumentDeliveryCaseItem> _demoRows() {
    return const [
      InstrumentDeliveryCaseItem(
        serialNumber: 1001,
        proposedType: 'Loan',
        reqType: 'ARA-2003',
        accountNumber: '1111111111111111',
        accountName: 'Bbl',
        borrowerName: 'Bbl',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'LC-1001/2024',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1003,
        proposedType: 'Loan',
        reqType: 'NI Act-138',
        accountNumber: '3333333333333333',
        accountName: 'Bbl',
        borrowerName: 'Bbl',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'LC-1003/2024',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1004,
        proposedType: 'Loan',
        reqType: 'ARA-2003',
        accountNumber: '4444444444444444',
        accountName: 'Bbl',
        borrowerName: 'Bbl',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'LC-1004/2024',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1005,
        proposedType: 'Loan',
        reqType: 'NI Act-138',
        accountNumber: '5555555555555555',
        accountName: 'Bbl',
        borrowerName: 'Bbl',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'LC-1005/2024',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1006,
        proposedType: 'Loan',
        reqType: 'ARA-2003',
        accountNumber: '6666666666666666',
        accountName: 'Bbl',
        borrowerName: 'Bbl',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'LC-1006/2024',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1007,
        proposedType: 'Loan',
        reqType: 'NI Act-138',
        accountNumber: '7777777777777777',
        accountName: 'Bbl',
        borrowerName: 'Bbl',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'LC-1007/2024',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1008,
        proposedType: 'Loan',
        reqType: 'ARA-2003',
        accountNumber: '8888888888888888',
        accountName: 'Bbl',
        borrowerName: 'Bbl',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'LC-1008/2024',
      ),
      // Second reference table (mixed Loan/Card, Artho case numbers)
      InstrumentDeliveryCaseItem(
        serialNumber: 1031,
        proposedType: 'Loan',
        reqType: 'NI Act-138',
        accountNumber: '4702604254894001',
        accountName: 'Hotel Mongla',
        borrowerName: 'Hotel Mongla',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'Artho-50/2022',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1079,
        proposedType: 'Loan',
        reqType: 'ARA-2003',
        accountNumber: '6402603578821004',
        accountName: 'Sompa Sharee Bitan',
        borrowerName: 'Sompa Sharee Bitan',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'Artho-20/2022',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1023,
        proposedType: 'Loan',
        reqType: 'NI Act-138',
        accountNumber: '5202604411023009',
        accountName: 'M/s Ali Enterprise',
        borrowerName: 'M/s Ali Enterprise',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'Artho-02/2023',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1051,
        proposedType: 'Loan',
        reqType: 'ARA-2003',
        accountNumber: '6102604411023999',
        accountName: 'Rustam Ali Bij Vander',
        borrowerName: 'Rustam Ali Bij Vander',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'Artho-133/2022',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1168,
        proposedType: 'Card',
        reqType: 'ARA-2003',
        accountNumber: '111111******1111',
        accountName: 'Shah Md. Nazmus Shakib',
        borrowerName: 'Shah Md. Nazmus Shakib',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'Artho-689/2022',
      ),
      InstrumentDeliveryCaseItem(
        serialNumber: 1105,
        proposedType: 'Card',
        reqType: 'NI Act-138',
        accountNumber: '222222******2222',
        accountName: 'Karim & Sons',
        borrowerName: 'Karim & Sons',
        region: 'Central',
        territory: 'ELEPHANT ROAD',
        district: 'DHAKA-ELEPHANT ROAD',
        caseNumber: 'Artho-301/2022',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final rows = _demoRows();

    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      appBar: buildInstrumentDeliveryCasesAppBar(context, title: sectionTitle),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        physics: const BouncingScrollPhysics(),
        itemCount: rows.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _CaseCard(
            item: rows[index],
            section: InstrumentDeliveryCasesSection.fromDashboardLabel(
              sectionTitle,
            ),
          );
        },
      ),
    );
  }
}

class _CaseCard extends StatelessWidget {
  const _CaseCard({required this.item, required this.section});

  final InstrumentDeliveryCaseItem item;
  final InstrumentDeliveryCasesSection section;

  void _openPreview(BuildContext context) {
    Widget previewPage;

    switch (section) {
      case InstrumentDeliveryCasesSection.liveCase:
        previewPage = LiveCasePreview(item: item);
        break;
      case InstrumentDeliveryCasesSection.caseFilingPending:
        previewPage = CaseFilingPendingPreview(item: item);
        break;
      case InstrumentDeliveryCasesSection.instrumentDelivered:
      default:
        previewPage = InstrumentDeliveryPreview(item: item);
        break;
    }

    Navigator.of(
      context,
    ).push<void>(MaterialPageRoute<void>(builder: (_) => previewPage));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showCaseNumberRow = section.showCaseNumberRow;
    final showBorrower = section.showBorrowerNameRow;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.panelBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColor.borderSoft),
        boxShadow: const [
          BoxShadow(
            color: AppColor.cardShadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
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
                    const SizedBox(height: 4),
                    Text(
                      item.accountName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColor.textPrimary,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _PreviewLaunchButton(onPressed: () => _openPreview(context)),
            ],
          ),
          const SizedBox(height: 14),
          _LabeledRow(
            label: 'SL',
            value: '${item.serialNumber}',
            icon: Icons.tag_outlined,
          ),
          const SizedBox(height: 8),
          _LabeledRow(
            label: 'Proposed Type',
            value: item.proposedType,
            icon: Icons.category_outlined,
          ),
          const SizedBox(height: 8),
          _LabeledRow(
            label: 'Req Type',
            value: item.reqType,
            icon: Icons.article_outlined,
          ),
          const SizedBox(height: 8),
          _LabeledRow(
            label: 'AC',
            value: item.accountNumber,
            icon: Icons.numbers_outlined,
          ),
          if (showBorrower) ...[
            const SizedBox(height: 8),
            _LabeledRow(
              label: 'Borrower Name',
              value: item.borrowerName,
              icon: Icons.person_outline_rounded,
            ),
          ],
          if (showCaseNumberRow) ...[
            const SizedBox(height: 8),
            _LabeledRow(
              label: 'Case Number',
              value: item.caseNumber,
              icon: Icons.gavel_outlined,
            ),
          ],
          const SizedBox(height: 8),
          _LabeledRow(
            label: 'District',
            value: item.district,
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 12),
          Divider(height: 1, color: AppColor.divider),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _FooterPill(label: 'Region', value: item.region),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _FooterPill(label: 'Territory', value: item.territory),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreviewLaunchButton extends StatelessWidget {
  const _PreviewLaunchButton({required this.onPressed});

  final VoidCallback onPressed;

  static const double _radius = 20;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w800,
      letterSpacing: 0.35,
      color: AppColor.primaryStrong,
    );

    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(_radius),
        splashColor: AppColor.primary.withValues(alpha: 0.12),
        highlightColor: AppColor.primary.withValues(alpha: 0.06),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_radius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.white,
                AppColor.softBlue.withValues(alpha: 0.65),
                AppColor.emphasisBg.withValues(alpha: 0.9),
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
            border: Border.all(
              color: AppColor.primary.withValues(alpha: 0.28),
              width: 1.25,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryStrong.withValues(alpha: 0.08),
                blurRadius: 0,
                offset: const Offset(0, 1),
              ),
              BoxShadow(
                color: AppColor.primary.withValues(alpha: 0.14),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: AppColor.white.withValues(alpha: 0.8),
                blurRadius: 0,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Preview', style: labelStyle),
          ),
        ),
      ),
    );
  }
}

class _LabeledRow extends StatelessWidget {
  const _LabeledRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColor.textMuted),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.textMuted,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 2),
              SelectableText(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FooterPill extends StatelessWidget {
  const _FooterPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.sectionBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColor.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColor.textSlate,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
