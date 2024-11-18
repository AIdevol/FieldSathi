import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../utilities/google_fonts_textStyles.dart';
import '../controllers/forTechnicianAndSalesLeavesScreenController.dart';

class FortechcnicianandsalesAttendancescreeen extends GetView<ForTechcnicianandsalesAttendanceScreeenController> {
  const FortechcnicianandsalesAttendancescreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor, // Replace with your appColor
        title:  Text("Attendance",style: MontserratStyles.montserratBoldTextStyle(
          size: 15,
          color: Colors.black,
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Section
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    "Welcome, User!",
                    style: MontserratStyles.montserratBoldTextStyle(
                      size: 15,
                      // color: Colors.black,
                    ),
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
                           Text("Punch In",style: MontserratStyles.montserratBoldTextStyle(
                            size: 15,
                            color: Colors.black,
                          ),),
                          const SizedBox(width: 20),
                          Radio<bool>(
                            value: false,
                            groupValue: controller.isPunchInSelected.value,
                            onChanged: (value) => controller.togglePunchInOut(false),
                          ),
                           Text("Punch Out",style: MontserratStyles.montserratBoldTextStyle(
                             size: 15,
                             color: Colors.black,
                           ),),
                        ],
                      )),
                      Obx(() => ElevatedButton(
                        onPressed: controller.punchInOrOut,
                        style: _buttonStyle(),
                        child: Text(
                          controller.isPunchInSelected.value ? "PUNCH IN" : "PUNCH OUT",
                          style: MontserratStyles.montserratBoldTextStyle(
                            size: 12,
                            // color: Colors.black,
                          ),
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
                child:  Center(
                  child: Text(
                    "Punch-In/Punch-Out History",
                    style: MontserratStyles.montserratBoldTextStyle(
                      size: 15,
                      // color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              // Calendar
             TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) =>
                    controller.selectedDates.contains(day),
                onDaySelected: (selectedDay, focusedDay) {
                  if (!controller.selectedDates.contains(selectedDay)) {
                    controller.selectedDates.add(selectedDay);
                  }
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
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
                  Icon(FontAwesomeIcons.download, size: 25,),
                   Text("EXPORT ATTENDANCE",style: MontserratStyles.montserratBoldTextStyle(
                     size: 15,
                     // color: Colors.black,
                   ),)]),
              ),
            ],
          ),
        ),
      ),
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