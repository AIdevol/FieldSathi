import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/technician_list_view_screen_controller.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class TechnicianListViewScreen extends GetView<TechnicianListViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<TechnicianListViewScreenController>(
        builder: (controller) => Scaffold(
          appBar: _buildAppBar(controller),
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(controller),
                // _buildStatistics(controller),
                _buildViewToggle(controller),
                Expanded(
                  child: controller.isTableView.value
                      ? _buildDataTableView(controller)
                      : _buildListView(controller),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: appColor,
            child: Icon(Icons.add, color: whiteColor),
            onPressed: () => Get.toNamed(AppRoutes.addtechnicianListScreen),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(TechnicianListViewScreenController controller) {
    return AppBar(
      backgroundColor: appColor,
      elevation: 0,
      title: Text(
        "Technician Management",
        style: MontserratStyles.montserratBoldTextStyle(
          size: 15,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => controller.refreshList(),
          icon: Icon(FontAwesomeIcons.rotate),
          tooltip: 'Refresh',
        ),
        IconButton(
          onPressed: (){} /*controller.showFilterOptions()*/,
          icon: Icon(FontAwesomeIcons.plus),
          tooltip: 'Filter',
        ),
      ],
    );
  }

  Widget _buildTopBar(TechnicianListViewScreenController controller) {
    return Container(
      height: Get.height * 0.07,
      width: Get.width,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: _buildSearchField()),
          hGap(10),
          ElevatedButton(
            onPressed: () {} /*_showImportModelView*/,
            style: _buttonStyle(),
            child: Text(
              'Import',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
          ),
          hGap(10),
          ElevatedButton(
            onPressed: () {
              // controller.exportData(); // Implement this method in your controller
            },
            child: Text(
              'Export',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
            style: _buttonStyle(),
          ),
          hGap(10),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: appColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black.withOpacity(0.5),
    );
  }
  Widget _buildSearchField() {
    return Container(
      height: Get.height * 0.05,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(FeatherIcons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        style: MontserratStyles.montserratSemiBoldTextStyle(
          color: Colors.black,
        ),
        onChanged: (value) {
          // controller.updateSearch(value); // Implement this method in your controller
        },
      ),
    );
  }
  // Widget _buildStatistics(TechnicianListViewScreenController controller) {
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     child: Row(
  //       children: [
  //         _statisticCard(
  //           'Total',
  //           controller.filteredTechnicians.length.toString(),
  //           FontAwesomeIcons.userGear,
  //           Colors.blue,
  //         ),
  //         SizedBox(width: 16),
  //         _statisticCard(
  //           'Active',
  //           controller.activeTechnicians.toString(),
  //           FontAwesomeIcons.userCheck,
  //           Colors.green,
  //         ),
  //         SizedBox(width: 16),
  //         _statisticCard(
  //           'On Leave',
  //           controller.techniciansOnLeave.toString(),
  //           FontAwesomeIcons.userClock,
  //           Colors.orange,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildViewToggle(TechnicianListViewScreenController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ToggleButtons(
            onPressed: (int index) {
              controller.toggleView(index == 1);
            },
            isSelected: [!controller.isTableView.value, controller.isTableView.value],
            borderRadius: BorderRadius.circular(8),
            selectedColor: whiteColor,
            fillColor: appColor,
            color: Colors.grey,
            constraints: BoxConstraints(minHeight: 36, minWidth: 64),
            children: [
              Icon(Icons.view_list),
              Icon(Icons.grid_on),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildListView(TechnicianListViewScreenController controller) {
    return RefreshIndicator(
      onRefresh: () async => controller.refreshList(),
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: controller.filteredTechnicians.length,
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final technician = controller.filteredTechnicians[index];
          return _buildTechnicianCard(technician, controller);
        },
      ),
    );
  }

  Widget _buildDataTableView(TechnicianListViewScreenController controller) {
    return RefreshIndicator(
      onRefresh: () async => controller.refreshList(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              headingRowColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => Colors.grey.shade50,
              ),
              columnSpacing: 20,
              columns: [
                DataColumn(
                  label: Text(
                    'Name',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Email',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Contact',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Joining Date',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Casual Leaves',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Sick Leaves',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Check In',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Check Out',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Attendance Status',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Battery',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'GPS',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Actions',
                    style: MontserratStyles.montserratBoldTextStyle(size: 14),
                  ),
                ),
              ],
              rows: controller.filteredTechnicians.map((technician) {
                // Get attendance data for this technician
                final attendance = technician.todayAttendance;

                return DataRow(
                  cells: [
                    DataCell(Text("${technician.firstName} ${technician.lastName}")),
                    DataCell(Text(technician.email)),
                    DataCell(Text(technician.phoneNumber)),
                    DataCell(Text(technician.dateJoined ?? '-')),
                    DataCell(Text(technician.allocatedCasualLeave.toString())),
                    DataCell(Text(technician.allocatedSickLeave.toString())),
                    // Check-in cell with formatted time
                    DataCell(Text(attendance?.checkIn != null
                        ? _formatDateTime(attendance!.checkIn!)
                        : '-')),
                    // Check-out cell with formatted time
                    DataCell(Text(attendance?.checkOut != null
                        ? _formatDateTime(attendance!.checkOut!)
                        : '-')),
                    // Attendance status cell
                    DataCell(_buildAttendanceStatusBadge(attendance?.status ?? '')),
                    DataCell(_buildBatteryIndicator(technician.batteryStatus ?? '')),
                    DataCell(_buildGpsStatus(technician.gpsStatus)),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, size: 20),
                            onPressed: () {},
                            color: Colors.blue,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, size: 20),
                            onPressed: (){} /*controller.deleteTechnician(technician)*/,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

// Helper method to format date time
  String _formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateTimeStr;
    }
  }

// Updated status badge specifically for attendance status
  Widget _buildAttendanceStatusBadge(String status) {
    Color color;
    String displayText = status;

    switch (status.toLowerCase()) {
      case 'present':
        color = Colors.green;
        break;
      case 'absent':
        color = Colors.red;
        break;
      case 'late':
        color = Colors.orange;
        break;
      case 'on_leave':
        color = Colors.blue;
        displayText = 'On Leave';
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

// Updated battery indicator with proper icon selection
  Widget _buildBatteryIndicator(String batteryStatus) {
    Color color;
    IconData icon;

    try {
      final batteryLevel = int.tryParse(batteryStatus.replaceAll('%', '')) ?? 0;

      if (batteryLevel <= 20) {
        color = Colors.red;
        icon = Icons.battery_alert;
      } else if (batteryLevel <= 50) {
        color = Colors.orange;
        icon = Icons.battery_4_bar;
      } else {
        color = Colors.green;
        icon = Icons.battery_full;
      }
    } catch (e) {
      color = Colors.grey;
      icon = Icons.battery_unknown;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        Text(' $batteryStatus', style: TextStyle(color: color)),
      ],
    );
  }

  Widget _buildGpsStatus(bool? isActive) {
    Color color = isActive == true ? Colors.green : Colors.red;
    IconData icon = isActive == true ? Icons.gps_fixed : Icons.gps_off;

    return Icon(icon, color: color, size: 16);
  }

  Widget _buildTechnicianCard(dynamic technician, TechnicianListViewScreenController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {}/*controller.showTechnicianDetails(technician)*/,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: appColor.withOpacity(0.1),
                    child: Text(
                      technician.name[0].toUpperCase(),
                      style: TextStyle(color: appColor),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          technician.name,
                          style: MontserratStyles.montserratBoldTextStyle(
                            size: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          technician.specialization ?? 'No specialization',
                          style: MontserratStyles.montserratRegularTextStyle(
                            size: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildBatteryIndicator(technician.batteryStatus),
                  SizedBox(width: 8),
                  _buildGpsStatus(technician.gpsStatus),
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    onSelected: (value){} /*_handleTechnicianAction(value, technician, controller)*/,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    '${technician.checkInTime ?? 'No check-in'} - ${technician.checkOutTime ?? 'No check-out'}',
                    style: MontserratStyles.montserratRegularTextStyle(
                      size: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  // _buildStatusBadge(technician.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _statisticCard(String title, String value, Icon
}