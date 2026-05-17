import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';

class MemoTile extends StatelessWidget {
  const MemoTile({
    super.key,
    required this.item,
  });

  final NoticeItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.softBlue,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColor.borderSoft.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColor.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.description_rounded,
              color: AppColor.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColor.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColor.textMuted,
          ),
        ],
      ),
    );
  }
}

class MiniCalendar extends StatelessWidget {
  const MiniCalendar({
    super.key,
    required this.highlightedDays,
    this.onDayTap,
  });

  final List<int> highlightedDays;
  final ValueChanged<int>? onDayTap;

  @override
  Widget build(BuildContext context) {
    const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    const days = [
      '', '', '', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30',
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekdays
              .map(
                (day) => Expanded(
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColor.textSecondary,
                        ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          itemCount: days.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final label = days[index];
            final day = int.tryParse(label);
            final isActive = day != null && highlightedDays.contains(day);

            return InkWell(
              onTap: day != null ? () => onDayTap?.call(day) : null,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                decoration: BoxDecoration(
                  color: isActive ? AppColor.primary : AppColor.sectionBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isActive ? AppColor.primary : AppColor.borderSoft,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isActive ? AppColor.white : AppColor.textSteel,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
