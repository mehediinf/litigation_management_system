
import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/views/auction_details_page.dart';
import 'package:litigation_management_system/features/customer_360/presentation/views/cma_details_page.dart';
import 'package:litigation_management_system/features/customer_360/presentation/views/document_attachment_page.dart';
import 'package:litigation_management_system/features/customer_360/presentation/views/final_legal_notice_page.dart';
import 'package:litigation_management_system/features/customer_360/presentation/views/legal_notice_one_details_page.dart';
import 'package:litigation_management_system/features/customer_360/presentation/views/other_information_page.dart';
import 'package:litigation_management_system/features/customer_360/presentation/views/suit_filing_page.dart';
import 'package:litigation_management_system/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:litigation_management_system/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:litigation_management_system/features/dashboard/domain/usecases/get_dashboard_summary.dart';
import 'package:litigation_management_system/features/dashboard/presentation/viewmodels/dashboard_view_model.dart';
import 'package:litigation_management_system/features/dashboard/presentation/views/dashboard_page.dart';
import 'package:litigation_management_system/features/home/presentation/views/home_page.dart';
import 'package:litigation_management_system/features/head_office/case_details/presentation/views/hc_ad_case_details.dart';
import 'package:litigation_management_system/features/head_office/case_details/presentation/views/legal_advisory_case_details.dart';
import 'package:litigation_management_system/features/head_office/case_details/presentation/views/lower_court_case_details.dart';
import 'package:litigation_management_system/features/settings/presentation/views/settings_placeholder.dart';
import 'package:litigation_management_system/features/splash/presentation/views/splash_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String legalNoticeOne = '/customer_360/legal_notice_1';
  static const String cmaDetails = '/customer_360/cma';
  static const String auctionDetails = '/customer_360/auction';
  static const String finalLegalNotice = '/customer_360/legal_notice_final';
  static const String suitFiling = '/customer_360/suit_filing';
  static const String documents = '/customer_360/documents';
  static const String otherInfo = '/customer_360/other';
  static const String settings = '/settings';
  static const String lowerCourtCaseDetails = '/head_office/case_details/lower_court';
  static const String legalAdvisoryCaseDetails = '/head_office/case_details/legal_advisory';
  static const String hcAdCaseDetails = '/head_office/case_details/hc_ad';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute<void>(
          builder: (_) => const SplashPage(),
        );
      case legalNoticeOne:
        return MaterialPageRoute<void>(
          builder: (_) => const LegalNoticeOneDetailsPage(),
        );
      case cmaDetails:
        return MaterialPageRoute<void>(
          builder: (_) => const CMADetailsPage(),
        );
      case auctionDetails:
        return MaterialPageRoute<void>(
          builder: (_) => const AuctionDetailsPage(),
        );
      case finalLegalNotice:
        return MaterialPageRoute<void>(
          builder: (_) => const FinalLegalNoticePage(),
        );
      case suitFiling:
        return MaterialPageRoute<void>(
          builder: (_) => const SuitFilingPage(),
        );
      case documents:
        return MaterialPageRoute<void>(
          builder: (_) => const DocumentAttachmentPage(),
        );
      case otherInfo:
        return MaterialPageRoute<void>(
          builder: (_) => const OtherInformationPage(),
        );
      case settings:
        return MaterialPageRoute<void>(
          builder: (_) => const SettingsPage(),
        );
      case lowerCourtCaseDetails:
        return MaterialPageRoute<void>(
          builder: (_) => const LowerCourtCaseDetailsPage(),
        );
      case legalAdvisoryCaseDetails:
        return MaterialPageRoute<void>(
          builder: (_) => const LegalAdvisoryCaseDetailsPage(),
        );
      case hcAdCaseDetails:
        return MaterialPageRoute<void>(
          builder: (_) => const HcAdCaseDetailsPage(),
        );
      case home:
      case dashboard:
        final dataSource = DashboardLocalDataSource();
        final repository = DashboardRepositoryImpl(dataSource);
        final getDashboardSummary = GetDashboardSummary(repository);
        final viewModel = DashboardViewModel(getDashboardSummary);

        return MaterialPageRoute<void>(
          builder: (_) => routeSettings.name == dashboard
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
