import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:litigation_management_system/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:litigation_management_system/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:litigation_management_system/features/dashboard/presentation/viewmodels/dashboard_view_model.dart';
import 'package:litigation_management_system/features/dashboard/presentation/views/dashboard_page.dart';
import 'package:litigation_management_system/features/home/presentation/views/home_page.dart';
import 'package:litigation_management_system/features/splash/presentation/views/splash_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String dashboard = '/dashboard';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute<void>(
          builder: (_) => const SplashPage(),
        );
      case home:
      case dashboard:
        final dataSource = DashboardLocalDataSource();
        final repository = DashboardRepositoryImpl(dataSource);
        final getDashboardSummary = GetDashboardSummary(repository);
        final viewModel = DashboardViewModel(getDashboardSummary);

        return MaterialPageRoute<void>(
          builder: (_) => settings.name == dashboard
              ? DashboardPage(viewModel: viewModel)
              : HomePage(dashboardViewModel: viewModel),
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
