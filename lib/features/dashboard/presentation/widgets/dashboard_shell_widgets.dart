import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';

class DashboardHeaderSection extends StatelessWidget {
  const DashboardHeaderSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 400;

    return Container(
      padding: EdgeInsets.all(isSmall ? 18 : 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColor.sectionBg,
            AppColor.sectionBgBlue,
            AppColor.sectionBgAlt,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColor.panelBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColor.subtleShadow,
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: _HeaderCopy(
        title: title,
        subtitle: subtitle,
        isSmall: isSmall,
      ),
    );
  }
}

class _HeaderCopy extends StatelessWidget {
  const _HeaderCopy({
    required this.title,
    required this.subtitle,
    required this.isSmall,
  });

  final String title;
  final String subtitle;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: isSmall ? 26 : 30,
                fontWeight: FontWeight.w800,
                color: AppColor.textDeepBlue,
                height: 1.05,
              ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColor.dashboardTextMutedAlt,
                  height: 1.5,
                ),
          ),
        ),
      ],
    );
  }
}

class DashboardSearchDialog extends StatefulWidget {
  const DashboardSearchDialog({super.key});

  @override
  State<DashboardSearchDialog> createState() => _DashboardSearchDialogState();
}

class _DashboardSearchDialogState extends State<DashboardSearchDialog> {
  String? _selectedYear = '2026';
  String? _selectedMonth = 'April';
  String? _selectedDistrict = 'Rec. District';
  String? _selectedRegion = 'Legal Region';
  String? _selectedPortfolio = 'Portfolio';

  static const List<String> _years = ['2024', '2025', '2026', '2027'];
  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  static const List<String> _districts = [
    'Rec. District',
    'Dhaka',
    'Chattogram',
    'Khulna',
    'Rajshahi',
  ];
  static const List<String> _regions = [
    'Legal Region',
    'North',
    'South',
    'Central',
    'Metro',
  ];
  static const List<String> _portfolios = [
    'Portfolio',
    'Retail',
    'SME',
    'Corporate',
    'Recovery',
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 760;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      backgroundColor: AppColor.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 720),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColor.panelBg,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColor.panelBorder),
          boxShadow: AppColor.overlayShadowList,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColor.cardGradientStart,
                          AppColor.cardGradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.search_rounded,
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search Filters',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColor.textDeepBlue,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _SearchDropdownField(
                    width: isWide ? 320 : double.infinity,
                    label: 'Year',
                    value: _selectedYear,
                    items: _years,
                    onChanged: (value) => setState(() => _selectedYear = value),
                  ),
                  _SearchDropdownField(
                    width: isWide ? 320 : double.infinity,
                    label: 'Month',
                    value: _selectedMonth,
                    items: _months,
                    onChanged: (value) => setState(() => _selectedMonth = value),
                  ),
                  _SearchDropdownField(
                    width: isWide ? 320 : double.infinity,
                    label: 'District',
                    value: _selectedDistrict,
                    items: _districts,
                    onChanged: (value) =>
                        setState(() => _selectedDistrict = value),
                  ),
                  _SearchDropdownField(
                    width: isWide ? 320 : double.infinity,
                    label: 'Region',
                    value: _selectedRegion,
                    items: _regions,
                    onChanged: (value) => setState(() => _selectedRegion = value),
                  ),
                  _SearchDropdownField(
                    width: isWide ? 320 : double.infinity,
                    label: 'Portfolio',
                    value: _selectedPortfolio,
                    items: _portfolios,
                    onChanged: (value) =>
                        setState(() => _selectedPortfolio = value),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _selectedYear = _years[2];
                          _selectedMonth = _months[3];
                          _selectedDistrict = _districts[0];
                          _selectedRegion = _regions[0];
                          _selectedPortfolio = _portfolios[0];
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColor.dynamicAppBarIcon,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColor.outlineBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.search_rounded, size: 18),
                      label: const Text('Apply Filters'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        foregroundColor: AppColor.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchDropdownField extends StatelessWidget {
  const _SearchDropdownField({
    required this.width,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final double width;
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColor.textSteel,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.sectionBg,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColor.fieldBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColor.fieldBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColor.primary,
                  width: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardHeroSummary extends StatelessWidget {
  const DashboardHeroSummary({
    super.key,
    required this.summary,
  });

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColor.drawerGradientStart,
            AppColor.primary,
            AppColor.dashboardHeroEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: AppColor.primaryShadow,
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total monitored cases',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.white70,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '${summary.liveCaseInformation.last.value.toInt()}',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _HeroPill(
                  label: 'Pending update',
                  value: summary.caseUpdateInformation[1].value.toInt().toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _HeroPill(
                  label: 'Pending warrant',
                  value:
                      '${summary.warrantProcess.primaryValue.toStringAsFixed(0)}%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.white70,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class DashboardSectionTitle extends StatelessWidget {
  const DashboardSectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: AppColor.primaryStrong,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppColor.textPrimary,
                            letterSpacing: -0.5,
                          ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardMetricCard extends StatelessWidget {
  const DashboardMetricCard({
    super.key,
    required this.label,
    this.value,
    required this.icon,
    required this.accent,
    this.showValue = true,
    this.onTap,
  });

  final String label;
  final String? value;
  final IconData icon;
  final Color accent;
  final bool showValue;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 190;

        return Container(
          decoration: BoxDecoration(
            color: AppColor.panelBg,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColor.borderSoft.withValues(alpha: 0.8)),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: AppColor.transparent,
            child: InkWell(
              onTap: onTap,
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.03),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(icon, color: accent, size: 22),
                        ),
                        const Spacer(),
                        if (showValue) ...[
                          Text(
                            value ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: isCompact ? 24 : 28,
                                  color: AppColor.textPrimary,
                                  letterSpacing: -1,
                                ),
                          ),
                        ] else ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'GUIDE',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: accent,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 4),
                        Text(
                          label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColor.textSecondary,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DashboardDoubleSection extends StatelessWidget {
  const DashboardDoubleSection({
    super.key,
    required this.left,
    required this.right,
  });

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 700;

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: left),
          const SizedBox(width: 14),
          Expanded(child: right),
        ],
      );
    }

    return Column(
      children: [
        left,
        const SizedBox(height: 14),
        right,
      ],
    );
  }
}

class DashboardPanelCard extends StatelessWidget {
  const DashboardPanelCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.panelBg,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColor.borderSoft.withValues(alpha: 0.7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x060F172A),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primary.withValues(alpha: 0.12),
                        AppColor.primary.withValues(alpha: 0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: AppColor.primaryStrong,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColor.textPrimary,
                          letterSpacing: -0.3,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: child,
          ),
        ],
      ),
    );
  }
}
