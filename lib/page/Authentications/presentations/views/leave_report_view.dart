import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/LeaveReportViewScreenController.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/string_const.dart';

class LeaveReportViewScreen extends GetView<LeaveReportViewScreenController> {
  @override
  Widget build(BuildContext context) {
    final userrole = storage.read(userRole);
    return MyAnnotatedRegion(
      child: GetBuilder<LeaveReportViewScreenController>(
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor:CupertinoColors.white,
          bottomNavigationBar: _buildPaginationControls(controller),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87),
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
              if(userrole != 'technician'&&userrole !='sale')
              IconButton(
                icon: Icon(Icons.add, size: 30),
                onPressed: () => Get.toNamed(AppRoutes.leaveUpdateScreen),
              )
              else
                _viewDetailsButton(context, controller),
              hGap(10)
            ],
          ),
            // userrole != 'technician'&&userrole != 'sales'
          body: userrole != 'technician'&&userrole != 'sales'?
        RefreshIndicator(
            onRefresh: () => controller.hitRefreshApiCall(),
            child: Column(
              children: [
                _buildTopBar(),
                _buildSearchBar(),

                Expanded(
                  child: Obx(
                        () =>/* (userrole != "technician"&& userrole != 'sales')?*/
                        controller.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : controller.leavesPaginationsData.isEmpty
                        ? _buildEmptyState()
                        : _buildDataTable()
                    // : _buildTableData(context)
                  ),
                ),
                 // else
                 // Expanded(child: _buildTableData(context))

              ],
            ),
          )
          : LeavesResportForTechnicianAndSales()
        ),
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
          labelText: 'Search by Name, Reason, or Leave Type',
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            nullVisualImage,
            width: 300,
            height: 300,
          ),
          Text(
            'No leaves found',
            style: MontserratStyles.montserratNormalTextStyle(
              color: blackColor,
            ),
          ),
        ],
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
            final filteredData = controller.leavesPaginationsData;
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
                      DataCell(Text(_formatDate(leave.startDate.toString()))),
                      DataCell(Text(_formatDate(leave.endDate.toString()))),
                      DataCell(Text(controller.calculateDays(
                        DateTime.parse(leave.startDate.toString() ?? ''),
                        DateTime.parse(leave.endDate.toString()?? ''),
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
  Widget _buildPaginationControls(LeaveReportViewScreenController controller) {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.first_page),
            onPressed: controller.currentPage.value > 1
                ? () => controller.goToFirstPage()
                : null,
          ),
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: controller.currentPage.value > 1
                ? () => controller.previousPage()
                : null,
          ),
          Text(
            'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: controller.currentPage.value < controller.totalPages.value
                ? () => controller.nextPage()
                : null,
          ),
          IconButton(
            icon: Icon(Icons.last_page),
            onPressed: controller.currentPage.value < controller.totalPages.value
                ? () => controller.goToLastPage()
                : null,
          ),
        ],
      ),
    ));
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

class LeavesResportForTechnicianAndSales extends GetView<LeaveReportViewScreenController>{
  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<LeaveReportViewScreenController>(
      init: LeaveReportViewScreenController(),
        builder: (controller)=>
            Column(
              children: [
                _buildLeftViewsForLeaves(context, controller),
                _buildTopBar(controller),
                _buildSearchBar(controller),
                Expanded(child: _buildTableData(context,controller))
              ],
            ),
  ));
  }
}

_viewDetailsButton(BuildContext context, LeaveReportViewScreenController controller) {
  return ElevatedButton(onPressed: () {
    _leavesTypesApplicationViewScreen(context,controller);

  },
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        minimumSize: Size(120, 40),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: CupertinoColors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Apply Leave",style: MontserratStyles.montserratBoldTextStyle(
        color: CupertinoColors.white,
        size: 13,)));
}

Widget _buildTopBar(LeaveReportViewScreenController controller) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(child: _buildFilterDropdown(controller)),
      ],
    ),
  );
}

Widget _buildFilterDropdown(LeaveReportViewScreenController controller) {
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

Widget _buildSearchBar(LeaveReportViewScreenController controller) {
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
        labelText: 'Search by Name, Reason, or Leave Type',
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

Widget _buildLeftViewsForLeaves(BuildContext context, LeaveReportViewScreenController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Remaining Casual Leaves: ${controller.remainingCasualLeaves??"N/A"}",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Remaining Sick Leaves: ${controller.remainingSickLeaves??"N/A"}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    ),
  );
}

Widget _buildTableData(BuildContext context, LeaveReportViewScreenController controller){
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          final filteredData = controller.leavesPaginationsData;
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
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('From Date')),
              DataColumn(label: Text('To Date')),
              DataColumn(label: Text('Days')),
              DataColumn(label: Text('Reason')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text(' ')),
            ],
            rows: List<DataRow>.generate(
              filteredData.length,
                  (index) {
                final leave = filteredData[index];
                return DataRow(
                  cells: [
                    DataCell(Text('${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}')),
                    DataCell(Text(leave.userId?.phoneNumber ?? '')),
                    DataCell(Text(leave.userId?.role ?? '')),
                    DataCell(Text(leave.startDate.toString())),
                    DataCell(Text(leave.endDate.toString())),
                    DataCell(Text(controller.calculateDays(
                      DateTime.parse(leave.startDate.toString() ?? ''),
                      DateTime.parse(leave.endDate.toString()?? ''),
                    ).toString())),
                    DataCell(Text(leave.reason ?? 'N/A')),
                    DataCell(Text(leave.status ?? 'N/A')),
                    DataCell(
                      (leave.status == 'Submitted')
                          ? Row(children: [
                        _buildViewActionsButton(Icon(Icons.edit),(){
                          _leavesTypesApplicationViewScreen(context,controller);
                        }),
                        _buildViewActionsButton(Icon(Icons.delete,color: Colors.red,),(){

                        })
                      ],)
                       :Container()),
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

_buildViewActionsButton(Widget icon, VoidCallback? onPressed){
  return Row(children: [
    IconButton(onPressed: onPressed, icon: icon),
  ],);
}

_leavesTypesApplicationViewScreen(BuildContext context, LeaveReportViewScreenController controller) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Apply for Leave",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Divider(),
          
              vGap(10),
              _selectDropDownForValueForLeaves(controller),
              vGap(16),
              _startDateFromView(context,controller),
              vGap(16),
              _endDateFromView(context,controller),
          
              vGap(16),
              _reasonField(controller),
              vGap(16),
          
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Close"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.hitPostLeavesApiCall();
                    },
                    child: Text("Apply Leave"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _selectDropDownForValueForLeaves(LeaveReportViewScreenController controller) {
  return Obx(() => DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: "Leave Type",
      hintText: "Select Leave Type",
      border: OutlineInputBorder(),
    ),
    value: controller.selectedLeaveType.value,
    items: controller.leaveTypeOptions.map((val) {
      return DropdownMenuItem(
          value: val,
          child: Text(val)
      );
    }).toList(),
    onChanged: (value) {
      if (value != null && value != 'Select Leave Type') {
        controller.selectedLeaveType.value = value;
      }
    },
  ));
}

Widget _startDateFromView(BuildContext context, LeaveReportViewScreenController controller) {
  return TextFormField(
    controller: controller.startDateController,
    readOnly: true,
    onTap: (){_showDatePicker(context,controller);},
    decoration: InputDecoration(
      labelText: "Start Date",
      hintText: "YYYY-MM-DD",
      border: OutlineInputBorder(),
      suffixIcon: IconButton(
        icon: Icon(Icons.calendar_today),
        onPressed: () async {
          _showDatePicker(context,controller);
        },
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select a start date';
      }
      // Validate date format
      try {
        DateFormat('yyyy-MM-dd').parse(value);
      } catch (e) {
        return 'Invalid date format. Use YYYY-MM-DD';
      }
      return null;
    },
  );
}

Widget _endDateFromView(BuildContext context, LeaveReportViewScreenController controller) {
  return TextFormField(
    controller: controller.endDateController,
    readOnly: true,
    onTap: () {
      _showEndDatePicker(context, controller);
    },
    decoration: InputDecoration(
      labelText: "End Date",
      hintText: "YYYY-MM-DD",
      border: OutlineInputBorder(),
      suffixIcon: IconButton(
        icon: Icon(Icons.calendar_today),
        onPressed: () async {
          _showEndDatePicker(context, controller);
        },
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select an end date';
      }
      try {
        DateFormat('yyyy-MM-dd').parse(value);
      } catch (e) {
        return 'Invalid date format. Use YYYY-MM-DD';
      }
      return null;
    },
  );
}

_showEndDatePicker(BuildContext context, LeaveReportViewScreenController controller) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: controller.endDateController.text.isNotEmpty
        ? DateTime.parse(controller.endDateController.text)
        : DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    String formattedDate = '${pickedDate.year}'
        '-${pickedDate.month.toString().padLeft(2, '0')}'
        '-${pickedDate.day.toString().padLeft(2, '0')}';

    controller.endDateController.text = formattedDate;
  }
}

Widget _reasonField(LeaveReportViewScreenController controller) {
  return TextFormField(
    controller: controller.reasonController,
    maxLines: 3,
    decoration: InputDecoration(
      labelText: "Reason",
      hintText: "Enter the reason for leave",
      border: OutlineInputBorder(),
    ),
  );
}

 _showDatePicker(BuildContext context, LeaveReportViewScreenController controller)async{
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: controller.startDateController.text.isNotEmpty
        ? DateTime.parse(controller.startDateController.text)
        : DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    // Format the date in YYYY-MM-DD format
    String formattedDate = '${pickedDate.year}'
        '-${pickedDate.month.toString().padLeft(2, '0')}'
        '-${pickedDate.day.toString().padLeft(2, '0')}';

    controller.startDateController.text = formattedDate;
  }
}