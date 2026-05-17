// lib/features/dashboard/presentation/views/instrument_delivery_status_cases/instrument_delivery_cases_app_bar.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

/// Deep-background app bar for case list & preview screens.
AppBar buildInstrumentDeliveryCasesAppBar(
  BuildContext context, {
  required String title,
  Widget? titleWidget,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
}) {
  final theme = Theme.of(context);
  const titleColor = AppColor.white;

  return AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColor.transparent,
    foregroundColor: titleColor,
    surfaceTintColor: AppColor.transparent,
    shadowColor: AppColor.transparent,
    iconTheme: const IconThemeData(color: titleColor, size: 22),
    actionsIconTheme: const IconThemeData(color: titleColor, size: 22),
    flexibleSpace: Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.splashBgStart,
                AppColor.splashBgMidDark,
                AppColor.splashBgMid,
              ],
              stops: const [0.0, 0.48, 1.0],
            ),
          ),
        ),
      ],
    ),
    title: titleWidget ??
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: titleColor,
            height: 1.2,
            shadows: const [
              Shadow(color: Color(0x40000000), blurRadius: 8, offset: Offset(0, 1)),
            ],
          ),
        ),
    centerTitle: false,
    actions: actions,
    bottom: bottom,
  );
}
