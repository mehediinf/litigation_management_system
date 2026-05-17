// lib/features/dashboard/presentation/views/memos_notices/memos_notices_page.dart

import 'package:flutter/material.dart';
import 'package:litigation_management_system/app/theme/app_color.dart';
import 'package:litigation_management_system/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:litigation_management_system/features/dashboard/presentation/widgets/dashboard_support_widgets.dart';

import '../instrument_delivery_status_cases/instrument_delivery_cases_app_bar.dart';

class MemosNoticesPage extends StatefulWidget {
  const MemosNoticesPage({super.key, required this.items});

  final List<NoticeItem> items;

  @override
  State<MemosNoticesPage> createState() => _MemosNoticesPageState();
}

class _MemosNoticesPageState extends State<MemosNoticesPage> {
  bool _isSearching = false;

  final TextEditingController _searchController = TextEditingController();

  late List<NoticeItem> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;

    _searchController.addListener(() {
      setState(() {});
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;

      if (!_isSearching) {
        _searchController.clear();
        _filteredItems = widget.items;
      }
    });
  }

  void _onSearchChanged(String query) {
    final search = query.trim().toLowerCase();

    setState(() {
      if (search.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items.where((item) {
          return item.title.toLowerCase().contains(search);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primary,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
      ),

      titleSpacing: 0,

      title: _isSearching
          ? Container(
              height: 46,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12),

              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(14),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.search_rounded,
                    color: Colors.black87,
                    size: 20,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      onChanged: _onSearchChanged,

                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),

                      cursorColor: AppColor.primary,

                      decoration: const InputDecoration(
                        hintText: 'Search memos...',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: _toggleSearch,
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                ],
              ),
            )
          : const Text(
              'Memos & Notices',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),

      actions: _isSearching
          ? []
          : [
              IconButton(
                onPressed: _toggleSearch,
                icon: const Icon(Icons.search_rounded, color: Colors.white),
              ),
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.drawerBg,

      appBar: _buildAppBar(context),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: AppColor.panelBg,

              border: Border(bottom: BorderSide(color: AppColor.borderSoft)),
            ),

            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primary.withValues(alpha: 0.15),

                        AppColor.primary.withValues(alpha: 0.05),
                      ],
                    ),

                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: const Icon(
                    Icons.mail_outline_rounded,
                    color: AppColor.primary,
                    size: 26,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Text(
                        'Internal Communications',

                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColor.textPrimary,
                              letterSpacing: -0.5,
                            ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        'Updates on legal notices and recovery memos',

                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _filteredItems.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),

                    physics: const BouncingScrollPhysics(),

                    itemCount: _filteredItems.length,

                    itemBuilder: (context, index) {
                      return MemoTile(item: _filteredItems[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              _isSearching
                  ? Icons.search_off_rounded
                  : Icons.mark_email_read_outlined,

              size: 80,

              color: AppColor.textMuted.withValues(alpha: 0.30),
            ),

            const SizedBox(height: 18),

            Text(
              _isSearching
                  ? 'No matching memos found'
                  : 'No new memos or notices',

              textAlign: TextAlign.center,

              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColor.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),

            if (_isSearching) ...[
              const SizedBox(height: 8),

              Text(
                'Try searching with another keyword',

                textAlign: TextAlign.center,

                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
