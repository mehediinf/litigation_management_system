import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/auth/presentation/views/forgot_password_screen.dart';
import 'package:litigation_management_system/features/auth/presentation/views/login_screen.dart';
import 'package:litigation_management_system/features/auth/presentation/views/send_otp.dart';
import 'package:litigation_management_system/features/auth/presentation/widgets/auth_flow_widgets.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({
    super.key,
    required this.flow,
    required this.userId,
  });

  final AuthOtpFlow flow;
  final String userId;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  Timer? _timer;
  int _secondsLeft = 120;
  bool _isLoading = false;

  bool get _canResend => _secondsLeft == 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.trim().length != 6) {
      _showMessage('Please enter the 6-digit verification code.', isError: true);
      return;
    }

    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (widget.flow == AuthOtpFlow.forgotPassword) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => ForgotPasswordScreen(userId: widget.userId),
        ),
      );
      return;
    }

    _showMessage('Account unlock request completed for demo flow.');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;
    _showMessage('Demo OTP re-sent successfully.');
    _otpController.clear();
    setState(() {});
    _startTimer();
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

  @override
  Widget build(BuildContext context) {
    final title = widget.flow == AuthOtpFlow.unlockAccount
        ? 'Verify Unlock Code'
        : 'Verify Reset Code';

    final subtitle = widget.flow == AuthOtpFlow.unlockAccount
        ? 'Enter the 6-digit code issued for LMS account unlock.'
        : 'Enter the 6-digit code issued for LMS password recovery.';

    return AuthFlowScaffold(
      title: title,
      subtitle: subtitle,
      icon: Icons.verified_user_outlined,
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
              'LMS User ID: ${widget.userId}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Verification Code',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColor.textSteel,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Enter 6-digit OTP',
              prefixIcon: const Icon(
                Icons.password_rounded,
                color: AppColor.primary,
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
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: _isLoading ? null : _verifyOtp,
              style: FilledButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: AppColor.white,
                        strokeWidth: 2.2,
                      ),
                    )
                  : const Text(
                      'Verify Code',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: TextButton(
              onPressed: _canResend ? _resendOtp : null,
              child: Text(
                _canResend
                    ? 'Resend code'
                    : 'Resend available in ${_secondsLeft}s',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
