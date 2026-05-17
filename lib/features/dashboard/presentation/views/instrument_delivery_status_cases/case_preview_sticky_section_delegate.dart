// lib/features/dashboard/presentation/views/instrument_delivery_status_cases/case_preview_sticky_section_delegate.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

class CasePreviewStickySectionDelegate extends SliverPersistentHeaderDelegate {
  const CasePreviewStickySectionDelegate({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  static const double extent = 52;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Material(
        color: AppColor.panelBg,
        elevation: overlapsContent ? 2 : 0,
        shadowColor: AppColor.cardShadow,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: extent,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColor.borderSoft),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColor.emphasisBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: AppColor.primaryStrong),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColor.textDeepBlue,
                    letterSpacing: -0.15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent;

  @override
  bool shouldRebuild(covariant CasePreviewStickySectionDelegate oldDelegate) {
    return title != oldDelegate.title || icon != oldDelegate.icon;
  }
}
