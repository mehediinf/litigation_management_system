import 'package:flutter/material.dart';

class BulkSendForApprovalPage extends StatefulWidget {
  const BulkSendForApprovalPage({super.key});

  @override
  State<BulkSendForApprovalPage> createState() =>
      _BulkSendForApprovalPageState();
}

class _BulkSendForApprovalPageState extends State<BulkSendForApprovalPage> {
  bool _selectAll = false;
  String _selectedTeamMember = '';
  final List<Map<String, dynamic>> _selectedItems = [];

  final List<String> _teamMembers = [
    'Md. Ruhul Amin Mia',
    'Fatima Akhter',
    'Mohammad Hasan',
    'Sadia Islam',
    'Ahmed Hassan Khan',
    'Noor Fatima',
  ];

  final List<Map<String, dynamic>> _dummyData = [
    {
      'id': 1,
      'caseNumber': 'ARF-001/2026',
      'clientName': 'ABC Corporation',
      'currentAssigned': 'Md. Ruhul Amin Mia',
      'amount': '৳ 5,00,000',
      'date': '12-Jan-26',
    },
    {
      'id': 2,
      'caseNumber': 'ARF-002/2026',
      'clientName': 'XYZ Industries',
      'currentAssigned': 'Fatima Akhter',
      'amount': '৳ 7,50,000',
      'date': '13-Jan-26',
    },
    {
      'id': 3,
      'caseNumber': 'ARF-003/2026',
      'clientName': 'PQR Company',
      'currentAssigned': 'Mohammad Hasan',
      'amount': '৳ 3,25,000',
      'date': '14-Jan-26',
    },
    {
      'id': 4,
      'caseNumber': 'ARF-004/2026',
      'clientName': 'LMN Ltd',
      'currentAssigned': 'Sadia Islam',
      'amount': '৳ 9,00,000',
      'date': '15-Jan-26',
    },
  ];

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
          'Bulk Re-assign File',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Assign to Team Member',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    value: _selectedTeamMember.isEmpty
                        ? null
                        : _selectedTeamMember,
                    hint: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Select Team Member'),
                    ),
                    items: _teamMembers.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTeamMember = newValue ?? '';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xFF1552B0),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Checkbox(
                  value: _selectAll,
                  activeColor: Colors.white,
                  checkColor: const Color(0xFF1552B0),
                  onChanged: (value) {
                    setState(() {
                      _selectAll = value ?? false;
                      if (_selectAll) {
                        _selectedItems.clear();
                        _selectedItems.addAll(_dummyData);
                      } else {
                        _selectedItems.clear();
                      }
                    });
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectAll
                        ? 'All selected (${_selectedItems.length})'
                        : 'Select All',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_selectedItems.length}/${_dummyData.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _dummyData.length,
              itemBuilder: (context, index) {
                final item = _dummyData[index];
                final isSelected = _selectedItems.any(
                  (e) => e['id'] == item['id'],
                );

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1552B0)
                          : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value ?? false) {
                          _selectedItems.add(item);
                        } else {
                          _selectedItems.removeWhere(
                            (e) => e['id'] == item['id'],
                          );
                          _selectAll = false;
                        }
                      });
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['caseNumber'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['clientName'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current: ${item['currentAssigned']}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            item['date'],
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_selectedItems.isNotEmpty && _selectedTeamMember.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _selectedItems.clear();
                          _selectAll = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(
                          color: Color(0xFF1552B0),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF1552B0),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: const Color(0xFF2EC4B6),
                            content: Text(
                              '${_selectedItems.length} cases reassigned to $_selectedTeamMember',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF2EC4B6),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Re-assign Selected',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
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
