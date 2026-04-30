//lib/features/customer_360/presentation/views/final_legal_notice_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class FinalLegalNoticePage extends StatefulWidget {
  const FinalLegalNoticePage({super.key});

  @override
  State<FinalLegalNoticePage> createState() => _FinalLegalNoticePageState();
}

class _FinalLegalNoticePageState extends State<FinalLegalNoticePage> {
  final Set<int> _collapsedRecords = <int>{};

  static const List<_LegalNoticeRecord> _records = [
    _LegalNoticeRecord(
      sentDate: '17-Jan-22 12:00 AM',
      expiryDate: '17-Jan-22 12:00 AM',
      lawyerName: '12 BC LAW CHAMBERS',
    ),
    _LegalNoticeRecord(
      sentDate: '24-Jan-22 12:00 AM',
      expiryDate: '24-Jan-22 12:00 AM',
      lawyerName: 'Adv. Md. Shahidul Islam',
    ),
    _LegalNoticeRecord(
      sentDate: '19-Jan-22 12:00 AM',
      expiryDate: '19-Jan-22 12:00 AM',
      lawyerName: '12 BC LAW CHAMBERS',
    ),
    _LegalNoticeRecord(
      sentDate: '13-Feb-22 12:00 AM',
      expiryDate: '13-Feb-22 12:00 AM',
      status: 'Legal Notice Sent',
      lawyerName: 'SALINA AKTER',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Customer360Scaffold(
      title: 'Final Legal Notice Details',
      enableSearch: true,
      searchHintText: 'Search final legal notice',
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 2)),
          ...List.generate(_records.length, (index) {
            return SliverMainAxisGroup(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyHeaderDelegate(
                    title: 'Notice Entry ${index + 1}',
                    icon: Icons.mark_email_read_outlined,
                    cardColor: AppColor.finalNoticeHeaderCard,
                    borderColor: AppColor.finalNoticeHeaderBorder,
                    iconBackgroundColor: AppColor.finalNoticeHeaderIconBg,
                    iconColor: AppColor.finalNoticeHeaderIcon,
                    textColor: AppColor.finalNoticeHeaderText,
                    onTap: () {
                      setState(() {
                        if (_collapsedRecords.contains(index)) {
                          _collapsedRecords.remove(index);
                        } else {
                          _collapsedRecords.add(index);
                        }
                      });
                    },
                    isCollapsed: _collapsedRecords.contains(index),
                  ),
                ),
                if (!_collapsedRecords.contains(index))
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: _NoticeRecordCard(
                        record: _records[index],
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _NoticeRecordCard extends StatelessWidget {
  const _NoticeRecordCard({
    required this.record,
  });

  final _LegalNoticeRecord record;

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
                    'Legal Notice Record',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Customer360Tokens.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                  ),
                ),
                _StatusChip(status: record.status),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _InfoTile(
                    label: 'Sent Date',
                    value: record.sentDate,
                    icon: Icons.calendar_today_outlined,
                    emphasized: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InfoTile(
                    label: 'Expiry Date',
                    value: record.expiryDate,
                    icon: Icons.event_busy_outlined,
                    emphasized: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _InfoTile(
                    label: 'Legal Notice Copy',
                    value: record.legalNoticeCopy,
                    icon: Icons.description_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InfoTile(
                    label: 'Total Legal Notice Sent',
                    value: record.totalLegalNoticeSent,
                    icon: Icons.summarize_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _WideInfoTile(
              label: 'Lawyer Name',
              value: record.lawyerName,
              icon: Icons.person_outline_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: emphasized ? Customer360Tokens.emphasisBg : Customer360Tokens.scaffoldBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: emphasized
              ? Customer360Tokens.primary.withValues(alpha: 0.1)
              : Customer360Tokens.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 16,
              color: Customer360Tokens.primary,
            ),
          ),
          const Spacer(),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Customer360Tokens.textSecondary,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: emphasized
                      ? Customer360Tokens.primaryStrong
                      : Customer360Tokens.textPrimary,
                  fontSize: 12.3,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }
}

class _WideInfoTile extends StatelessWidget {
  const _WideInfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

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
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              size: 18,
              color: Customer360Tokens.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Customer360Tokens.textSecondary,
                        fontSize: 10.6,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Customer360Tokens.textPrimary,
                        fontSize: 12.8,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
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

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final normalized = status.trim();
    final hasStatus = normalized.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: hasStatus ? Customer360Tokens.emphasisBg : AppColor.mutedStatusBg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: hasStatus
              ? Customer360Tokens.primary.withValues(alpha: 0.12)
              : Customer360Tokens.border,
        ),
      ),
      child: Text(
        hasStatus ? normalized : 'Unspecified',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: hasStatus
                  ? Customer360Tokens.primaryStrong
                  : Customer360Tokens.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _LegalNoticeRecord {
  const _LegalNoticeRecord({
    required this.sentDate,
    required this.expiryDate,
    this.status = '',
    this.totalLegalNoticeSent = '-',
    this.legalNoticeCopy = 'Not provided',
    this.lawyerName = '-',
  });

  final String sentDate;
  final String expiryDate;
  final String status;
  final String totalLegalNoticeSent;
  final String legalNoticeCopy;
  final String lawyerName;
}
