// lib/features/legal_team/appeal_and_bail_money/presentation/views/widgets/deposit_card.dart

import 'package:flutter/material.dart';
import 'info_chip.dart';

class DepositCard extends StatelessWidget {
  final Map<String, String> data;

  const DepositCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isWithdrawn = data['status'] == 'Withdrawn';
    final statusColor = isWithdrawn
        ? Colors.green.shade700
        : Colors.orange.shade700;
    final statusBg = isWithdrawn ? Colors.green.shade50 : Colors.orange.shade50;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: const BoxDecoration(
              color: Color(0xFFF0F5FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1565C0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      data['name']![0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name']!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      Text(
                        data['account']!,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data['amount']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        data['status']!,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bottom Details Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Row(
              children: [
                Expanded(
                  child: InfoChip(
                    icon: Icons.gavel_outlined,
                    label: 'Case',
                    value: data['case']!,
                  ),
                ),
                const SizedBox(width: 10),
                InfoChip(
                  icon: Icons.calendar_today_outlined,
                  label: 'Date',
                  value: data['date']!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
