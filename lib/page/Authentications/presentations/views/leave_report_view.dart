import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/LeaveReportViewScreenController.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class LeaveReportViewScreen extends GetView<LeaveReportViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)
        ),
        backgroundColor: appColor,
        title: Text(
          'Leaves',
          style: MontserratStyles.montserratBoldTextStyle(
            size: 18,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.hitLeavesApiCall,
          ),
          IconButton(
            icon: Icon(Icons.add, size: 30),
            onPressed: () => Get.toNamed(AppRoutes.leaveUpdateScreen),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTopBar(),
          _buildSearchBar(),
          Expanded(
            child: Obx(
                  () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : _buildDataTable(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: _buildFilterDropdown()),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Obx(
          () => Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<String>(
          value: controller.selectedFilter.value,
          items: controller.filterTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 14,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            controller.updateSelectedFilter(value);
          },
          style: MontserratStyles.montserratRegularTextStyle(
            size: 14,
            color: Colors.black,
          ),
          icon: Icon(Icons.arrow_drop_down, color: Colors.black),
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) {
          controller.updateSearchQuery(value);
        },
        style: MontserratStyles.montserratSemiBoldTextStyle(
          size: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: 'Search',
          labelStyle: MontserratStyles.montserratSemiBoldTextStyle(
            size: 14,
            color: Colors.grey,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: appColor),
          ),
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Obx(() {
            final filteredData = controller.filteredLeaves;
            return DataTable(
              headingRowColor: MaterialStateColor.resolveWith((states) => appColor.withOpacity(0.1)),
              dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
              columnSpacing: 20,
              horizontalMargin: 12,
              headingRowHeight: 50,
              dataRowHeight: 60,
              headingTextStyle: MontserratStyles.montserratBoldTextStyle(
                size: 13,
                color: Colors.black,
              ),
              dataTextStyle: MontserratStyles.montserratSemiBoldTextStyle(
                size: 12,
                color: Colors.black,
              ),
              columns: [
                DataColumn(label: Text('No.')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('From Date')),
                DataColumn(label: Text('To Date')),
                DataColumn(label: Text('Days')),
                DataColumn(label: Text('Reason')),
                DataColumn(label: Text('Leave Type')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: List<DataRow>.generate(
                filteredData.length,
                    (index) {
                  final leave = filteredData[index];
                  return DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text('${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}')),
                      DataCell(Text(leave.userId?.phoneNumber ?? '')),
                      DataCell(Text(leave.userId?.role ?? '')),
                      DataCell(Text(_formatDate(leave.startDate))),
                      DataCell(Text(_formatDate(leave.endDate))),
                      DataCell(Text(controller.calculateDays(
                        DateTime.parse(leave.startDate ?? ''),
                        DateTime.parse(leave.endDate ?? ''),
                      ).toString())),
                      DataCell(Text(leave.reason ?? '')),
                      DataCell(Text(leave.leaveType ?? '')),
                      DataCell(_buildStatusCell(leave.status ?? '')),
                      DataCell(_buildActionButton(leave)),
                    ],
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildStatusCell(String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = Colors.green;
        break;
      case 'rejected':
        statusColor = Colors.red;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor),
      ),
      child: Text(
        status,
        style: MontserratStyles.montserratSemiBoldTextStyle(
          size: 12,
          color: statusColor,
        ),
      ),
    );
  }

  Widget _buildActionButton(LeaveResult leave) {
    return ElevatedButton(
      onPressed: () => _openDropDownFieldforStatusSubmitions(),
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        'View Details',
        style: MontserratStyles.montserratBoldTextStyle(
          size: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    final date = DateTime.parse(dateStr);
    return '${date.day}/${date.month}/${date.year}';
  }
}

void _openDropDownFieldforStatusSubmitions() {
  final controller = Get.put(LeaveReportViewScreenController());
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 400,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Update Status",
              style: MontserratStyles.montserratBoldTextStyle(
                size: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24),
            CustomTextField(
              controller: TextEditingController(
                text: controller.defaultSelectedStatus.value,
              ),
              hintText: 'Select Status',
              labletext: 'Select Status',
              suffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Obx(
                      () => DropdownButton<String>(
                    value: controller.defaultSelectedStatus.value,
                    items: controller.selectedStatus.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: MontserratStyles.montserratSemiBoldTextStyle(
                            size: 14,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      controller.updateSelectedStatus(value);
                    },
                    style: MontserratStyles.montserratRegularTextStyle(
                      size: 14,
                      color: Colors.black,
                    ),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    isExpanded: true,
                    underline: Container(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                controller.hitUpdateStatusPutAPiCall();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                minimumSize: Size(130, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Submit",
                style: MontserratStyles.montserratSemiBoldTextStyle(size: 15),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}