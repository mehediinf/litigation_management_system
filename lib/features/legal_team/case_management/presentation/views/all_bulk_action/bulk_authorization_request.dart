import 'package:flutter/material.dart';

class BulkAuthorizationRequestPage extends StatefulWidget {
  const BulkAuthorizationRequestPage({super.key});

  @override
  State<BulkAuthorizationRequestPage> createState() =>
      _BulkAuthorizationRequestPageState();
}

class _BulkAuthorizationRequestPageState
    extends State<BulkAuthorizationRequestPage> {
  bool _selectAll = false;
  final List<Map<String, dynamic>> _selectedItems = [];

  final List<Map<String, dynamic>> _dummyData = [
    {
      'id': 1,
      'caseNumber': 'ARA-001/2026',
      'clientName': 'ABC Corporation',
      'reassignedFrom': 'Md. Ruhul Amin Mia',
      'reassignedTo': 'Fatima Akhter',
      'status': 'Pending Approval',
      'date': '12-Jan-26',
    },
    {
      'id': 2,
      'caseNumber': 'ARA-002/2026',
      'clientName': 'XYZ Industries',
      'reassignedFrom': 'Mohammad Hasan',
      'reassignedTo': 'Ahmed Hassan Khan',
      'status': 'Pending Approval',
      'date': '13-Jan-26',
    },
    {
      'id': 3,
      'caseNumber': 'ARA-003/2026',
      'clientName': 'PQR Company',
      'reassignedFrom': 'Sadia Islam',
      'reassignedTo': 'Noor Fatima',
      'status': 'Pending Approval',
      'date': '14-Jan-26',
    },
    {
      'id': 4,
      'caseNumber': 'ARA-004/2026',
      'clientName': 'LMN Ltd',
      'reassignedFrom': 'Ahmed Hassan Khan',
      'reassignedTo': 'Md. Ruhul Amin Mia',
      'status': 'Pending Approval',
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
          'Bulk Authorization Request',
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
            color: const Color(0xFF1552B0),
            padding: const EdgeInsets.all(16),
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
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1552B0)
                          : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(
                                0xFF1552B0,
                              ).withValues(alpha: 0.1),
                              blurRadius: 8,
                            ),
                          ]
                        : [],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4361EE),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(14),
                              bottomLeft: Radius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      CheckboxListTile(
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
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _InfoChip(
                                      label: 'From',
                                      value: item['reassignedFrom'],
                                      color: const Color(0xFFFFA500),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 16,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _InfoChip(
                                      label: 'To',
                                      value: item['reassignedTo'],
                                      color: const Color(0xFF06D6A0),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF3CD),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      'Pending Approval',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFB89E00),
                                      ),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (_selectedItems.isNotEmpty)
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
                        'Reject',
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
                            backgroundColor: const Color(0xFF4361EE),
                            content: Text(
                              '${_selectedItems.length} reassignments approved',
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
                        backgroundColor: const Color(0xFF4361EE),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Approve Selected',
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

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
