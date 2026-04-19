import 'package:litigation_management_system/core/utils/result.dart';
import 'package:litigation_management_system/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:litigation_management_system/features/dashboard/data/models/dashboard_summary_model.dart';
import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:litigation_management_system/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl(this._dataSource);

  final DashboardLocalDataSource _dataSource;

  @override
  Future<Result<DashboardSummary>> getSummary() async {
    try {
      final data = await _dataSource.fetchSummary();
      final summary = DashboardSummaryModel.fromMap(data);
      return Success<DashboardSummary>(summary);
    } catch (_) {
      return const Failure<DashboardSummary>(
        'Unable to load banking dashboard.',
      );
    }
  }
}
