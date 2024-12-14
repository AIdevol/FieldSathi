import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controllers/forTechnicianAndSalesLeavesScreenController.dart';

class FortechcnicianandsalesAttendancescreeen extends GetView<ForTechcnicianandsalesAttendanceScreeenController> {
  const FortechcnicianandsalesAttendancescreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(child: GetBuilder<ForTechcnicianandsalesAttendanceScreeenController>(
        init: ForTechcnicianandsalesAttendanceScreeenController(),
        builder: (controller)=>
    Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          "Attendance",
          style: MontserratStyles.montserratBoldTextStyle(
            size: 15,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    "Welcome, ${controller.userName.value}",
                    style: MontserratStyles.montserratBoldTextStyle(size: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Punch In/Out Section
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: controller.isPunchInSelected.value,
                            onChanged: (value) => controller.togglePunchInOut(true),
                          ),
                          Text(
                            "Punch In",
                            style: MontserratStyles.montserratBoldTextStyle(
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Radio<bool>(
                            value: false,
                            groupValue: controller.isPunchInSelected.value,
                            onChanged: (value) => controller.togglePunchInOut(false),
                          ),
                          Text(
                            "Punch Out",
                            style: MontserratStyles.montserratBoldTextStyle(
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )),
                      Obx(() => ElevatedButton(
                        onPressed: controller.punchInOrOut,
                        style: _buttonStyle(),
                        child: Text(
                          controller.isPunchInSelected.value ? "PUNCH IN" : "PUNCH OUT",
                          style: MontserratStyles.montserratBoldTextStyle(size: 12),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // History Section Header
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    "Punch-In/Punch-Out History",
                    style: MontserratStyles.montserratBoldTextStyle(size: 15),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              // Updated Calendar with attendance data
        TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) {
            // Check if the day exists in attendance data
            return controller.attendanceData.any((attendance) {
              if (attendance.date != null) {
                final attendanceDate = DateTime.parse(attendance.date!);
                return isSameDay(attendanceDate, day);
              }
              return false;
            });
          },
          onDaySelected: (selectedDay, focusedDay) {
            final attendance = controller.attendanceData.firstWhereOrNull(
                    (attendance) => attendance.date != null &&
                    isSameDay(DateTime.parse(attendance.date!), selectedDay)
            );

            if (attendance != null) {
              print("adfadfadfadf: ${attendance.punchIn}");
              Get.dialog(
                AlertDialog(
                  title: Text('Attendance Details',style: MontserratStyles.montserratBoldTextStyle(size: 20, color: Colors.black),),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${attendance.date}', style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.black),),
                      Text('Status: ${attendance.status ?? "N/A"}',style: MontserratStyles.montserratBoldTextStyle(size: 12, color: Colors.grey),),
                      Text('Check In: ${attendance.punchIn ?? "N/A"}',style: MontserratStyles.montserratBoldTextStyle(size: 12, color: Colors.grey),),
                      Text('Check Out: ${attendance.punchOut ?? "N/A"}',style: MontserratStyles.montserratBoldTextStyle(size: 12, color: Colors.grey),),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      child: Text('Close'),
                      style: _buttonStyle(),
                    ),
                  ],
                ),
              );
            }
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              // Find attendance for this date
              final attendance = controller.attendanceData.firstWhereOrNull(
                      (attendance) => attendance.date != null &&
                      isSameDay(DateTime.parse(attendance.date!), date)
              );

              if (attendance != null) {
                return Positioned(
                  bottom: 1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: attendance.status == 'completed'
                          ? Colors.green
                          : attendance.status == 'active'
                          ? Colors.orange
                          : Colors.red,
                    ),
                  ),
                );
              }
              return null;
            },
          ),
        ),
              const SizedBox(height: 20.0),

              // Export Button
              ElevatedButton(
                onPressed: controller.exportAttendance,
                style: _buttonStyle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.download, size: 25),
                    Text(
                      "EXPORT ATTENDANCE",
                      style: MontserratStyles.montserratBoldTextStyle(size: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
    )
    );
  }
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
