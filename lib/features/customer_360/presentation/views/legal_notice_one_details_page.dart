//lib/features/customer_360/presentation/views/legal_notice_one_details_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class LegalNoticeOneDetailsPage extends StatefulWidget {
  const LegalNoticeOneDetailsPage({super.key});

  @override
  State<LegalNoticeOneDetailsPage> createState() =>
      _LegalNoticeOneDetailsPageState();
}

class _LegalNoticeOneDetailsPageState extends State<LegalNoticeOneDetailsPage> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return Customer360Scaffold(
      title: '1st Legal Notice Details',
      enableSearch: true,
      searchHintText: 'Search 1st legal notice',
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(
              title: 'Key Information',
              onTap: () => setState(() => _isCollapsed = !_isCollapsed),
              isCollapsed: _isCollapsed,
            ),
          ),
          if (!_isCollapsed)
            const SliverToBoxAdapter(
              child: FieldGroupCard(
                fields: [
                  FieldItem(label: 'Status', value: 'Available for mapping'),
                  FieldItem(label: 'Notice Type', value: '1st Legal Notice'),
                  FieldItem(label: 'Reference', value: 'Customer-level section'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
