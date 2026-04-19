import 'package:litigation_management_system/core/utils/result.dart';
import 'package:litigation_management_system/core/viewmodels/base_view_model.dart';
import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:litigation_management_system/features/dashboard/domain/usecases/get_dashboard_summary.dart';

class DashboardViewModel extends BaseViewModel {
  DashboardViewModel(this._getDashboardSummary);

  final GetDashboardSummary _getDashboardSummary;

  DashboardSummary? _summary;

  DashboardSummary? get summary => _summary;

  Future<void> initialize() async {
    setLoading();

    final result = await _getDashboardSummary();

    switch (result) {
      case Success<DashboardSummary>():
        _summary = result.data;
        setSuccess();
      case Failure<DashboardSummary>():
        setError(result.message);
    }
  }
}
