//lib/features/customer_360/presentation/views/final_legal_notice_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class FinalLegalNoticePage extends StatelessWidget {
  const FinalLegalNoticePage({super.key});

  static const List<_LegalNoticeField> _timelineFields = [
    _LegalNoticeField(
      label: 'Legal Notice Sent Date',
      value: '26-04-2026',
      icon: Icons.event_available_outlined,
      highlight: true,
    ),
    _LegalNoticeField(
      label: 'Legal Notice Expiry Date',
      value: '26-04-2027',
      icon: Icons.event_busy_outlined,
      highlight: true,
    ),
  ];

  static const List<_LegalNoticeField> _statusFields = [
    _LegalNoticeField(
      label: 'Legal Notice Status',
      value: 'Pending update',
      icon: Icons.gavel_outlined,
    ),
    _LegalNoticeField(
      label: 'Total Legal Notice Sent',
      value: '0',
      icon: Icons.summarize_outlined,
    ),
    _LegalNoticeField(
      label: 'Legal Notice Copy',
      value: 'No document linked',
      icon: Icons.description_outlined,
    ),
    _LegalNoticeField(
      label: 'Lawyer Name',
      value: 'Not assigned',
      icon: Icons.person_outline_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Customer360Scaffold(
      title: 'Final Legal Notice Details',
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverMainAxisGroup(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  title: 'Timeline Overview',
                  icon: Icons.timeline_rounded,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
                sliver: SliverList.separated(
                  itemCount: _timelineFields.length,
                  itemBuilder: (context, index) => _TimelineCard(
                    field: _timelineFields[index],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
              ),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  title: 'Notice Details',
                  icon: Icons.rule_folder_outlined,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _DetailCard(
                      field: _statusFields[index],
                    ),
                    childCount: _statusFields.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class _OverviewMetric extends StatelessWidget {
  const _OverviewMetric({
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              size: 18,
              color: Customer360Tokens.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Customer360Tokens.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 13.5,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Customer360Tokens.textSecondary,
                        fontSize: 10.8,
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

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.field});

  final _LegalNoticeField field;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Customer360Tokens.border, width: 1.1),
        boxShadow: Customer360Tokens.softShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Customer360Tokens.softBlue,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              field.icon,
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
                  field.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Customer360Tokens.textSecondary,
                        fontSize: 10.8,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: Customer360Tokens.emphasisBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Customer360Tokens.primary.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    field.value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Customer360Tokens.primaryStrong,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
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

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.field});

  final _LegalNoticeField field;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Customer360Tokens.border, width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Customer360Tokens.softBlue,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              field.icon,
              size: 18,
              color: Customer360Tokens.primary,
            ),
          ),
          const Spacer(),
          Text(
            field.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Customer360Tokens.textSecondary,
                  fontSize: 10.6,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            field.value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: field.highlight
                      ? Customer360Tokens.primaryStrong
                      : Customer360Tokens.textPrimary,
                  fontSize: 12.8,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }
}

class _LegalNoticeField {
  const _LegalNoticeField({
    required this.label,
    required this.value,
    required this.icon,
    this.highlight = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool highlight;
}
