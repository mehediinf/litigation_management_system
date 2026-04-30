import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/router/app_router.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/settings/presentation/views/change_password_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.panelBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            children: [
              _HeaderIcon(
                icon: Icons.logout_rounded,
                backgroundColor: AppColor.errorSoftBg,
                iconColor: AppColor.error,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColor.textDeepBlue,
                      ),
                ),
              ),
            ],
          ),
          content: Text(
            'Do you want to sign out from the BARC Bank LMS session on this device?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textSecondary,
                  height: 1.5,
                ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColor.dynamicAppBarIcon,
                side: const BorderSide(color: AppColor.outlineBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColor.error,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.logout_rounded, size: 18),
              label: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true && mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouter.splash,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColor.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColor.divider,
            height: 1,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _SettingsHeroCard(
            title: 'LMS Settings',
            subtitle:
                'Security and operational preferences for your BARC Bank LMS session.',
          ),
          const SizedBox(height: 14),
          _SettingsActionTile(
            icon: Icons.lock_reset_outlined,
            title: 'Change Password',
            subtitle: 'Update your current login password',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ChangePasswordScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 10),
          _SettingsActionTile(
            icon: Icons.logout_rounded,
            title: 'Logout',
            subtitle: 'End current device session',
            destructive: true,
            onTap: _showLogoutDialog,
          ),

          const SizedBox(height: 10),
          const _SettingsInfoCard(
            icon: Icons.info_outline_rounded,
            title: 'About LMS',
            rows: [
              _InfoRow(label: 'Application', value: 'BARC Bank LMS'),
              _InfoRow(label: 'Version', value: '1.0.0+1'),
              _InfoRow(label: 'Scope', value: 'Legal workflow and operational tracking'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsHeroCard extends StatelessWidget {
  const _SettingsHeroCard({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColor.drawerGradientStart,
            AppColor.drawerGradientMiddle,
            AppColor.drawerGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColor.drawerHeroShadowColor,
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColor.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.settings_outlined,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.white.withValues(alpha: 0.88),
                  height: 1.45,
                ),
          ),
        ],
      ),
    );
  }
}

class _SettingsActionTile extends StatelessWidget {
  const _SettingsActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: destructive ? AppColor.error.withValues(alpha: 0.14) : AppColor.borderSoft,
        ),
        boxShadow: AppColor.elevatedShadow,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _HeaderIcon(
          icon: icon,
          backgroundColor: destructive ? AppColor.errorSoftBg : AppColor.sectionBgBlue,
          iconColor: destructive ? AppColor.error : AppColor.primary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: destructive ? AppColor.error : AppColor.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColor.textSecondary,
                height: 1.4,
              ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: destructive ? AppColor.error : AppColor.textMuted,
        ),
        onTap: onTap,
      ),
    );
  }
}

class _SettingsInfoCard extends StatelessWidget {
  const _SettingsInfoCard({
    required this.icon,
    required this.title,
    required this.rows,
  });

  final IconData icon;
  final String title;
  final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.borderSoft),
        boxShadow: AppColor.elevatedShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _HeaderIcon(
                  icon: icon,
                  backgroundColor: AppColor.sectionBgBlue,
                  iconColor: AppColor.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...rows.asMap().entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(bottom: entry.key == rows.length - 1 ? 0 : 10),
                child: _InfoRowLine(item: entry.value),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _InfoRowLine extends StatelessWidget {
  const _InfoRowLine({required this.item});

  final _InfoRow item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.sectionBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.fieldBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(
              item.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColor.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}

class _InfoRow {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}
