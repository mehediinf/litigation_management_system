import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class LegalNoticeOneDetailsPage extends StatelessWidget {
  const LegalNoticeOneDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Customer360Scaffold(
      title: '1st Legal Notice Details',
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(title: 'Key Information'),
          ),
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
