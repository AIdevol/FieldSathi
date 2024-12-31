import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/response_models/leaves_history_response_model.dart';
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
          floatingActionButton: _buildFloatingActionButton(context, controller),
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
              // if(userrole != 'technician'&&userrole !='sale')
              // IconButton(
              //   icon: Icon(Icons.add, size: 30),
              //   onPressed: () => Get.toNamed(AppRoutes.leaveUpdateScreen),
              // )
              // else
              //   _viewDetailsButton(context, controller),
              hGap(10)
            ],
          ),
            // userrole != 'technician'&&userrole != 'sales'
          body: userrole != 'technician'&&userrole != 'sales'?
        RefreshIndicator(
            onRefresh: () => controller.hitRefreshApiCall(),
            child: Column(
              children: [
                _buildTopBar(context),
                _buildSearchBar(),

                Expanded(
                  child: Obx(
                        () =>/* (userrole != "technician"&& userrole != 'sales')?*/
                        controller.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : controller.leavesPaginationsData.isEmpty
                        ? _buildEmptyState()
                        : _buildDataTable(context)
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
  Widget _buildFloatingActionButton(BuildContext context, LeaveReportViewScreenController controller) {
    final userrole = storage.read(userRole);

    if (userrole != 'technician' && userrole != 'sale') {
      return SizedBox(
        height: 140,  // Adjust this height as needed
        child: Stack(
          children: [
            // Bottom FAB - Add button
            Positioned(
              bottom: 0,
              right: 0,
              child: FloatingActionButton(
                heroTag: "Allows Leaves",
                onPressed: () => Get.toNamed(AppRoutes.leaveUpdateScreen),
                backgroundColor: appColor,
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
            // Top FAB - Eye button
            Positioned(
              bottom: 70,  // Adjust this value to change the distance between buttons
              right: 0,
              child: FloatingActionButton(
                heroTag: "User Leave Data",
                onPressed: () {
                  Get.toNamed(AppRoutes.userLeavesDataScreen);
                },
                backgroundColor: appColor,
                child: Icon(Icons.remove_red_eye, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          _leavesTypesApplicationViewScreen(context, controller);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor,
          minimumSize: Size(120, 40),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: CupertinoColors.white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Apply Leave",
          style: MontserratStyles.montserratBoldTextStyle(
            color: CupertinoColors.white,
            size: 13,
          ),
        ),
      );
    }
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: _buildFilterDropdown(),
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

  Widget _buildDataTable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(

          padding: EdgeInsets.all(16),
          child: Obx(() {
            final filteredData = controller.leavesPaginationsData;
            return DataTable(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade400),
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
                // DataColumn(label: Text('.')),
                DataColumn(label: Text('EmpId/Name')),
                DataColumn(label: Text('Phone No')),
                DataColumn(label: Text('Profile')),
                DataColumn(label: Text('Leave Type')),
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
                    onSelectChanged: (selected){
                      if(selected != null){
                        showLeavesHistoryDialog(context,controller,leave);
                      }
                    },
                    cells: [
                      // DataCell(Text('${index + 1}')),
                      DataCell(_ticketBoxIcons(leave.id.toString(),leave)),
                      DataCell(Text(leave.userId?.phoneNumber ?? '')),
                      DataCell(Text(leave.userId?.role ?? '')),
                      DataCell(Text(leave.leaveType ?? '')),
                      DataCell(Text(_formatDate(leave.startDate.toString()))),
                      DataCell(Text(_formatDate(leave.endDate.toString()))),
                      DataCell(Text(controller.calculateDays(
                        DateTime.parse(leave.startDate.toString() ?? ''),
                        DateTime.parse(leave.endDate.toString()?? ''),
                      ).toString())),
                      DataCell(Text(leave.reason ?? '')),
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

// _viewDetailsButton(BuildContext context, LeaveReportViewScreenController controller) {
//   return ElevatedButton(onPressed: () {
//     _leavesTypesApplicationViewScreen(context,controller);
//
//   },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: appColor,
//         minimumSize: Size(120, 40),
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: CupertinoColors.white),
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: Text("Apply Leave",style: MontserratStyles.montserratBoldTextStyle(
//         color: CupertinoColors.white,
//         size: 13,)));
// }

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
              DataColumn(label: Text('Phone No')),
              DataColumn(label: Text('Profile')),
              DataColumn(label: Text('Leave Type')),
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
                final leavesType = controller.leavesData;
                return DataRow(
                  onSelectChanged: (selected){
                    if(selected != null){
                      showLeavesHistoryDialog(context,controller,leave);
                    }
                  },
                  cells: [
                    DataCell(Text('${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}')),
                    DataCell(Text(leave.userId?.phoneNumber ?? '')),
                    DataCell(Text(leave.userId?.role ?? '')),
                    DataCell(Text(leavesType[index].leaveType ?? '')),
                    DataCell(Text(leave.startDate.toString())),
                    DataCell(Text(leave.endDate.toString())),
                    DataCell(Text(controller.calculateDays(
                      DateTime.parse(leave.startDate.toString() ?? ''),
                      DateTime.parse(leave.endDate.toString()?? ''),
                    ).toString())),
                    DataCell(Text(leave.reason ?? 'N/A')),
                    DataCell(_buildStatusView(leave)),
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

_buildStatusView(LeaveResult element) {
  Color getStatusColor() {
    switch (element.status?.toLowerCase()) {
      case 'ongoing':
        return Colors.amber;
      case 'completed':
        return Colors.blue;
      case 'on hold':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'inactive':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  return Container(
    height: 24,
    width: 80,
    decoration: BoxDecoration(
      color: getStatusColor().withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: getStatusColor(),
        width: 1,
      ),
    ),
    child: Center(
      child: Text(
        element.status ?? 'N/A',
        style: TextStyle(
          color: getStatusColor(),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      minimumSize: Size(120, 40),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: CupertinoColors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Close"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.hitPostLeavesApiCall();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      minimumSize: Size(120, 40),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: CupertinoColors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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

// Dialog Widget
Future<void> showLeavesHistoryDialog(
    BuildContext context,
    LeaveReportViewScreenController controller,
    LeaveResult leavesData,
    ) {
  return showDialog(
    context: context,
    builder: (context) => LeaveHistoryDialog(
      controller: controller,
      leavesData: leavesData,
    ),
  );
}

class LeaveHistoryDialog extends StatelessWidget {
  final LeaveReportViewScreenController controller;
  final LeaveResult leavesData;

  const LeaveHistoryDialog({
    Key? key,
    required this.controller,
    required this.leavesData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _buildHeader(),
            _buildInfoCard(),
            _buildHistorySection(),
            const Spacer(),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              leavesData.createdBy ?? 'Unknown',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              leavesData.status ?? 'Unknown',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow('Start Date:', leavesData.startDate?.toString()),
            _buildInfoRow('End Date:', leavesData.endDate?.toString()),
            _buildInfoRow('Created By:', leavesData.createdBy),
            _buildInfoRow('Leave Type:', leavesData.leaveType),
            _buildInfoRow('Reason:', leavesData.reason),
            _buildInfoRow('Created At:', leavesData.createdAt?.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value ?? 'Not available',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.history),
                SizedBox(width: 8),
                Text(
                  'Progress History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Obx(() => _buildHistoryList()),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    if (controller.leaveHistoryData.isEmpty) {
      return const Center(
        child: Text(
          'No history data available',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.leaveHistoryData.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final history = controller.leaveHistoryData[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              history.actionBy ?? 'Unknown',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              history.changeTimestamp?.toString() ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              history.actionMessage ?? '',
              style: const TextStyle(color: Colors.blue),
            ),
            if (history.fieldChanges.isNotEmpty) ...[
              const SizedBox(height: 4),
              ...history.fieldChanges.map(
                    (change) => Text(
                  change,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton.icon(
          onPressed: Get.back,
          icon: const Icon(Icons.close),
          label: const Text('Close'),
          style: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _ticketBoxIcons(String ticketId,LeaveResult leaves) {
  return Center(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal:8, vertical: 4),
          decoration: BoxDecoration(
            color: normalBlue,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.blue.shade300,
              width: 1,
            ),
          ),
          child: Text(
            '$ticketId',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        Text("${leaves.userId!.firstName! + leaves.userId!.lastName!}",style: MontserratStyles.montserratSemiBoldTextStyle(size: 12, color: Colors.black),)
      ],
    ),
  );
}