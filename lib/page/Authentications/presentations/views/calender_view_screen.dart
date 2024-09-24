import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controllers/calender_screen_controller.dart';

class Holiday {
  final DateTime date;
  final String name;

  Holiday(this.date, this.name);
}

class CalendarView extends GetView<CalendarController> {
  final List<Holiday> holidays = [
    Holiday(DateTime(2024, 9, 20), 'Holi'),
    Holiday(DateTime(2024, 10, 2), 'Gandhi Jayanti'),
    Holiday(DateTime(2024, 9, 22), 'Occasional leaves'),
    Holiday(DateTime(2024, 12, 25), 'Christmas'),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Calendar',
              style: MontserratStyles.montserratBoldTextStyle(
                  color: blackColor, size: 15)),
          backgroundColor: appColor,
        ),
        body: Column(
          children: [
            Obx(() => TableCalendar<Holiday>(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: controller.focusedDay.value,
              calendarFormat: controller.calendarFormat.value,
              selectedDayPredicate: (day) {
                return isSameDay(controller.selectedDay.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                controller.onDaySelected(selectedDay, focusedDay);
              },
              onFormatChanged: (format) {
                controller.onFormatChanged(format);
              },
              eventLoader: (day) {
                return holidays
                    .where((holiday) => isSameDay(holiday.date, day))
                    .toList();
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      right: 1,
                      top: 0,
                      child: _buildHolidayMarker(),
                    );
                  }
                  return null;
                },
              ),
            )),
          vGap(20),
            Expanded(
              child: ListView.builder(
                itemCount: holidays.length,
                itemBuilder: (BuildContext context, index) {
                  final holiday = holidays[index];
                  return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(
                      title: Text(holiday.name,style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),),
                      subtitle: Text(
                          '${holiday.date.day}/${holiday.date.month}/${holiday.date.year}',
                          style: MontserratStyles.montserratNormalTextStyle(color: blackColor, size: 15)),
                      leading: Icon(Icons.celebration, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHolidayMarker() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      width: 8.0,
      height: 8.0,
    );
  }
}
