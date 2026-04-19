import 'package:litigation_management_system/core/utils/result.dart';
import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';

abstract class DashboardRepository {
  Future<Result<DashboardSummary>> getSummary();
}
