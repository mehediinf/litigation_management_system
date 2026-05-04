import 'package:flutter/material.dart';

class BillingActionPreviewPage extends StatelessWidget {
  const BillingActionPreviewPage({super.key, this.caseData});

  final Map<String, dynamic>? caseData;

  String _ruleLabel() {
    final r = caseData?['Rule Number']?.toString().trim();
    if (r == null || r.isEmpty) return '—';
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FB),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFF1552B0),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Preview',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Rule Number: ${_ruleLabel()}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A2340),
            ),
          ),
        ),
      ),
    );
  }
}
