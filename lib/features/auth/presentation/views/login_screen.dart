import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/router/app_router.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:litigation_management_system/features/auth/presentation/views/send_otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _viewModel = LoginViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? AppColor.error : AppColor.successText,
        content: Text(message),
      ),
    );
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    final success = await _viewModel.login();
    if (!mounted) return;

    if (success) {
      _showMessage('Demo sign-in successful. LMS dashboard is ready.');
      Navigator.of(context).pushReplacementNamed(AppRouter.home);
      return;
    }

    _showMessage(
      _viewModel.errorMessage ?? 'Unable to sign in right now.',
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isCompact = size.width < 640;

    return Scaffold(
      backgroundColor: AppColor.drawerBg,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _viewModel,
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    isCompact ? 20 : 32,
                    20,
                    isCompact ? 20 : 32,
                    24,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 44,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _AuthHero(
                            title: 'BARC Bank LMS',
                            subtitle:
                                'Secure access for legal operations, case workflow tracking, and head office monitoring.',
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(color: AppColor.panelBorder),
                                boxShadow: AppColor.overlayShadowList,
                              ),
                              child: Form(
                                key: _viewModel.formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sign In',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            color: AppColor.textDeepBlue,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Use your LMS user ID and password to continue.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppColor.textSecondary,
                                            height: 1.5,
                                          ),
                                    ),
                                    const SizedBox(height: 24),
                                    _AuthTextField(
                                      controller: _viewModel.userIdController,
                                      label: 'LMS User ID',
                                      hintText: 'Enter your user ID',
                                      prefixIcon: Icons.person_outline_rounded,
                                      validator: _viewModel.validateUserId,
                                      enabled: !_viewModel.isLoading,
                                    ),
                                    const SizedBox(height: 16),
                                    _AuthTextField(
                                      controller: _viewModel.passwordController,
                                      label: 'Password',
                                      hintText: 'Enter your password',
                                      prefixIcon: Icons.lock_outline_rounded,
                                      obscureText: _viewModel.obscurePassword,
                                      validator: _viewModel.validatePassword,
                                      enabled: !_viewModel.isLoading,
                                      suffix: IconButton(
                                        onPressed: _viewModel.isLoading
                                            ? null
                                            : _viewModel.togglePasswordVisibility,
                                        icon: Icon(
                                          _viewModel.obscurePassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: AppColor.textSecondary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 6,
                                      children: [
                                        _InlineAction(
                                          label: 'Forgot Password?',
                                          onTap: _viewModel.isLoading
                                              ? null
                                              : () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute<void>(
                                                      builder: (_) =>
                                                          const SendOtpScreen(
                                                        flow:
                                                            AuthOtpFlow.forgotPassword,
                                                      ),
                                                    ),
                                                  );
                                                },
                                        ),
                                        _InlineAction(
                                          label: 'Unlock Account',
                                          accent: true,
                                          onTap: _viewModel.isLoading
                                              ? null
                                              : () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute<void>(
                                                      builder: (_) =>
                                                          const SendOtpScreen(
                                                        flow:
                                                            AuthOtpFlow.unlockAccount,
                                                      ),
                                                    ),
                                                  );
                                                },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: FilledButton(
                                        onPressed: _viewModel.isLoading
                                            ? null
                                            : _handleLogin,
                                        style: FilledButton.styleFrom(
                                          backgroundColor: AppColor.primary,
                                          foregroundColor: AppColor.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: _viewModel.isLoading
                                            ? const SizedBox(
                                                width: 22,
                                                height: 22,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColor.white,
                                                  strokeWidth: 2.4,
                                                ),
                                              )
                                            : const Text(
                                                'Access LMS',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                ),
                                              ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: AppColor.sectionBg,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: AppColor.fieldBorder,
                                        ),
                                      ),
                                      child: Text(
                                        'API integration is pending. This sign-in flow is prepared for future LMS authentication services.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColor.textSecondary,
                                              height: 1.5,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AuthHero extends StatelessWidget {
  const _AuthHero({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
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
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColor.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: AppColor.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.white.withValues(alpha: 0.88),
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    this.enabled = true,
    this.obscureText = false,
    this.suffix,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?) validator;
  final bool enabled;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        TextFormField(
          controller: controller,
          validator: validator,
          enabled: enabled,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: AppColor.sectionBg,
            prefixIcon: Icon(prefixIcon, color: AppColor.primary),
            suffixIcon: suffix,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
              borderSide:
                  const BorderSide(color: AppColor.primary, width: 1.3),
            ),
          ),
        ),
      ],
    );
  }
}

class _InlineAction extends StatelessWidget {
  const _InlineAction({
    required this.label,
    required this.onTap,
    this.accent = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: accent ? AppColor.primaryStrong : AppColor.textSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: accent ? FontWeight.w700 : FontWeight.w600,
        ),
      ),
    );
  }
}
