//lib/features/customer_360/presentation/views/other_information_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class OtherInformationPage extends StatefulWidget {
  const OtherInformationPage({super.key});

  @override
  State<OtherInformationPage> createState() => _OtherInformationPageState();
}

class _OtherInformationPageState extends State<OtherInformationPage> {
  bool _isRemarksCollapsed = false;

  static const String _remarksText =
      'Avast red ensign parley clap of thunder no prey, no pay killick stern '
      'clipper execution dock splice the main brace. Grog blossom yardarm '
      'bilge water marooned cog wherry tackle aye Shiver me timbers come '
      'about.';

  @override
  Widget build(BuildContext context) {
    return Customer360Scaffold(
      title: 'Other Information',
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverMainAxisGroup(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  title: 'Additional Remarks',
                  icon: Icons.notes_rounded,
                  onTap: () =>
                      setState(() => _isRemarksCollapsed = !_isRemarksCollapsed),
                  isCollapsed: _isRemarksCollapsed,
                ),
              ),
              if (!_isRemarksCollapsed)
                SliverToBoxAdapter(
                  child: _NarrativeCard(text: _remarksText),
                ),
            ],
          ),

          // SliverToBoxAdapter(
          //   child: _InformationMetaCard(
          //     items: const [
          //       _MetaItem(
          //         label: 'Category',
          //         value: 'Officer Note',
          //         icon: Icons.category_outlined,
          //       ),
          //       _MetaItem(
          //         label: 'Priority',
          //         value: 'Normal',
          //         icon: Icons.low_priority_rounded,
          //       ),
          //       _MetaItem(
          //         label: 'Source',
          //         value: 'Additional contextual remarks',
          //         icon: Icons.source_outlined,
          //       ),
          //     ],
          //   ),
          // ),
          // const SliverToBoxAdapter(child: SizedBox(height: 28)),

        ],
      ),
    );
  }
}


class _NarrativeCard extends StatelessWidget {
  const _NarrativeCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Customer360Tokens.border, width: 1.2),
        boxShadow: Customer360Tokens.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Customer360Tokens.softBlue,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Text Note',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Customer360Tokens.primaryStrong,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.5,
                  ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Customer360Tokens.textPrimary,
                  fontSize: 13,
                  height: 1.72,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

// class _InformationMetaCard extends StatelessWidget {
//   const _InformationMetaCard({required this.items});
//
//   final List<_MetaItem> items;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Customer360Tokens.surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Customer360Tokens.border, width: 1.2),
//       ),
//       child: Column(
//         children: [
//           for (var index = 0; index < items.length; index++) ...[
//             _MetaRow(item: items[index]),
//             if (index != items.length - 1) const SizedBox(height: 12),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class _MetaRow extends StatelessWidget {
//   const _MetaRow({required this.item});
//
//   final _MetaItem item;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 34,
//           height: 34,
//           decoration: BoxDecoration(
//             color: Customer360Tokens.softBlue,
//             borderRadius: BorderRadius.circular(11),
//           ),
//           child: Icon(
//             item.icon,
//             size: 18,
//             color: Customer360Tokens.primary,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 item.label,
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       color: Customer360Tokens.textSecondary,
//                       fontSize: 10.8,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//               const SizedBox(height: 3),
//               Text(
//                 item.value,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Customer360Tokens.textPrimary,
//                       fontSize: 12.8,
//                       fontWeight: FontWeight.w700,
//                       height: 1.4,
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _MetaItem {
//   const _MetaItem({
//     required this.label,
//     required this.value,
//     required this.icon,
//   });
//
//   final String label;
//   final String value;
//   final IconData icon;
// }
