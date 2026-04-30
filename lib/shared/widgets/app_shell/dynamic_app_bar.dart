import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

class DynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DynamicAppBar({
    super.key,
    required this.title,
    this.actions,
    this.titleContent,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? titleContent;

  @override
  Size get preferredSize => const Size.fromHeight(66);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 66,
      backgroundColor: AppColor.dynamicAppBarBg,
      surfaceTintColor: AppColor.transparent,
      shadowColor: AppColor.dynamicAppBarShadowColor,
      elevation: 1,
      shape: const Border(
        bottom: BorderSide(
          color: AppColor.dynamicAppBarBorder,
          width: 1,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColor.dynamicAppBarIcon,
        size: 22,
      ),
      actionsIconTheme: const IconThemeData(
        color: AppColor.dynamicAppBarIcon,
        size: 22,
      ),
      titleSpacing: 0,
      title: titleContent ??
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColor.dynamicAppBarLogoBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.dynamicAppBarLogoBorder),
                  boxShadow: AppColor.dynamicAppBarShadow,
                ),
                child: Image.asset(
                  'assets/images/lms_logo1.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            color: AppColor.dynamicAppBarTitle,
                          ),
                    ),
                    Text(
                      'BRAC Bank Litigation',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            color: AppColor.dynamicAppBarSubtitle,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      actions: [
        if (actions != null) ...actions!,
      ],
    );
  }
}
