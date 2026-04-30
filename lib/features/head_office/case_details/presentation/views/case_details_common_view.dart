
import 'package:flutter/material.dart';

class CaseDetailsAdvancedSearchConfig {
  const CaseDetailsAdvancedSearchConfig({
    required this.caseTitle,
    this.showCaseType = true,
    this.showProposedType = false,
    this.showNo = true,
    this.showCif = true,
    this.showTerritory = true,
    this.showDivision = false,
    this.showCategory = false,
    this.showRegion = true,
    this.showDistrict = true,
    this.showUnit = true,
    this.showFilingDate = true,
    this.showPortfolio = true,
    this.showCaseNo = true,
    this.showSuitType = false,
    this.showNextDate = false,
    this.showMonitoringDept = false,
    this.showDependentType = false,
    this.showRiskFactor = false,
    this.caseTypeOptions = const ['Type Of Case', 'Civil', 'Criminal', 'Artha Rin'],
    this.proposedTypeOptions = const ['Proposed Type', 'New', 'Running', 'Closed'],
    this.suitTypeOptions = const ['Select Suit Type', 'By Bank', 'Against Bank'],
    this.regionOptions = const ['Select Region', 'Dhaka', 'Chattogram', 'Khulna'],
    this.territoryOptions = const ['Select territory', 'North Territory', 'South Territory'],
    this.districtOptions = const ['Select district', 'Dhaka', 'Narayanganj', 'Gazipur'],
    this.monitoringDeptOptions = const ['Select Monitoring Dept.', 'Corporate', 'Retail', 'SME'],
    this.dependentTypeOptions = const ['Select dependent Type', 'Type 1', 'Type 2', 'Type 3'],
    this.riskFactorOptions = const ['Select Risk Factor', 'High', 'Medium', 'Low'],
    this.unitOptions = const ['Select unit office', 'Unit Office A', 'Unit Office B', 'Unit Office C'],
    this.portfolioOptions = const ['SME', 'Retail', 'Corporate'],
    this.divisionOptions = const ['Select Division', 'High Court Division', 'Appellate Division'],
    this.categoryOptions = const ['Select Case Category', 'Civil Appeal', 'Criminal Appeal', 'Writ Petition'],
  });

  final String caseTitle;
  final bool showCaseType;
  final bool showProposedType;
  final bool showNo;
  final bool showCif;
  final bool showTerritory;
  final bool showDivision;
  final bool showCategory;
  final bool showRegion;
  final bool showDistrict;
  final bool showUnit;
  final bool showFilingDate;
  final bool showPortfolio;
  final bool showCaseNo;
  final bool showSuitType;
  final bool showNextDate;
  final bool showMonitoringDept;
  final bool showDependentType;
  final bool showRiskFactor;
  final List<String> caseTypeOptions;
  final List<String> proposedTypeOptions;
  final List<String> suitTypeOptions;
  final List<String> regionOptions;
  final List<String> territoryOptions;
  final List<String> districtOptions;
  final List<String> monitoringDeptOptions;
  final List<String> dependentTypeOptions;
  final List<String> riskFactorOptions;
  final List<String> unitOptions;
  final List<String> portfolioOptions;
  final List<String> divisionOptions;
  final List<String> categoryOptions;
}

class CaseDetailsCommonView extends StatefulWidget {
  const CaseDetailsCommonView({
    super.key,
    required this.pageTitle,
    required this.advancedSearchConfig,
    this.builder,
    this.child,
  });

  final String pageTitle;
  final CaseDetailsAdvancedSearchConfig advancedSearchConfig;
  final Widget Function(String searchQuery)? builder;
  final Widget? child;

  @override
  State<CaseDetailsCommonView> createState() => _CaseDetailsCommonViewState();
}

class _CaseDetailsCommonViewState extends State<CaseDetailsCommonView> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      if (_isSearching) {
        _searchController.clear();
        _searchQuery = '';
      }
      _isSearching = !_isSearching;
    });
  }

  void _onQueryChanged(String value) {
    setState(() => _searchQuery = value);
  }

  Future<void> _openAdvancedSearchDialog() async {
    final config = widget.advancedSearchConfig;

    String caseType = config.caseTypeOptions.isNotEmpty ? config.caseTypeOptions.first : '';
    String proposedType = config.proposedTypeOptions.isNotEmpty ? config.proposedTypeOptions.first : '';
    String region = config.regionOptions.isNotEmpty ? config.regionOptions.first : '';
    String territory = config.territoryOptions.isNotEmpty ? config.territoryOptions.first : '';
    String district = config.districtOptions.isNotEmpty ? config.districtOptions.first : '';
    String suitType = config.suitTypeOptions.isNotEmpty ? config.suitTypeOptions.first : '';
    String monitoringDept = config.monitoringDeptOptions.isNotEmpty ? config.monitoringDeptOptions.first : '';
    String dependentType = config.dependentTypeOptions.isNotEmpty ? config.dependentTypeOptions.first : '';
    String riskFactor = config.riskFactorOptions.isNotEmpty ? config.riskFactorOptions.first : '';
    String unitOffice = config.unitOptions.isNotEmpty ? config.unitOptions.first : '';
    String portfolio = config.portfolioOptions.isNotEmpty ? config.portfolioOptions.first : '';
    String division = config.divisionOptions.isNotEmpty ? config.divisionOptions.first : '';
    String category = config.categoryOptions.isNotEmpty ? config.categoryOptions.first : '';

    final noController = TextEditingController();
    final cifController = TextEditingController();
    final fromController = TextEditingController();
    final toController = TextEditingController();
    final nextDateController = TextEditingController();
    final caseNoController = TextEditingController();

    Future<void> pickDate(TextEditingController controller) async {
      final picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: DateTime.now(),
        builder: (ctx, child) => Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF1552B0), onPrimary: Colors.white),
          ),
          child: child!,
        ),
      );
      if (picked != null) {
        controller.text =
        '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      }
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              elevation: 0,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 560),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.80,
                  child: Column(
                    children: [
                      // Dialog Header
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1552B0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.tune_rounded, color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Advanced Search',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(dialogContext).pop(),
                              icon: const Icon(Icons.close_rounded, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      // Body
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (config.showDivision || config.showCategory || config.showCaseType || config.showProposedType) ...[
                                _sectionLabel('Case Information'),
                                const SizedBox(height: 10),
                                if (config.showDivision)
                                  _dropdownField(
                                    context: context, label: 'Division', value: division,
                                    options: config.divisionOptions,
                                    onChanged: (v) => setLocalState(() => division = v),
                                  ),
                                if (config.showCategory)
                                  _dropdownField(
                                    context: context, label: 'Category', value: category,
                                    options: config.categoryOptions,
                                    onChanged: (v) => setLocalState(() => category = v),
                                  ),
                                if (config.showCaseType)
                                  _dropdownField(
                                    context: context, label: 'Types', value: caseType,
                                    options: config.caseTypeOptions,
                                    onChanged: (v) => setLocalState(() => caseType = v),
                                  ),
                                if (config.showProposedType)
                                  _dropdownField(
                                    context: context, label: 'Proposed Type', value: proposedType,
                                    options: config.proposedTypeOptions,
                                    onChanged: (v) => setLocalState(() => proposedType = v),
                                  ),
                              ],
                              if (config.showNo)
                                _textField(
                                  label: config.showDivision ? 'A/C or Card' : 'No.',
                                  controller: noController,
                                  hint: config.showDivision ? 'Case Number' : null,
                                ),
                              if (config.showCif) _textField(label: 'CIF', controller: cifController),
                              if (config.showCaseNo) _textField(label: 'Case Number', controller: caseNoController),
                              if (config.showSuitType)
                                _dropdownField(
                                  context: context,
                                  label: 'Suit Type',
                                  value: suitType,
                                  options: config.suitTypeOptions,
                                  onChanged: (v) => setLocalState(() => suitType = v),
                                ),
                              const SizedBox(height: 8),
                              if (config.showTerritory || config.showRegion || config.showDistrict || config.showUnit) ...[
                                _sectionLabel('Location'),
                                const SizedBox(height: 10),
                                if (config.showRegion)
                                  _dropdownField(
                                    context: context, label: 'Region', value: region,
                                    options: config.regionOptions,
                                    onChanged: (v) => setLocalState(() => region = v),
                                  ),
                                if (config.showTerritory)
                                  _dropdownField(
                                    context: context, label: 'Territory', value: territory,
                                    options: config.territoryOptions,
                                    onChanged: (v) => setLocalState(() => territory = v),
                                  ),
                                if (config.showDistrict)
                                  _dropdownField(
                                    context: context, label: 'District', value: district,
                                    options: config.districtOptions,
                                    onChanged: (v) => setLocalState(() => district = v),
                                  ),
                                if (config.showMonitoringDept)
                                  _dropdownField(
                                    context: context,
                                    label: 'Monitoring Dept.',
                                    value: monitoringDept,
                                    options: config.monitoringDeptOptions,
                                    onChanged: (v) => setLocalState(() => monitoringDept = v),
                                  ),
                                if (config.showDependentType)
                                  _dropdownField(
                                    context: context,
                                    label: 'Dependent Type',
                                    value: dependentType,
                                    options: config.dependentTypeOptions,
                                    onChanged: (v) => setLocalState(() => dependentType = v),
                                  ),
                                if (config.showRiskFactor)
                                  _dropdownField(
                                    context: context,
                                    label: 'Risk Factor',
                                    value: riskFactor,
                                    options: config.riskFactorOptions,
                                    onChanged: (v) => setLocalState(() => riskFactor = v),
                                  ),
                                if (config.showUnit)
                                  _dropdownField(
                                    context: context, label: 'Unit', value: unitOffice,
                                    options: config.unitOptions,
                                    onChanged: (v) => setLocalState(() => unitOffice = v),
                                  ),
                                const SizedBox(height: 8),
                              ],
                              if (config.showFilingDate) ...[
                                _sectionLabel('Filing Date Range'),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(child: _dateField(label: 'From', controller: fromController, onTap: () => pickDate(fromController))),
                                    const SizedBox(width: 12),
                                    Expanded(child: _dateField(label: 'To', controller: toController, onTap: () => pickDate(toController))),
                                  ],
                                ),
                                const SizedBox(height: 8),
                              ],
                              if (config.showNextDate)
                                _dateField(
                                  label: 'Next Date',
                                  controller: nextDateController,
                                  onTap: () => pickDate(nextDateController),
                                ),
                              if (config.showPortfolio) ...[
                                _sectionLabel('Other'),
                                const SizedBox(height: 10),
                                if (config.showPortfolio)
                                  _dropdownField(
                                    context: context, label: 'Portfolio', value: portfolio,
                                    options: config.portfolioOptions,
                                    onChanged: (v) => setLocalState(() => portfolio = v),
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      // Footer
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                          border: Border(top: BorderSide(color: Colors.grey.shade100)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(dialogContext).pop(),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.grey.shade600,
                                  side: BorderSide(color: Colors.grey.shade300),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                                child: const Text('Reset'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: FilledButton.icon(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                  final parts = <String>[];
                                  if (config.showDivision && division != config.divisionOptions.first) parts.add(division);
                                  if (config.showCategory && category != config.categoryOptions.first) parts.add(category);
                                  if (config.showCaseType && caseType != config.caseTypeOptions.first) parts.add(caseType);
                                  if (config.showProposedType && proposedType != config.proposedTypeOptions.first) parts.add(proposedType);
                                  if (config.showNo && noController.text.trim().isNotEmpty) parts.add(noController.text.trim());
                                  if (config.showCif && cifController.text.trim().isNotEmpty) parts.add(cifController.text.trim());
                                  if (config.showCaseNo && caseNoController.text.trim().isNotEmpty) parts.add(caseNoController.text.trim());
                                  if (config.showSuitType && suitType != config.suitTypeOptions.first) parts.add(suitType);
                                  if (region != config.regionOptions.first) parts.add(region);
                                  if (config.showTerritory && territory != config.territoryOptions.first) parts.add(territory);
                                  if (district != config.districtOptions.first) parts.add(district);
                                  if (config.showMonitoringDept && monitoringDept != config.monitoringDeptOptions.first) parts.add(monitoringDept);
                                  if (config.showDependentType && dependentType != config.dependentTypeOptions.first) parts.add(dependentType);
                                  if (config.showRiskFactor && riskFactor != config.riskFactorOptions.first) parts.add(riskFactor);
                                  if (unitOffice != config.unitOptions.first) parts.add(unitOffice);
                                  if (fromController.text.trim().isNotEmpty) parts.add(fromController.text.trim());
                                  if (toController.text.trim().isNotEmpty) parts.add(toController.text.trim());
                                  if (config.showNextDate && nextDateController.text.trim().isNotEmpty) parts.add(nextDateController.text.trim());
                                  if (portfolio != config.portfolioOptions.first) parts.add(portfolio);
                                  final keyword = parts.join(' ').trim();
                                  setState(() {
                                    _searchQuery = keyword;
                                    _searchController.text = keyword;
                                    _isSearching = keyword.isNotEmpty;
                                  });
                                },
                                icon: const Icon(Icons.search_rounded, size: 18),
                                label: const Text('Search'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF1552B0),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    noController.dispose();
    cifController.dispose();
    fromController.dispose();
    toController.dispose();
    nextDateController.dispose();
    caseNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // passing the current _searchQuery to the child
    final bodyContent = widget.builder != null
        ? widget.builder!(_searchQuery)
        : widget.child ?? Center(
      child: Text(widget.pageTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFF1552B0),
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
          child: _isSearching
              ? Padding(
            key: const ValueKey('search-field'),
            padding: const EdgeInsets.only(right: 8),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              maxLines: 1,
              textInputAction: TextInputAction.search,
              cursorColor: Colors.white,
              onChanged: _onQueryChanged,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Search cases...',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.65), fontSize: 15),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.13),
                prefixIcon: Icon(Icons.search_rounded, color: Colors.white.withValues(alpha: 0.8), size: 20),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.5), width: 1),
                ),
              ),
            ),
          )
              : Text(
            widget.pageTitle,
            key: const ValueKey('title'),
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, letterSpacing: 0.2),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 4),
            child: IconButton(
              tooltip: _isSearching ? 'Close search' : 'Search',
              onPressed: _toggleSearch,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded, key: ValueKey(_isSearching)),
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: IconButton(
              tooltip: 'Advanced search',
              onPressed: _openAdvancedSearchDialog,
              icon: const Icon(Icons.tune_rounded),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearching && _searchQuery.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color(0xFFE8EEF9),
              child: Row(
                children: [
                  const Icon(Icons.filter_list_rounded, size: 14, color: Color(0xFF1552B0)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Results for: "$_searchQuery"',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF1552B0), fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleSearch,
                    child: const Icon(Icons.close_rounded, size: 14, color: Color(0xFF1552B0)),
                  ),
                ],
              ),
            ),
          Expanded(child: bodyContent),
        ],
      ),
    );
  }
}

Widget _sectionLabel(String label) {
  return Text(
    label.toUpperCase(),
    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1552B0), letterSpacing: 1.0),
  );
}

Widget _textField({required String label, required TextEditingController controller, String? hint}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 13),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFF7F9FD),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1552B0), width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    ),
  );
}

Widget _dropdownField({
  required BuildContext context,
  required String label,
  required String value,
  required List<String> options,
  required ValueChanged<String> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 13),
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFF7F9FD),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1552B0), width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      items: options.map((opt) => DropdownMenuItem<String>(value: opt, child: Text(opt, style: const TextStyle(fontSize: 14)))).toList(),
      onChanged: (next) { if (next != null) onChanged(next); },
    ),
  );
}

Widget _dateField({required String label, required TextEditingController controller, required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 13),
        hintText: 'dd/mm/yyyy',
        hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFF7F9FD),
        suffixIcon: const Icon(Icons.calendar_month_outlined, size: 18, color: Color(0xFF1552B0)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1552B0), width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    ),
  );
}

