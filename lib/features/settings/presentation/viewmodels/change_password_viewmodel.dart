import 'package:flutter/material.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Placeholder for future LMS change-password API.
      await Future<void>.delayed(const Duration(milliseconds: 800));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (_) {
      _errorMessage =
          'Change password service is not connected yet. Please integrate the LMS API.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
