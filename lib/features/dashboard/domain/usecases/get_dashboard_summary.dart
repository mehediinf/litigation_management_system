import 'package:litigation_management_system/core/utils/result.dart';
import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:litigation_management_system/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardSummary {
  const GetDashboardSummary(this._repository);

  final DashboardRepository _repository;

  Future<Result<DashboardSummary>> call({String? month, String? year}) {
    return _repository.getSummary(month: month, year: year);
  }
}
