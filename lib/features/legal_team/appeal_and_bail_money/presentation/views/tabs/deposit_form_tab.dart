// lib/features/legal_team/appeal_and_bail_money/presentation/views/tabs/deposit_form_tab.dart

import 'package:flutter/material.dart';

class DepositFormTab extends StatelessWidget {
  const DepositFormTab({super.key});

  static const Color _primaryBlue = Color(0xFF1565C0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form Card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Card Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'New Deposit Entry',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildDropdownField(
                        'Proposed Type',
                        'Select Proposed Type',
                        Icons.category_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildFormField(
                        'Loan A/C',
                        'Enter Account Number',
                        Icons.account_balance_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildFormField(
                        'Case Number',
                        'Enter Case Number',
                        Icons.gavel_outlined,
                      ),
                      // const SizedBox(height: 16),
                      // _buildFormField(
                      //   'Account Name',
                      //   'Enter Account Name',
                      //   Icons.person_outline,
                      // ),
                      // const SizedBox(height: 16),
                      // _buildFormField(
                      //   'Deposit Amount',
                      //   'Enter Amount (৳)',
                      //   Icons.currency_exchange,
                      // ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.save_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Submit Deposit',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          decoration: _inputDecoration(hint, icon),
          items: const [
            DropdownMenuItem(value: 'loan', child: Text('Loan')),
            DropdownMenuItem(value: 'card', child: Text('Card')),
          ],
          onChanged: (_) {},
        ),
      ],
    );
  }

  Widget _buildFormField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label),
        const SizedBox(height: 6),
        TextField(decoration: _inputDecoration(hint, icon)),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
      prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade500),
      filled: true,
      fillColor: const Color(0xFFF8FAFF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF1565C0), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF37474F),
        letterSpacing: 0.2,
      ),
    );
  }
}
