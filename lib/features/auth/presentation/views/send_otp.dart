import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/auth/presentation/views/otp_verification_screen.dart';
import 'package:litigation_management_system/features/auth/presentation/widgets/auth_flow_widgets.dart';

enum AuthOtpFlow {
  unlockAccount,
  forgotPassword,
}

class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({
    super.key,
    required this.flow,
  });

  final AuthOtpFlow flow;

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userIdController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  String get _title => widget.flow == AuthOtpFlow.unlockAccount
      ? 'Unlock Account'
      : 'Recover Password';

  String get _subtitle => widget.flow == AuthOtpFlow.unlockAccount
      ? 'Enter your LMS user ID to receive a verification code for account unlock.'
      : 'Enter your LMS user ID to receive a verification code for password reset.';

  String? _validateUserId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your LMS user ID.';
    }
    if (value.trim().length < 4) {
      return 'LMS user ID must be at least 4 characters.';
    }
    return null;
  }

  Future<void> _sendOtp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColor.successText,
        content: const Text(
          'Demo OTP sent. API integration will replace this flow later.',
        ),
      ),
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => OTPVerificationScreen(
          flow: widget.flow,
          userId: _userIdController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthFlowScaffold(
      title: _title,
      subtitle: _subtitle,
      icon: Icons.mark_email_read_outlined,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthFlowTextField(
              controller: _userIdController,
              label: 'LMS User ID',
              hintText: 'Enter your user ID',
              prefixIcon: Icons.person_outline_rounded,
              validator: _validateUserId,
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: _isLoading ? null : _sendOtp,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: AppColor.white,
                          strokeWidth: 2.2,
                        ),
                      )
                    : const Icon(Icons.send_rounded, size: 18),
                label: Text(_isLoading ? 'Sending...' : 'Send Verification Code'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
