import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
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
          body: _mainScreen(context, controller),
        ),
      ),
    );
  }

  Widget _searchBar(ShowTechnicianDataController controller) {
    return Container(
      width: Get.width * 0.6,
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

  Widget _mainScreen(BuildContext context, ShowTechnicianDataController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      final members = controller.filteredMembers;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildStatusFilterDropdown(context, controller)),
                hGap(10),
                _searchBar(controller),
              ],
            ),
          ),
          Expanded(
            child: members.isEmpty
                ? const Center(child: Text('No matching team members found'))
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.attendancePaginationData.length,
                itemBuilder: (context, index) {
                  final member = controller.attendancePaginationData[index];
                  return _buildMemberCard(controller, member);
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildMemberCard(ShowTechnicianDataController controller, dynamic member) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Changed to min
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 35, // Slightly reduced size
                        backgroundImage: member.profileImage != null && member.profileImage!.isNotEmpty
                            ? NetworkImage(member.profileImage!) as ImageProvider
                            : AssetImage(userImageIcon),
                      ),
                      Container(
                        padding: EdgeInsets.all(4), // Slightly reduced padding
                        decoration: BoxDecoration(
                          color: member.isActive == true ? Colors.red : Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          member.isActive == true ? Icons.close:Icons.check ,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 18), // Reduced spacing

                  // SizedBox(height: 4), // Reduced spacing
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2), // Reduced padding
                  //   decoration: BoxDecoration(
                  //     color: normalBlue.withOpacity(0.1),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Text(
                  //     "${member.empId}",
                  //     style: TextStyle(
                  //       color: normalBlue,
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 11, // Reduced font size
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 4), // Reduced spacing

                  // SizedBox(height: 4), // Reduced spacing

                ],
              ),
            ),
            Positioned(
              top: 85,
              left: 5,
              child: Text(
              "${member.firstName} ${member.lastName}",
              style: MontserratStyles.montserratBoldTextStyle(size: 17,color: Colors.black),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),),
            Positioned(
              top: 110,
              left: 5,
              child: Text(
                "Role: ${_getRoleDisplay(member.role)}",
                style: MontserratStyles.montserratSemiBoldTextStyle(color: Colors.grey,size: 15)
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Get.dialog(
                    _CalendarViews(controller, member.id.toString()),
                    barrierDismissible: true,
                  );
                  controller.hitGetUserAttendanceApiCall(member.id.toString());
                },
                icon: Icon(Icons.calendar_month, color: appColor, size: 30), // Reduced icon size
                padding: EdgeInsets.zero, // Removed padding from IconButton
                constraints: BoxConstraints(), // Minimal constraints
              ),)
          ],
        ),
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

  Widget _buildStatusFilterDropdown(BuildContext context, ShowTechnicianDataController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
            () => DropdownButton<String>(
          value: controller.selectedValue.value,
          isExpanded: true,
          underline: Container(),
          items: controller.filterStatusValue.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 13,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: controller.updateSelectedStatusFilter,
        ),
      ),
    );
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
                defaultBuilder: (context, date, _) {
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