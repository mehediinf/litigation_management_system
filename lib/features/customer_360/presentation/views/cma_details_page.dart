import 'package:flutter/material.dart';
import 'package:litigation_management_system/features/customer_360/presentation/widgets/customer_360_widgets.dart';

class CMADetailsPage extends StatelessWidget {
  const CMADetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Customer360Scaffold(
      title: 'CMA Details',
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(title: 'Customer Information'),
          ),
          const SliverToBoxAdapter(
            child: FieldGroupCard(
              fields: [
                FieldItem(label: 'Sl No.', value: ''),
                FieldItem(label: 'Requisition Type', value: 'Legal Notice'),
                FieldItem(label: 'Proposed Type', value: 'Carpe Care'),
                FieldItem(label: 'Card No.', value: '222222******2222'),
                FieldItem(label: 'CIF', value: ''),
                FieldItem(label: 'Name on Card', value: 'Bbl 2'),
                FieldItem(label: 'Borrower Name', value: ''),
                FieldItem(label: 'Business Type', value: ''),
                FieldItem(label: 'Spouse Name', value: 'N/A'),
                FieldItem(label: 'Mother Name', value: 'N/A'),
                FieldItem(label: 'Loan Segment (Portfolio)', value: 'Retail'),
                FieldItem(label: 'Current/Updated Address', value: ''),
              ],
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(title: 'Branch & Region'),
          ),
          const SliverToBoxAdapter(
            child: FieldGroupCard(
              fields: [
                FieldItem(label: 'Territory', value: 'ELEPHANT ROAD'),
                FieldItem(label: 'District', value: 'DHAKA-ELEPHANT ROAD'),
                FieldItem(label: 'Unit Office', value: ''),
                FieldItem(label: 'Branch SOL', value: ''),
                FieldItem(label: 'Region', value: 'Central'),
                FieldItem(label: 'More A/C No.', value: ''),
                FieldItem(label: 'Loan Sanction Date', value: ''),
                FieldItem(label: 'Legal Region', value: ''),
              ],
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(title: 'Case & Approval Flow'),
          ),
          const SliverToBoxAdapter(
            child: FieldGroupCard(
              fields: [
                FieldItem(label: 'Status', value: 'Send To HOOPS', emphasize: true),
                FieldItem(label: 'Initiate By', value: ''),
                FieldItem(label: 'Previous CMA Approval Date', value: ''),
                FieldItem(label: 'Previous Case Type', value: ''),
                FieldItem(label: 'Customer Contact', value: ''),
                FieldItem(label: 'Initiate Date Time', value: ''),
                FieldItem(label: 'STC By', value: ''),
                FieldItem(label: 'STC Date Time', value: ''),
                FieldItem(label: 'Recommended By', value: ''),
                FieldItem(label: 'Recommend Date Time', value: ''),
                FieldItem(label: 'HO Acknowledge By', value: ''),
                FieldItem(label: 'HO Acknowledge Date Time', value: ''),
                FieldItem(label: 'Send To HOLM By', value: ''),
                FieldItem(label: 'Send To HOLM Date Time', value: ''),
                FieldItem(label: 'Verify By', value: ''),
                FieldItem(label: 'Verify Date Time', value: '08-Aug-22 12:00 AM', emphasize: true),
                FieldItem(label: 'Auction Complete By', value: ''),
                FieldItem(label: 'Auction Complete Date', value: ''),
                FieldItem(label: 'Hold Reason', value: ''),
                FieldItem(label: 'Previous Case Filing Date', value: ''),
                FieldItem(label: 'Previous CMA Approval Type', value: ''),
                FieldItem(label: 'Previous Case Status', value: ''),
                FieldItem(label: 'Disposal Status', value: ''),
              ],
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(title: 'Financial & Security'),
          ),
          const SliverToBoxAdapter(
            child: FieldGroupCard(
              fields: [
                FieldItem(label: 'Last Payment Date', value: ''),
                FieldItem(label: 'Last Payment Amount', value: ''),
                FieldItem(label: 'Case Claim Amount', value: ''),
                FieldItem(label: 'Judgment Summary', value: ''),
                FieldItem(label: 'Security Status', value: 'Unsecured', emphasize: true),
                FieldItem(label: 'Interest Rate (As per Sanction)', value: ''),
                FieldItem(label: 'Business Status', value: ''),
                FieldItem(label: 'Borrower Status', value: ''),
                FieldItem(label: 'Chq. Status', value: ''),
                FieldItem(label: 'Chq Expiry Date', value: ''),
                FieldItem(label: 'Current DPD:DPD', value: ''),
              ],
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(title: 'Operational Notes'),
          ),
          const SliverToBoxAdapter(
            child: FieldGroupCard(
              fields: [
                FieldItem(label: 'Case File District', value: ''),
                FieldItem(label: 'Remarks', value: ''),
                FieldItem(label: 'Previous Auction Sts', value: ''),
                FieldItem(label: 'Current Auction Sts', value: ''),
                FieldItem(label: 'Disposal remarks', value: ''),
                FieldItem(label: 'Logic for ARA Case', value: ''),
                FieldItem(label: 'Send To HOOPS By', value: ''),
                FieldItem(label: 'Send To HOOPS Date Time', value: ''),
                FieldItem(label: 'File Deliver By', value: ''),
                FieldItem(label: 'File Deliver Date Time', value: ''),
                FieldItem(label: 'Legal Ack By', value: ''),
                FieldItem(label: 'Legal Ack Date Time', value: ''),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
