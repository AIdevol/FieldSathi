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
        return  Center(child: Container());
      }

      // Use filtered members instead of directly filtering here
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
        rows: members.map((member) => DataRow(
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
}


_buildCalenderButton(ShowTechnicianDataController controller, attendanceid) {
  return IconButton(
      onPressed: () {
        Get.dialog(_CalendarViews(controller, attendanceid),
          barrierDismissible: true,);
        controller.hitGetUserAttendanceApiCall(attendanceid);
      },
      icon: Icon(Icons.calendar_month)
  );
}

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
            calendarStyle: const CalendarStyle(
              defaultTextStyle: TextStyle(color: Colors.black),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              markerSize: 8,
              markersMaxCount: 1,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                bool isPresent = controller.attendanceDatas[date] == true;
                bool isAbsent = controller.attendanceDatas[date] == false;
                String? attendanceDate = controller.getAttendanceDateForDay(date);
                return Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isAbsent
                        ? Colors.red.withOpacity(0.2)
                        : isPresent
                        ? Colors.green.withOpacity(0.2)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          color: isAbsent
                              ? Colors.red
                              : isPresent
                              ? Colors.green
                              : Colors.black,
                        ),
                      ),
                      if (attendanceDate != null)
                        Text(
                          attendanceDate,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                    ],
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
            ],
          ),
        ],
      ),
    ),
  );
}

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