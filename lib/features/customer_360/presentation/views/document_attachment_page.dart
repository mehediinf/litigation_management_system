//lib/features/customer_360/presentation/views/document_attachment_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class DocumentAttachmentPage extends StatelessWidget {
  const DocumentAttachmentPage({super.key});

  static const List<_AttachmentItem> _primaryDocuments = [
    _AttachmentItem(
      title: 'Call Up File',
      subtitle: 'Demand notice and supporting call-up file',
      icon: Icons.call_made_rounded,
    ),
    _AttachmentItem(
      title: 'Auction Legal Notice',
      subtitle: 'Auction notice copy and legal publication reference',
      icon: Icons.gavel_rounded,
    ),
    _AttachmentItem(
      title: 'Statement File',
      subtitle: 'Account statement and recovery calculation sheet',
      icon: Icons.receipt_long_rounded,
    ),
    _AttachmentItem(
      title: 'Sanction Letter',
      subtitle: 'Sanction terms, facility details, and approval copy',
      icon: Icons.assignment_outlined,
    ),
    _AttachmentItem(
      title: 'Final Legal Notice',
      subtitle: 'Final issued notice before filing or escalation',
      icon: Icons.campaign_outlined,
    ),
    _AttachmentItem(
      title: 'Remarks File',
      subtitle: 'Officer remarks and internal reference documents',
      icon: Icons.sticky_note_2_outlined,
    ),
  ];

  static const List<_AttachmentItem> _arjiCopies = [
    _AttachmentItem(
      title: 'Arji Copy 01',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 02',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 03',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 04',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 05',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 06',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 07',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 08',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 09',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 10',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 11',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 12',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 13',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 14',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 15',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
    _AttachmentItem(
      title: 'Arji Copy 16',
      subtitle: 'Petition copy and court submission document',
      icon: Icons.description_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalCount = _primaryDocuments.length + _arjiCopies.length;

    return Customer360Scaffold(
      title: 'Document Attachment',
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverMainAxisGroup(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  title: 'Core Documents',
                  icon: Icons.folder_copy_outlined,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
                sliver: SliverList.separated(
                  itemCount: _primaryDocuments.length,
                  itemBuilder: (context, index) =>
                      _AttachmentTile(item: _primaryDocuments[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
              ),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  title: 'Arji Copies',
                  icon: Icons.library_books_outlined,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 26),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        _CompactAttachmentCard(item: _arjiCopies[index]),
                    childCount: _arjiCopies.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Customer360Tokens.scaffoldBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Customer360Tokens.border),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              size: 18,
              color: Customer360Tokens.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Customer360Tokens.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Customer360Tokens.textSecondary,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile({required this.item});

  final _AttachmentItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Customer360Tokens.border, width: 1.1),
        boxShadow: Customer360Tokens.softShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Customer360Tokens.softBlue,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              item.icon,
              color: Customer360Tokens.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Customer360Tokens.textPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 13.5,
                            ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const _StatusBadge(label: 'Pending'),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  item.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Customer360Tokens.textSecondary,
                        fontSize: 11,
                        height: 1.35,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactAttachmentCard extends StatelessWidget {
  const _CompactAttachmentCard({required this.item});

  final _AttachmentItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Customer360Tokens.border, width: 1.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Customer360Tokens.softBlue,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  item.icon,
                  size: 18,
                  color: Customer360Tokens.primary,
                ),
              ),
              const Spacer(),
              const _StatusDot(),
            ],
          ),
          const Spacer(),
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Customer360Tokens.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                  height: 1.25,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Awaiting upload',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Customer360Tokens.textSecondary,
                  fontSize: 10.5,
                ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E8),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFFFE2AE)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF9A6700),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Color(0xFFFFC857),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _AttachmentItem {
  const _AttachmentItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}
