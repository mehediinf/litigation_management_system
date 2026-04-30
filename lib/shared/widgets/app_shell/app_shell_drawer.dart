import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

class DrawerDestinationItem {
  const DrawerDestinationItem({
    required this.title,
    required this.icon,
    this.subtitle,
    this.isDestructive = false,
  });

  final String title;
  final IconData icon;
  final String? subtitle;
  final bool isDestructive;
}

class DrawerMenuNode {
  const DrawerMenuNode({
    required this.title,
    this.icon = Icons.circle_outlined,
    this.children = const <DrawerMenuNode>[],
  });

  final String title;
  final IconData icon;
  final List<DrawerMenuNode> children;

  bool get hasChildren => children.isNotEmpty;
}

class AppShellDrawer extends StatelessWidget {
  const AppShellDrawer({
    super.key,
    required this.items,
    required this.menuSections,
    required this.appVersion,
    required this.onMenuTap,
  });

  final List<DrawerDestinationItem> items;
  final List<DrawerMenuNode> menuSections;
  final String appVersion;
  final ValueChanged<String> onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.drawerBg,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [
                    AppColor.drawerGradientStart,
                    AppColor.drawerGradientMiddle,
                    AppColor.drawerGradientEnd,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.drawerHeroShadowColor,
                    blurRadius: 28,
                    offset: Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColor.white.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: AppColor.white.withValues(alpha: 0.18),
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/lms_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'User Name',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Litigation Management',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Smart access to Legal Team and Head Office modules with a cleaner operational layout.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.white.withValues(alpha: 0.88),
                          height: 1.55,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                children: [
                  ...menuSections.map(
                    (section) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _DrawerTreeTile(
                        node: section,
                        level: 0,
                        onLeafTap: onMenuTap,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(
                      'Quick Access',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColor.textSlate,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                    ),
                  ),
                  ...List.generate(items.length, (index) {
                    final item = items[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        tileColor: AppColor.white,
                        leading: Icon(
                          item.icon,
                          color: item.isDestructive
                              ? AppColor.error
                              : AppColor.primary,
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: item.isDestructive
                                ? AppColor.error
                                : AppColor.textPrimary,
                          ),
                        ),
                        subtitle: item.subtitle == null
                            ? null
                            : Text(
                                item.subtitle!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColor.textSecondary,
                                    ),
                              ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: AppColor.textMuted,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          onMenuTap(item.title);
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColor.borderSoft),
                boxShadow: AppColor.elevatedShadow,
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColor.drawerInfoBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.info_outline_rounded,
                      size: 20,
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'App Version',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColor.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          appVersion,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: AppColor.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTreeTile extends StatelessWidget {
  const _DrawerTreeTile({
    required this.node,
    required this.level,
    required this.onLeafTap,
  });

  final DrawerMenuNode node;
  final int level;
  final ValueChanged<String> onLeafTap;

  @override
  Widget build(BuildContext context) {
    if (!node.hasChildren) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.drawerCardBorder),
        ),
        child: ListTile(
          dense: true,
          minLeadingWidth: 20,
          contentPadding: EdgeInsets.only(
            left: 18 + (level * 18),
            right: 12,
          ),
          leading: Icon(
            level == 0 ? node.icon : Icons.arrow_right_rounded,
            size: level == 0 ? 20 : 18,
            color: AppColor.textSecondary,
          ),
          title: Text(
            node.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textDark,
                  fontWeight: FontWeight.w500,
                ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            onLeafTap(node.title);
          },
        ),
      );
    }

    final isPrimarySection = level == 0;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(isPrimarySection ? 24 : 20),
        border: Border.all(
          color: isPrimarySection
              ? AppColor.drawerPrimaryBorder
              : AppColor.drawerCardBorder,
        ),
        boxShadow: AppColor.elevatedShadow,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: AppColor.transparent),
        child: ExpansionTile(
          key: PageStorageKey<String>('${node.title}_$level'),
          tilePadding: EdgeInsets.only(
            left: 16 + (level * 8),
            right: 14,
          ),
          childrenPadding: EdgeInsets.only(
            left: isPrimarySection ? 0 : 4,
            right: 6,
            bottom: 10,
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isPrimarySection ? 24 : 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isPrimarySection ? 24 : 20),
          ),
          iconColor: AppColor.primary,
          collapsedIconColor: AppColor.textSecondary,
          initiallyExpanded: false,
          leading: Icon(
            node.icon,
            color: isPrimarySection
                ? AppColor.primary
                : AppColor.textSecondary,
          ),
          title: Text(
            node.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight:
                      isPrimarySection ? FontWeight.w700 : FontWeight.w600,
                ),
          ),
          children: node.children
              .map(
                (child) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: _DrawerTreeTile(
                    node: child,
                    level: level + 1,
                    onLeafTap: onLeafTap,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
