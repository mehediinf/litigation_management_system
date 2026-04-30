//lib/features/customer_360/presentation/views/customer_360_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/app/router/app_router.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class Customer360Page extends StatefulWidget {
  const Customer360Page({
    super.key,
    this.searchQuery,
  });

  final String? searchQuery;

  @override
  State<Customer360Page> createState() => _Customer360PageState();
}

class _Customer360PageState extends State<Customer360Page> {
  static const List<_CustomerSectionData> _sections = [
    _CustomerSectionData(
      title: '1st Legal Notice Details',
      subtitle: 'Initial customer notice and issuance reference',
      icon: Icons.mark_email_read_outlined,
      routeName: AppRouter.legalNoticeOne,
    ),
    _CustomerSectionData(
      title: 'CMA Details',
      subtitle: 'Credit approval and assessment information',
      icon: Icons.assessment_outlined,
      routeName: AppRouter.cmaDetails,
    ),
    _CustomerSectionData(
      title: 'Auction Details',
      subtitle: 'Auction process, valuation, and timeline summary',
      icon: Icons.gavel_outlined,
      routeName: AppRouter.auctionDetails,
    ),
    _CustomerSectionData(
      title: 'Final Legal Notice Details',
      subtitle: 'Final notice status and supporting references',
      icon: Icons.campaign_outlined,
      routeName: AppRouter.finalLegalNotice,
    ),
    _CustomerSectionData(
      title: 'Suit Filing Information',
      subtitle: 'Suit filing status, court reference, and dates',
      icon: Icons.folder_open_outlined,
      routeName: AppRouter.suitFiling,
    ),
    _CustomerSectionData(
      title: 'Document Attachment',
      subtitle: 'Uploaded files and attachment availability',
      icon: Icons.attach_file_outlined,
      routeName: AppRouter.documents,
    ),
    _CustomerSectionData(
      title: 'Other Information',
      subtitle: 'Additional customer-level legal remarks',
      icon: Icons.info_outline_rounded,
      routeName: AppRouter.otherInfo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width < 380 ? 16.0 : 18.0;
    final safeSearchQuery = widget.searchQuery ?? '';
    final normalizedQuery = safeSearchQuery.trim().toLowerCase();
    final filteredEntries = _sections
        .where(
          (section) => normalizedQuery.isEmpty ? true : section.matches(normalizedQuery),
        )
        .toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 32),
      children: [
        if (filteredEntries.isEmpty)
          const _EmptyCustomerState()
        else
          ...filteredEntries.map((section) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _CustomerSectionCard(
                section: section,
                onTap: () {
                  Navigator.pushNamed(context, section.routeName);
                },
              ),
            );
          }),
      ],
    );
  }
}

class _CustomerSectionCard extends StatelessWidget {
  const _CustomerSectionCard({
    required this.section,
    required this.onTap,
  });

  final _CustomerSectionData section;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Customer360Tokens.border),
        boxShadow: Customer360Tokens.softShadow,
      ),
      child: Material(
        color: AppColor.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Customer360Tokens.softBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    section.icon,
                    color: Customer360Tokens.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Customer360Tokens.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        section.subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Customer360Tokens.textSecondary,
                              height: 1.35,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Customer360Tokens.primary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyCustomerState extends StatelessWidget {
  const _EmptyCustomerState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Customer360Tokens.border),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Customer360Tokens.softBlue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: Customer360Tokens.primary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No matching section found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Customer360Tokens.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try searching with account no, card no, account name, or section title.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Customer360Tokens.textSecondary,
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}

class _CustomerSectionData {
  const _CustomerSectionData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.routeName,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String routeName;

  bool matches(String query) {
    return title.toLowerCase().contains(query) ||
        subtitle.toLowerCase().contains(query);
  }
}
