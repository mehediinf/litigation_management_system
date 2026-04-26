import 'package:flutter/material.dart';

class Customer360Tokens {
  static const Color primary = Color(0xFF0B5FFF);
  static const Color primaryStrong = Color(0xFF0A4CD4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color scaffoldBg = Color(0xFFF4F7FA);
  static const Color softBlue = Color(0xFFF8FAFF);
  static const Color border = Color(0xFFE9EEF5);
  static const Color divider = Color(0xFFEDF2F9);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color emphasisBg = Color(0xFFF0F6FF);

  static const List<BoxShadow> softShadow = [
    BoxShadow(
      color: Color(0x080F172A),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];
}

class Customer360Scaffold extends StatelessWidget {
  const Customer360Scaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customer360Tokens.scaffoldBg,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Customer360Tokens.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Customer360Tokens.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
        ),
        actions: actions,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Customer360Tokens.divider,
            height: 1,
          ),
        ),
      ),
      body: body,
    );
  }
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  StickyHeaderDelegate({
    required this.title,
    this.icon = Icons.push_pin_rounded,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final showElevation = overlapsContent || shrinkOffset > 0;

    return Container(
      width: double.infinity,
      height: maxExtent,
      color: Customer360Tokens.scaffoldBg.withValues(alpha: 0.96),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Customer360Tokens.border,
            width: 1.2,
          ),
          boxShadow: [
            ...Customer360Tokens.softShadow,
            if (showElevation)
              BoxShadow(
                color: Customer360Tokens.primary.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Customer360Tokens.softBlue,
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
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Customer360Tokens.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 68;

  @override
  double get minExtent => 68;

  @override
  bool shouldRebuild(covariant StickyHeaderDelegate oldDelegate) {
    return oldDelegate.title != title || oldDelegate.icon != icon;
  }
}

class FieldGroupCard extends StatelessWidget {
  const FieldGroupCard({
    super.key,
    required this.fields,
    this.showEmptyFields = false,
  });

  final List<FieldItem> fields;
  final bool showEmptyFields;

  @override
  Widget build(BuildContext context) {
    final visibleFields = showEmptyFields
        ? fields
        : fields.where((field) => field.hasValue).toList();

    if (visibleFields.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Customer360Tokens.border, width: 1.5),
        boxShadow: Customer360Tokens.softShadow,
      ),
      child: Column(
        children: [
          ...visibleFields.asMap().entries.map((entry) {
            final field = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              child: DetailRow(field: field),
            );
          }),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.field,
  });

  final FieldItem field;

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: field.emphasize
              ? Customer360Tokens.primaryStrong
              : Customer360Tokens.textPrimary,
          fontWeight: field.emphasize ? FontWeight.w800 : FontWeight.w700,
          height: 1.32,
          fontSize: 13.5,
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              field.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Customer360Tokens.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    height: 1.3,
                  ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: field.emphasize
              ? Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Customer360Tokens.emphasisBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Customer360Tokens.primary.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      field.displayValue,
                      style: valueStyle,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    field.displayValue,
                    style: valueStyle,
                  ),
                ),
        ),
      ],
    );
  }
}

class FieldItem {
  const FieldItem({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  bool get hasValue => value.trim().isNotEmpty;
  String get displayValue => hasValue ? value : '-';
}
