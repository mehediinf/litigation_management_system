import 'package:litigation_management_system/core/utils/result.dart';
import 'package:litigation_management_system/core/viewmodels/base_view_model.dart';
import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:litigation_management_system/features/dashboard/domain/usecases/get_dashboard_summary.dart';

class DashboardViewModel extends BaseViewModel {
  DashboardViewModel(this._getDashboardSummary);

  final GetDashboardSummary _getDashboardSummary;

  DashboardSummary? _summary;

  DashboardSummary? get summary => _summary;

  int _currentMonthIndex = 3; // April
  int _currentYear = 2026;
  int? _selectedDay;

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  List<String> get monthList => _months;
  int? get selectedDay => _selectedDay;

  Future<void> initialize({bool silent = false}) async {
    if (!silent) setLoading();

    final result = await _getDashboardSummary(
      month: _months[_currentMonthIndex],
      year: _currentYear.toString(),
    );

    switch (result) {
      case Success<DashboardSummary>():
        _summary = result.data;
        setSuccess();
      case Failure<DashboardSummary>():
        setError(result.message);
    }
  }

  void selectDay(int day) {
    _selectedDay = day;
    notifyListeners();
  }

  int get currentMonthIndex => _currentMonthIndex;

  int get currentYear => _currentYear;

  Future<void> updateDate(DateTime date) async {
    _currentMonthIndex = date.month - 1;
    _currentYear = date.year;
    await initialize(silent: true);
  }

  Future<void> setMonth(int index) async {
    _currentMonthIndex = index;
    await initialize(silent: true);
  }

  Future<void> setYear(int year) async {
    _currentYear = year;
    await initialize(silent: true);
  }

  Future<void> nextMonth() async {
    if (_currentMonthIndex == 11) {
      _currentMonthIndex = 0;
      _currentYear++;
    } else {
      _currentMonthIndex++;
    }
    await initialize(silent: true);
  }

  Future<void> previousMonth() async {
    if (_currentMonthIndex == 0) {
      _currentMonthIndex = 11;
      _currentYear--;
    } else {
      _currentMonthIndex--;
    }
    await initialize(silent: true);
  }
}
