import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;
  String? get errorMessage => _errorMessage;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  String? validateUserId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your LMS user ID.';
    }
    if (value.trim().length < 4) {
      return 'LMS user ID must be at least 4 characters.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  Future<bool> login() async {
    _errorMessage = null;

    if (!(formKey.currentState?.validate() ?? false)) {
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Placeholder flow for future LMS API integration.
      await Future<void>.delayed(const Duration(milliseconds: 900));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (_) {
      _errorMessage =
          'Login service is not connected yet. Please try again after API integration.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
