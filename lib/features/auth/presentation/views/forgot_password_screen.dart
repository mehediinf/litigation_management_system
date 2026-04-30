import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/router/app_router.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/auth/presentation/views/reset_password_screen.dart';
import 'package:litigation_management_system/features/auth/presentation/widgets/auth_flow_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return AuthFlowScaffold(
      title: 'Password Recovery',
      subtitle:
          'Verification completed. Continue to create a new password for your LMS access.',
      icon: Icons.lock_reset_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColor.sectionBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColor.fieldBorder),
            ),
            child: Text(
              'LMS User ID: $userId',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Your verification step is complete. In the live LMS environment, the next step will securely submit the new password to the backend service.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textSecondary,
                  height: 1.55,
                ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (_) => ResetPasswordScreen(userId: userId),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: const Text('Create New Password'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouter.home,
                  (route) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColor.dynamicAppBarIcon,
                side: const BorderSide(color: AppColor.outlineBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Skip for Demo'),
            ),
          ),
        ],
      ),
    );
  }
}
