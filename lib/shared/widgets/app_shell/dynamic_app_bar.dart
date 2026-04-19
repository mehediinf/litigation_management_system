import 'package:flutter/material.dart';

class DynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DynamicAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(66);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 66,
      backgroundColor: const Color(0xFFEAF2FF),
      surfaceTintColor: Colors.transparent,
      shadowColor: const Color(0x120F3D91),
      elevation: 1,
      shape: const Border(
        bottom: BorderSide(
          color: Color(0xFFD7E5F7),
          width: 1,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF214A84),
        size: 22,
      ),
      actionsIconTheme: const IconThemeData(
        color: Color(0xFF214A84),
        size: 22,
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFEFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFC9DAF8)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x120B5FFF),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/lms_logo1.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        color: const Color(0xFF16345C),
                      ),
                ),
                Text(
                  'BRAC Bank Litigation',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF5D7FAF),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (actions != null) ...actions!,
      ],
    );
  }
}
