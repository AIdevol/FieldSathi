import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/LeaveReportViewScreenController.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:intl/intl.dart';

import '../../../home/widget/leave_update_screen.dart';

class LeaveReportViewScreen extends GetView<LeaveReportViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Leaves', style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.refresh),
            onPressed: controller.hitLeavesApiCall,
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () { Get.to(LeaveUpdateScreen()); }
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTopBar(),
          _buildSearchBar(),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : _buildLeavesDataTable()),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: _buildFilterDropdown()),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Obx(() => DropdownButton(
      value: controller.selectedFilter.value,
      items: controller.filterTypes.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: controller.updateSelectedFilter,
    ));
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: controller.updateSearchQuery,
        decoration: const InputDecoration(
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildLeavesDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder(
            horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
          ),
          columnSpacing: 20,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            return Colors.grey.shade100;
          }),
          columns: const [
            DataColumn(label: Text('Sr. No.')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Role')),
            DataColumn(label: Text('From Date')),
            DataColumn(label: Text('To Date')),
            DataColumn(label: Text('Days')),
            DataColumn(label: Text('Reason')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Leave Type')),
            DataColumn(label: Text('Actions')),
          ],
          rows: controller.filteredLeaves.asMap().entries.map((entry) {
            final index = entry.key;
            final Results leave = entry.value;
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text('${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}')),
                DataCell(Text(leave.userId?.phoneNumber ?? '')),
                DataCell(Text(leave.userId?.role ?? '')),
                DataCell(Text(controller.formatDate(DateTime.parse(leave.startDate ?? '')))),
                DataCell(Text(controller.formatDate(DateTime.parse(leave.endDate ?? '')))),
                DataCell(Text(controller.calculateDays(
                    DateTime.parse(leave.startDate ?? ''),
                    DateTime.parse(leave.endDate ?? '')
                ).toString())),
                DataCell(Text(leave.reason ?? '')),
                DataCell(Text(leave.status ?? '')),
                DataCell(Text(leave.leaveType ?? '')),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () => controller.showLeaveDetails(leave),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}