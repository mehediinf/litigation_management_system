import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';

class ComparisonChart extends StatelessWidget {
  const ComparisonChart({
    super.key,
    required this.items,
  });

  final List<ComparisonMetric> items;

  @override
  Widget build(BuildContext context) {
    final maxValue = items.fold<int>(
      1,
      (current, item) => [
        current,
        item.primaryValue + item.secondaryValue,
      ].reduce((a, b) => a > b ? a : b),
    );

    return Column(
      children: [
        Row(
          children: const [
            _LegendDot(label: 'File Delivered', color: AppColor.dashboardLegendPrimary),
            SizedBox(width: 14),
            _LegendDot(label: 'Cheque Delivered', color: AppColor.dashboardLegendSecondary),
          ],
        ),
        const SizedBox(height: 18),
        ...items.map((item) {
          final total = item.primaryValue + item.secondaryValue;
          final widthFactor = total / maxValue;

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final totalWidth = constraints.maxWidth * widthFactor;
                    final primaryWidth =
                        total == 0 ? 0.0 : totalWidth * item.primaryValue / total;
                    final secondaryWidth = totalWidth - primaryWidth;

                    return Row(
                      children: [
                        Container(
                          width: primaryWidth,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(999),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${item.primaryValue}',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        Container(
                          width: secondaryWidth,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: AppColor.dashboardBarSecondary,
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(999),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${item.secondaryValue}',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColor.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class VerticalBarChart extends StatelessWidget {
  const VerticalBarChart({
    super.key,
    required this.metrics,
    required this.colors,
  });

  final List<ChartMetric> metrics;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    final maxValue = metrics.fold<double>(
      1,
      (current, item) => current > item.value ? current : item.value,
    );

    return SizedBox(
      height: 190,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(metrics.length, (index) {
          final metric = metrics[index];
          final color = colors[index % colors.length];
          final barHeight = maxValue == 0 ? 0.0 : (metric.value / maxValue) * 110;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    metric.value % 1 == 0
                        ? metric.value.toInt().toString()
                        : metric.value.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColor.textSlate,
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: barHeight + 12,
                decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [color.withValues(alpha: 0.55), color],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.18),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    metric.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.textSlate,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class DonutBreakdown extends StatelessWidget {
  const DonutBreakdown({
    super.key,
    required this.ratio,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final RatioMetric ratio;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    final total = ratio.primaryValue + ratio.secondaryValue;
    final progress = total == 0 ? 0.0 : ratio.primaryValue / total;

    return Column(
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 16,
                  color: secondaryColor,
                ),
              ),
              SizedBox(
                width: 130,
                height: 130,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 16,
                  color: primaryColor,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(progress * 100).round()}%',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Text(
                    ratio.primaryLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _LegendStat(
                label: ratio.primaryLabel,
                value: ratio.primaryValue.toStringAsFixed(0),
                color: primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _LegendStat(
                label: ratio.secondaryLabel,
                value: ratio.secondaryValue.toStringAsFixed(0),
                color: secondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColor.textSlate,
              ),
        ),
      ],
    );
  }
}

class _LegendStat extends StatelessWidget {
  const _LegendStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.sectionBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColor.textSlate,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
