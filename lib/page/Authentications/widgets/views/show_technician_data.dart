import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import '../../../../response_models/user_response_model.dart';
import '../controller/show_technician_data_controller.dart';

class TechniciansFullViewDetailsDescriptionScreen extends GetView<ShowTechnicianDataController> {
  const TechniciansFullViewDetailsDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<ShowTechnicianDataController>(
        init: ShowTechnicianDataController(),
        builder: (controller) => Scaffold(
          backgroundColor: CupertinoColors.white,
          bottomNavigationBar: _buildPaginationControls(controller),
          appBar: AppBar(
            backgroundColor: appColor,
            title: Text(
              'All Attendance Lists',
              style: MontserratStyles.montserratBoldTextStyle(
                  size: 18,
                  color: Colors.black
              ),
            ),
          ),
          body: _mainScreen(controller),
        ),
      ),
    );
  }

  Widget _searchBar(ShowTechnicianDataController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: controller.filterMembers,
        decoration: InputDecoration(
          hintText: 'Search by name or employee ID',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: appColor),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
    );
  }

  Widget _mainScreen(ShowTechnicianDataController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return  Center(child: CircularProgressIndicator());
      }

      final members = controller.filteredMembers;

      return Column(
        children: [
          _searchBar(controller),
          Expanded(
            child: members.isEmpty
                ? const Center(child: Text('No matching team members found'))
                : SingleChildScrollView(
              child: _buildDataTable(controller, members),
            ),
          ),
        ],
      );
    });
  }

  String _getRoleDisplay(String? role) {
    if (role == null) return 'N/A';

    switch (role.toLowerCase()) {
      case 'agent':
        return 'Executive';
      case 'superuser':
        return 'Manager';
      default:
        return role;
    }
  }

  Widget _buildDataTable(ShowTechnicianDataController controller, List<dynamic> members) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("  ")),
          DataColumn(label: Text("Employee Id")),
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Role")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text(" ")),
        ],
        rows: controller.attendancePaginationData.map((member) => DataRow(
          cells: [
            DataCell(
              CircleAvatar(
                backgroundImage: member.profileImage != null && member.profileImage!.isNotEmpty
                    ? NetworkImage(member.profileImage!) as ImageProvider
                    : AssetImage(userImageIcon),
              ),
            ),
            DataCell(_ticketBoxIcons("${member.empId}")),
            DataCell(Text("${member.firstName} ${member.lastName}")),
            DataCell(Text(_getRoleDisplay(member.role))),
            DataCell(Text(member.isActive == true ? 'Active' : 'Inactive')),
            DataCell(_buildCalenderButton(controller, member.id.toString())),
          ],
        )).toList(),
      ),
    );
  }

  Widget _buildPaginationControls(ShowTechnicianDataController controller) {
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

  Widget _ticketBoxIcons(String empId) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: normalBlue,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.blue.shade300,
            width: 1,
          ),
        ),
        child: Text(
          empId,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Calendar button build method
  Widget _buildCalenderButton(ShowTechnicianDataController controller, String attendanceid) {
    return IconButton(
      onPressed: () {
        Get.dialog(
          _CalendarViews(controller, attendanceid),
          barrierDismissible: true,
        );
        controller.hitGetUserAttendanceApiCall(attendanceid);
      },
      icon: Icon(Icons.calendar_month),
    );
  }

  // Calendar Views Dialog
  Widget _CalendarViews(ShowTechnicianDataController controller, String attendanceid) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Color(
                    int.parse(controller.color.value.replaceAll('#', '0xFF')),
                  ),
                  size: 30,
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Calendar
            TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: controller.selectedDate.value,
              currentDay: DateTime.now(),
              selectedDayPredicate: (day) =>
                  isSameDay(controller.selectedDate.value, day),
              onDaySelected: (selectedDay, focusedDay) {
                controller.selectedDate.value = selectedDay;
                controller.update();
              },
              calendarStyle: CalendarStyle(
                defaultTextStyle: const TextStyle(color: Colors.black),
                markerDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                // Custom day builder to show attendance status
                defaultBuilder: (context, date, _) {
                  // Null-safe approach to find attendance record
                  var attendanceRecord = controller.userAttendanceData.firstWhereOrNull(
                          (record) => record.date != null &&
                          isSameDay(DateTime.parse(record.date!), date)
                  );

                  Color? backgroundColor;
                  Color textColor = Colors.black;

                  if (attendanceRecord != null) {
                    switch (attendanceRecord.status?.toLowerCase()) {
                      case 'present':
                        backgroundColor = Colors.green.withOpacity(0.2);
                        textColor = Colors.green;
                        break;
                      case 'absent':
                        backgroundColor = Colors.red.withOpacity(0.2);
                        textColor = Colors.red;
                        break;
                      case 'idle':
                        backgroundColor = Colors.orange.withOpacity(0.2);
                        textColor = Colors.orange;
                        break;
                      default:
                        backgroundColor = null;
                    }
                  }

                  return Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: backgroundColor,
                    ),
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: backgroundColor != null
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Present', Colors.green.withOpacity(0.2)),
                const SizedBox(width: 20),
                _buildLegendItem('Absent', Colors.red.withOpacity(0.2)),
                const SizedBox(width: 20),
                _buildLegendItem('Idle', Colors.orange.withOpacity(0.2)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Legend item build method
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}