import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/head_office/case_details/presentation/views/case_details_common_view.dart';

class LegalAdvisoryCaseDetailsPage extends StatelessWidget {
  const LegalAdvisoryCaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CaseDetailsCommonView(
      pageTitle: 'Legal Advisory Case Details',
      advancedSearchConfig: const CaseDetailsAdvancedSearchConfig(
        caseTitle: 'Legal Advisory Case Details',
        showProposedType: true,
        showNo: false,
        showCif: true,
        showTerritory: false,
      ),
    );
  }
}
