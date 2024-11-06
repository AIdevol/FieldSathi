import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/response_models/holidays_calender_response_model.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controllers/calender_screen_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      init: CalendarController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
              'Calendar',
              style: MontserratStyles.montserratBoldTextStyle(
                  color: blackColor,
                  size: 15
              )
          ),
          backgroundColor: appColor,
        ),
        body: Column(
          children: [
            Obx(() => TableCalendar<Result>(
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
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return null;

                  return Positioned(
                    right: 1,
                    top: 0,
                    child: _buildHolidayMarker(
                        Color(int.parse(events.first.color?.replaceAll('#', '0xFF') ?? 'FF0000'))
                    ),
                  );
                },
              ),
            )),
            vGap(20),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.selectedEventsResult.length,
                itemBuilder: (BuildContext context, index) {
                  final event = controller.selectedEventsResult[index];
                  final startDate = DateTime.parse(event.start!);
                  final endDate = DateTime.parse(event.end!);

                  return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(
                      title: Text(
                        event.title ?? '',
                        style: MontserratStyles.montserratBoldTextStyle(
                            color: blackColor,
                            size: 15
                        ),
                      ),
                      subtitle: Text(
                          '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
                          style: MontserratStyles.montserratNormalTextStyle(
                              color: blackColor,
                              size: 15
                          )
                      ),
                      leading: Icon(
                        Icons.celebration,
                        color: Color(
                            int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')
                        ),
                      ),
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
