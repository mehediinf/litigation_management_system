//lib/features/settings/presentation/views/change_password_screen.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/router/app_router.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/settings/presentation/viewmodels/change_password_viewmodel.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
    this.forcePasswordChange = false,
    this.expiryMessage,
  });

  final bool forcePasswordChange;
  final String? expiryMessage;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordViewModel _viewModel = ChangePasswordViewModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _hasTypedCurrent = false;
  bool _hasTypedNew = false;
  bool _hasTypedConfirm = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(_onFormChanged);
    _newPasswordController.addListener(_onFormChanged);
    _confirmPasswordController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    _currentPasswordController
      ..removeListener(_onFormChanged)
      ..dispose();
    _newPasswordController
      ..removeListener(_onFormChanged)
      ..dispose();
    _confirmPasswordController
      ..removeListener(_onFormChanged)
      ..dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    final nextHasTypedCurrent = _currentPasswordController.text.isNotEmpty;
    final nextHasTypedNew = _newPasswordController.text.isNotEmpty;
    final nextHasTypedConfirm = _confirmPasswordController.text.isNotEmpty;

    if (nextHasTypedCurrent != _hasTypedCurrent ||
        nextHasTypedNew != _hasTypedNew ||
        nextHasTypedConfirm != _hasTypedConfirm) {
      setState(() {
        _hasTypedCurrent = nextHasTypedCurrent;
        _hasTypedNew = nextHasTypedNew;
        _hasTypedConfirm = nextHasTypedConfirm;
      });
    } else {
      setState(() {});
    }
  }

  String get _currentPassword => _currentPasswordController.text;
  String get _newPassword => _newPasswordController.text;
  String get _confirmPassword => _confirmPasswordController.text;

  bool get _hasMinLength => _newPassword.length >= 8;
  bool get _hasUppercase => RegExp(r'[A-Z]').hasMatch(_newPassword);
  bool get _hasLowercase => RegExp(r'[a-z]').hasMatch(_newPassword);
  bool get _hasNumber => RegExp(r'[0-9]').hasMatch(_newPassword);
  bool get _hasSpecialChar =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(_newPassword);
  bool get _isDifferentFromCurrent =>
      _newPassword.isNotEmpty && _newPassword != _currentPassword;
  bool get _passwordsMatch =>
      _confirmPassword.isNotEmpty && _confirmPassword == _newPassword;

  bool get _isReadyToSubmit =>
      _currentPassword.trim().isNotEmpty &&
      _hasMinLength &&
      _hasUppercase &&
      _hasLowercase &&
      _hasNumber &&
      _hasSpecialChar &&
      _isDifferentFromCurrent &&
      _passwordsMatch;

  String? _validateCurrentPassword(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Enter your current password.';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Enter a new password.';
    }
    if (!_hasMinLength) {
      return 'Use at least 8 characters.';
    }
    if (!_hasUppercase) {
      return 'Add at least one uppercase letter.';
    }
    if (!_hasLowercase) {
      return 'Add at least one lowercase letter.';
    }
    if (!_hasNumber) {
      return 'Add at least one number.';
    }
    if (!_hasSpecialChar) {
      return 'Add at least one special character.';
    }
    if (!_isDifferentFromCurrent) {
      return 'New password must be different from current password.';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Confirm the new password.';
    }
    if (!_passwordsMatch) {
      return 'Passwords do not match.';
    }
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await _viewModel.changePassword(
      currentPassword: _currentPassword,
      newPassword: _newPassword,
    );

    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColor.error,
          content: Text(
            _viewModel.errorMessage ?? 'Unable to change password.',
          ),
        ),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.panelBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColor.successBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColor.successText,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Password Updated',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColor.textDeepBlue,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          content: Text(
            'The LMS password update flow is ready. Once the API is connected, this screen can submit the actual password change request.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textSecondary,
                  height: 1.5,
                ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (widget.forcePasswordChange) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRouter.home, (route) => false);
      return;
    }

    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColor.textPrimary,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        );

    return WillPopScope(
      onWillPop: () async => !widget.forcePasswordChange,
      child: Scaffold(
        backgroundColor: AppColor.drawerBg,
        appBar: AppBar(
          automaticallyImplyLeading: !widget.forcePasswordChange,
          backgroundColor: AppColor.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          title: Text('Change Password', style: titleStyle),
        ),
        body: SafeArea(
          child: AnimatedBuilder(
            animation: _viewModel,
            builder: (context, _) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  _PasswordHeroCard(
                    forcePasswordChange: widget.forcePasswordChange,
                    expiryMessage: widget.expiryMessage,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColor.panelBorder),
                      boxShadow: AppColor.elevatedShadow,
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _PasswordField(
                            controller: _currentPasswordController,
                            label: 'Current Password',
                            hintText: 'Enter current password',
                            obscureText: _obscureCurrent,
                            validator:
                                _hasTypedCurrent ? _validateCurrentPassword : null,
                            onToggle: () => setState(
                              () => _obscureCurrent = !_obscureCurrent,
                            ),
                          ),
                          const SizedBox(height: 14),
                          _PasswordField(
                            controller: _newPasswordController,
                            label: 'New Password',
                            hintText: 'Enter new password',
                            obscureText: _obscureNew,
                            validator:
                                _hasTypedNew ? _validateNewPassword : null,
                            onToggle: () =>
                                setState(() => _obscureNew = !_obscureNew),
                          ),
                          const SizedBox(height: 14),
                          _PasswordField(
                            controller: _confirmPasswordController,
                            label: 'Confirm Password',
                            hintText: 'Re-enter new password',
                            obscureText: _obscureConfirm,
                            validator: _hasTypedConfirm
                                ? _validateConfirmPassword
                                : null,
                            onToggle: () => setState(
                              () => _obscureConfirm = !_obscureConfirm,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _LiveValidationCard(
                            hasMinLength: _hasMinLength,
                            hasUppercase: _hasUppercase,
                            hasLowercase: _hasLowercase,
                            hasNumber: _hasNumber,
                            hasSpecialChar: _hasSpecialChar,
                            isDifferentFromCurrent: _isDifferentFromCurrent,
                            passwordsMatch: _confirmPassword.isEmpty
                                ? null
                                : _passwordsMatch,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: FilledButton(
                              onPressed: _viewModel.isLoading || !_isReadyToSubmit
                                  ? null
                                  : _submit,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColor.primary,
                                foregroundColor: AppColor.white,
                                disabledBackgroundColor:
                                    AppColor.primary.withValues(alpha: 0.35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: _viewModel.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColor.white,
                                        strokeWidth: 2.2,
                                      ),
                                    )
                                  : const Text(
                                      'Update Password',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PasswordHeroCard extends StatelessWidget {
  const _PasswordHeroCard({
    required this.forcePasswordChange,
    required this.expiryMessage,
  });

  final bool forcePasswordChange;
  final String? expiryMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColor.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.lock_reset_rounded,
                  color: AppColor.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  forcePasswordChange
                      ? 'Password Renewal Required'
                      : 'Password Security',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Protect legal workflow access and operational case visibility with a stronger password.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.white.withValues(alpha: 0.9),
                  height: 1.5,
                ),
          ),
          if ((expiryMessage ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColor.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColor.white.withValues(alpha: 0.22),
                ),
              ),
              child: Text(
                expiryMessage!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColor.white,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LiveValidationCard extends StatelessWidget {
  const _LiveValidationCard({
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasNumber,
    required this.hasSpecialChar,
    required this.isDifferentFromCurrent,
    required this.passwordsMatch,
  });

  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasNumber;
  final bool hasSpecialChar;
  final bool isDifferentFromCurrent;
  final bool? passwordsMatch;

  @override
  Widget build(BuildContext context) {
    final showMatch = passwordsMatch == false;
    final anyRequirementLeft = !hasMinLength ||
        !hasUppercase ||
        !hasLowercase ||
        !hasNumber ||
        !hasSpecialChar ||
        !isDifferentFromCurrent ||
        showMatch;

    if (!anyRequirementLeft) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            'Remaining Requirements',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColor.textSteel,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            if (!hasMinLength) const _RuleText(label: 'Minimum 8 chars'),
            if (!hasUppercase) const _RuleText(label: 'Uppercase letter'),
            if (!hasLowercase) const _RuleText(label: 'Lowercase letter'),
            if (!hasNumber) const _RuleText(label: 'One number'),
            if (!hasSpecialChar) const _RuleText(label: 'Special character'),
            if (!isDifferentFromCurrent) const _RuleText(label: 'Must be different'),
            if (showMatch) const _RuleText(label: 'Passwords must match'),
          ],
        ),
      ],
    );
  }
}

class _RuleText extends StatelessWidget {
  const _RuleText({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.info_outline_rounded, size: 13, color: AppColor.error),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: AppColor.error,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.obscureText,
    required this.onToggle,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;

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
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              color: AppColor.primary,
            ),
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColor.textSecondary,
              ),
            ),
            filled: true,
            fillColor: AppColor.sectionBg,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColor.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColor.error, width: 1.3),
            ),
          ),
        ),
      ],
    );
  }
}
