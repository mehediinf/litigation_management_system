import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';

class Customer360Tokens {
  static const Color primary = AppColor.primary;
  static const Color primaryStrong = AppColor.primaryStrong;
  static const Color surface = AppColor.surface;
  static const Color scaffoldBg = AppColor.scaffoldBg;
  static const Color softBlue = AppColor.softBlue;
  static const Color border = AppColor.border;
  static const Color divider = AppColor.divider;
  static const Color textPrimary = AppColor.textPrimary;
  static const Color textSecondary = AppColor.textSecondary;
  static const Color emphasisBg = AppColor.emphasisBg;

  static const List<BoxShadow> softShadow = AppColor.softShadow;
}

class Customer360Scaffold extends StatefulWidget {
  const Customer360Scaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.enableSearch = false,
    this.searchHintText,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final bool enableSearch;
  final String? searchHintText;

  @override
  State<Customer360Scaffold> createState() => _Customer360ScaffoldState();
}

class _Customer360ScaffoldState extends State<Customer360Scaffold> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchOpen = false;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _openSearch() {
    setState(() => _isSearchOpen = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _searchFocusNode.requestFocus();
      }
    });
  }

  void _closeSearch() {
    _searchController.clear();
    _searchFocusNode.unfocus();
    setState(() => _isSearchOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customer360Tokens.scaffoldBg,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColor.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            _isSearchOpen
                ? Icons.arrow_back_rounded
                : Icons.arrow_back_ios_new_rounded,
            color: Customer360Tokens.textPrimary,
            size: _isSearchOpen ? 22 : 20,
          ),
          onPressed: () {
            if (_isSearchOpen) {
              _closeSearch();
              return;
            }
            Navigator.maybePop(context);
          },
        ),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: _isSearchOpen
              ? Container(
                  key: const ValueKey('search-field'),
                  height: 42,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: Customer360Tokens.scaffoldBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Customer360Tokens.border),
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: widget.searchHintText ?? 'Search here',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Customer360Tokens.textSecondary,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        size: 19,
                        color: Customer360Tokens.textSecondary,
                      ),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: Customer360Tokens.textSecondary,
                              ),
                            ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Customer360Tokens.textPrimary,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                    onChanged: (_) => setState(() {}),
                  ),
                )
              : Text(
                  widget.title,
                  key: const ValueKey('title-text'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Customer360Tokens.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                ),
        ),
        actions: [
          if (widget.enableSearch && !_isSearchOpen)
            Container(
              margin: const EdgeInsets.only(right: 6),
              child: IconButton(
                tooltip: 'Search',
                onPressed: _openSearch,
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Customer360Tokens.softBlue,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Customer360Tokens.border),
                  ),
                  child: const Icon(
                    Icons.search_rounded,
                    color: Customer360Tokens.primaryStrong,
                    size: 18,
                  ),
                ),
              ),
            ),
          ...?widget.actions,
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Customer360Tokens.divider,
            height: 1,
          ),
        ),
      ),
      body: widget.body,
    );
  }
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  StickyHeaderDelegate({
    required this.title,
    this.icon = Icons.push_pin_rounded,
    this.cardColor = AppColor.softBlue,
    this.borderColor,
    this.iconBackgroundColor,
    this.iconColor = Customer360Tokens.primary,
    this.textColor = Customer360Tokens.textPrimary,
    this.onTap,
    this.isCollapsed = false,
  });

  final String title;
  final IconData icon;
  final Color cardColor;
  final Color? borderColor;
  final Color? iconBackgroundColor;
  final Color iconColor;
  final Color textColor;
  final VoidCallback? onTap;
  final bool isCollapsed;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final showElevation = overlapsContent || shrinkOffset > 0;

    return Container(
      width: double.infinity,
      height: maxExtent,
      color: Customer360Tokens.scaffoldBg.withValues(alpha: 0.96),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: borderColor ?? Customer360Tokens.primary.withValues(alpha: 0.14),
                width: 0.8,
              ),
              boxShadow: [
                ...Customer360Tokens.softShadow,
                if (showElevation)
                  BoxShadow(
                    color: Customer360Tokens.primary.withValues(alpha: 0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: iconColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (onTap != null)
                  Icon(
                    isCollapsed
                        ? Icons.expand_more_rounded
                        : Icons.expand_less_rounded,
                    size: 20,
                    color: iconColor,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant StickyHeaderDelegate oldDelegate) {
    return oldDelegate.title != title ||
        oldDelegate.icon != icon ||
        oldDelegate.cardColor != cardColor ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.iconBackgroundColor != iconBackgroundColor ||
        oldDelegate.iconColor != iconColor ||
        oldDelegate.textColor != textColor ||
        oldDelegate.onTap != onTap ||
        oldDelegate.isCollapsed != isCollapsed;
  }
}

class FieldGroupCard extends StatelessWidget {
  const FieldGroupCard({
    super.key,
    required this.fields,
    this.showEmptyFields = false,
  });

  final List<FieldItem> fields;
  final bool showEmptyFields;

  @override
  Widget build(BuildContext context) {
    final visibleFields = showEmptyFields
        ? fields
        : fields.where((field) => field.hasValue).toList();

    if (visibleFields.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      decoration: BoxDecoration(
        color: Customer360Tokens.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Customer360Tokens.border, width: 1.5),
        boxShadow: Customer360Tokens.softShadow,
      ),
      child: Column(
        children: [
          ...visibleFields.asMap().entries.map((entry) {
            final field = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              child: DetailRow(field: field),
            );
          }),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.field,
  });

  final FieldItem field;

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: field.emphasize
              ? Customer360Tokens.primaryStrong
              : Customer360Tokens.textPrimary,
          fontWeight: field.emphasize ? FontWeight.w800 : FontWeight.w700,
          height: 1.32,
          fontSize: 13.5,
        );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              field.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Customer360Tokens.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    height: 1.3,
                  ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: field.emphasize
              ? Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Customer360Tokens.emphasisBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Customer360Tokens.primary.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      field.displayValue,
                      style: valueStyle,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    field.displayValue,
                    style: valueStyle,
                  ),
                ),
        ),
      ],
    );
  }
}

class FieldItem {
  const FieldItem({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  bool get hasValue => value.trim().isNotEmpty;
  String get displayValue => hasValue ? value : '-';
}
