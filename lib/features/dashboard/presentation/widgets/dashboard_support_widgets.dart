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
    required this.monthLabel,
    this.selectedDay,
    this.onDayTap,
    this.onPreviousMonth,
    this.onNextMonth,
  });

  final List<int> highlightedDays;
  final String monthLabel;
  final int? selectedDay;
  final ValueChanged<int>? onDayTap;
  final VoidCallback? onPreviousMonth;
  final VoidCallback? onNextMonth;

  @override
  Widget build(BuildContext context) {
    const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    final monthMap = {
      'JANUARY': 1, 'FEBRUARY': 2, 'MARCH': 3, 'APRIL': 4, 'MAY': 5, 'JUNE': 6,
      'JULY': 7, 'AUGUST': 8, 'SEPTEMBER': 9, 'OCTOBER': 10, 'NOVEMBER': 11, 'DECEMBER': 12
    };

    final labelParts = monthLabel.split(' ');
    final monthName = labelParts.isNotEmpty ? labelParts[0] : '';
    final yearName = labelParts.length > 1 ? labelParts[1] : '';

    final month = monthMap[monthName.toUpperCase()] ?? 1;
    final year = int.tryParse(yearName) ?? DateTime.now().year;

    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);

    final List<String> days = [];
    int firstWeekdayIndex = firstDayOfMonth.weekday % 7; // Sun = 0
    for (int i = 0; i < firstWeekdayIndex; i++) {
      days.add('');
    }
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(i.toString());
    }

    final now = DateTime.now();
    final currentDay = now.day;
    final isCurrentMonth = now.month == month && now.year == year;

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                monthName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColor.textPrimary,
                      letterSpacing: 0.5,
                    ),
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                yearName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.textSecondary,
                    ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: onPreviousMonth,
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.chevron_left_rounded, size: 24),
              color: AppColor.primary,
            ),
            IconButton(
              onPressed: onNextMonth,
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.chevron_right_rounded, size: 24),
              color: AppColor.primary,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekdays
              .map(
                (day) => Expanded(
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColor.textSecondary.withValues(alpha: 0.7),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
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
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final label = days[index];
            final day = int.tryParse(label);
            if (day == null) return const SizedBox.shrink();

            final date = DateTime(year, month, day);
            final isWeekend = date.weekday == DateTime.friday || date.weekday == DateTime.saturday;
            final isToday = isCurrentMonth && day == currentDay;
            final isSelected = day == selectedDay;
            final hasSchedule = highlightedDays.contains(day);

            Color bgColor = AppColor.sectionBg;
            Color textColor = AppColor.textSteel;
            List<BoxShadow>? shadows;
            Border border = Border.all(color: AppColor.borderSoft.withValues(alpha: 0.5));

            if (isToday) {
              bgColor = AppColor.primary;
              textColor = AppColor.white;
              border = Border.all(color: AppColor.primary);
              shadows = [
                BoxShadow(
                  color: AppColor.primary.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ];
            } else if (isSelected) {
              bgColor = AppColor.primary.withValues(alpha: 0.1);
              textColor = AppColor.primary;
              border = Border.all(color: AppColor.primary.withValues(alpha: 0.3));
            } else if (isWeekend) {
              bgColor = AppColor.dashboardMetricCoral.withValues(alpha: 0.1);
              textColor = AppColor.dashboardMetricCoral;
            }

            return InkWell(
              onTap: () => onDayTap?.call(day),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: border,
                  boxShadow: shadows,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textColor,
                            fontWeight: (isToday || isSelected) ? FontWeight.w900 : FontWeight.w600,
                          ),
                    ),
                    if (hasSchedule && !isToday)
                      Positioned(
                        bottom: 6,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
