//lib/features/customer_360/presentation/views/suit_filing_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class SuitFilingPage extends StatefulWidget {
  const SuitFilingPage({super.key});

  @override
  State<SuitFilingPage> createState() => _SuitFilingPageState();
}

class _SuitFilingPageState extends State<SuitFilingPage> {
  final List<bool> _collapsedSections = [false, false, false];

  void _toggleSection(int index) {
    setState(() {
      _collapsedSections[index] = !_collapsedSections[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Customer360Scaffold(
      title: 'Suit Filing Information',
      enableSearch: true,
      searchHintText: 'Search suit filing info',
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          SliverMainAxisGroup(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  title: 'Suit File Info (1)',
                  icon: Icons.description_outlined,
                  onTap: () => _toggleSection(0),
                  isCollapsed: _collapsedSections[0],
                ),
              ),
              if (!_collapsedSections[0])
                const SliverToBoxAdapter(
                  child: FieldGroupCard(
                    fields: [
                      FieldItem(label: 'Case Name', value: 'Artho Jari'),
                      FieldItem(label: 'Case Number', value: 'Artho-83/18', emphasize: true),
                      FieldItem(label: 'Case Claim Amount', value: '845,704.00'),
                      FieldItem(label: 'Previous Date', value: '15-Nov-23'),
                      FieldItem(label: 'Case Status Previous Date', value: 'Warrant Of Arrest'),
                      FieldItem(label: 'Activities Previous Date', value: 'Hazira'),
                      FieldItem(label: 'Next Date', value: '30-Jan-24', emphasize: true),
                      FieldItem(label: 'Case Status Next Date', value: 'Warrant Of Arrest'),
                      FieldItem(label: 'Remarks Next Date', value: 'Warrant Of Arrest'),
                      FieldItem(label: 'Filling Plaintiff', value: 'Kanchan Miah(11276)'),
                      FieldItem(label: 'Filling Date', value: '24-Nov-19'),
                      FieldItem(label: 'Suit File Entry Date', value: ''),
                      FieldItem(label: 'Case Deal Officer', value: 'Kanchan Miah(11276)'),
                      FieldItem(label: 'Previous Lawyer Name', value: ''),
                      FieldItem(label: 'Present Lawyer Name', value: 'ADVOCATE MD. AZHARUL HAQUE'),
                      FieldItem(label: 'Previous Court Name', value: 'Arthorin Adalot'),
                      FieldItem(label: 'Present Court Name', value: 'Arthorin Adalot'),
                      FieldItem(label: 'Suit File Entry By', value: ''),
                      FieldItem(label: 'Arji Copy', value: ''),
                      FieldItem(label: 'Judge Name', value: ''),
                    ],
                  ),
                ),
            ],
          ),

          SliverMainAxisGroup(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  title: 'Suit File Info (2)',
                  icon: Icons.description_outlined,
                  onTap: () => _toggleSection(1),
                  isCollapsed: _collapsedSections[1],
                ),
              ),
              if (!_collapsedSections[1])
                const SliverToBoxAdapter(
                  child: FieldGroupCard(
                    fields: [
                      FieldItem(label: 'Case Name', value: 'Artho Jari'),
                      FieldItem(label: 'Case Number', value: 'Artho-83/18(Jari-68/19)', emphasize: true),
                      FieldItem(label: 'Case Claim Amount', value: '845,704.00'),
                      FieldItem(label: 'Previous Date', value: '15-Nov-23'),
                      FieldItem(label: 'Case Status Previous Date', value: 'Warrant Of Arrest'),
                      FieldItem(label: 'Activities Previous Date', value: 'Hazira'),
                      FieldItem(label: 'Next Date', value: '30-Jan-24', emphasize: true),
                      FieldItem(label: 'Case Status Next Date', value: 'Warrant Of Arrest'),
                      FieldItem(label: 'Remarks Next Date', value: 'Warrant Of Arrest'),
                      FieldItem(label: 'Filling Plaintiff', value: 'Kanchan Miah(11276)'),
                      FieldItem(label: 'Filling Date', value: '24-Nov-19'),
                      FieldItem(label: 'Suit File Entry Date', value: ''),
                      FieldItem(label: 'Case Deal Officer', value: 'Kanchan Miah(11276)'),
                      FieldItem(label: 'Previous Lawyer Name', value: ''),
                      FieldItem(label: 'Present Lawyer Name', value: 'ADVOCATE MD. AZHARUL HAQUE'),
                      FieldItem(label: 'Previous Court Name', value: 'Arthorin Adalot'),
                      FieldItem(label: 'Present Court Name', value: 'Arthorin Adalot'),
                      FieldItem(label: 'Suit File Entry By', value: ''),
                      FieldItem(label: 'Arji Copy', value: ''),
                      FieldItem(label: 'Judge Name', value: ''),
                    ],
                  ),
                ),
            ],
          ),

          SliverMainAxisGroup(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  title: 'Suit File Info (3)',
                  icon: Icons.description_outlined,
                  onTap: () => _toggleSection(2),
                  isCollapsed: _collapsedSections[2],
                ),
              ),
              if (!_collapsedSections[2])
                const SliverToBoxAdapter(
                  child: FieldGroupCard(
                    fields: [
                      FieldItem(label: 'Case Name', value: 'Artho Jari'),
                      FieldItem(label: 'Case Number', value: 'Artho-83/18', emphasize: true),
                      FieldItem(label: 'Case Claim Amount', value: '845,704.00'),
                      FieldItem(label: 'Previous Date', value: '15-Nov-23'),
                      FieldItem(label: 'Case Status Previous Date', value: 'Warrant Of Arrest'),
                      FieldItem(label: 'Activities Previous Date', value: 'Hazira'),
                      FieldItem(label: 'Next Date', value: '30-Jan-24', emphasize: true),
                      FieldItem(label: 'Case Status Next Date', value: 'Warrant Of Arrest'),
                      FieldItem(label: 'Remarks Next Date', value: 'Warrant Of Arrest'),
                      FieldItem(label: 'Filling Plaintiff', value: 'Kanchan Miah(11276)'),
                      FieldItem(label: 'Filling Date', value: '24-Nov-19'),
                      FieldItem(label: 'Suit File Entry Date', value: ''),
                      FieldItem(label: 'Case Deal Officer', value: 'Kanchan Miah(11276)'),
                      FieldItem(label: 'Previous Lawyer Name', value: ''),
                      FieldItem(label: 'Present Lawyer Name', value: 'ADVOCATE MD. AZHARUL HAQUE'),
                      FieldItem(label: 'Previous Court Name', value: 'Arthorin Adalot'),
                      FieldItem(label: 'Present Court Name', value: 'Arthorin Adalot'),
                      FieldItem(label: 'Suit File Entry By', value: ''),
                      FieldItem(label: 'Arji Copy', value: ''),
                      FieldItem(label: 'Judge Name', value: ''),
                    ],
                  ),
                ),
            ],
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
