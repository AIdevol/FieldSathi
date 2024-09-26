import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controllers/calender_screen_controller.dart';

class CalendarView extends GetView<CalendarController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      init: CalendarController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Calendar',
              style: MontserratStyles.montserratBoldTextStyle(
                  color: blackColor, size: 15)),
          backgroundColor: appColor,
        ),
        body: Column(
          children: [
            Obx(() => TableCalendar<Event>(
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
                return controller.getEventsForDay(day);
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
                      child: _buildHolidayMarker(events.first.color),
                    );
                  }
                  return null;
                },
              ),
            )),
            vGap(20),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.selectedEvents.length,
                itemBuilder: (BuildContext context, index) {
                  final event = controller.selectedEvents[index];
                  return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(
                      title: Text(event.title,
                        style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
                      ),
                      subtitle: Text(
                          '${event.start.day}/${event.start.month}/${event.start.year} - ${event.end.day}/${event.end.month}/${event.end.year}',
                          style: MontserratStyles.montserratNormalTextStyle(color: blackColor, size: 15)
                      ),
                      leading: Icon(Icons.celebration, color: event.color),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHolidayMarker(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 8.0,
      height: 8.0,
    );
  }
}