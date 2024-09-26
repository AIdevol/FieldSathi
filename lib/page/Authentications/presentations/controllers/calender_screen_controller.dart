import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class Event {
  final String title;
  final String description;
  final bool isHoliday;
  final Color color;
  final DateTime start;
  final DateTime end;

  Event(this.title, this.description, {
    this.isHoliday = false,
    required this.color,
    required this.start,
    required this.end,
  });
}

class CalendarController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  final RxList<Event> selectedEvents = <Event>[].obs;

  final RxMap<DateTime, List<Event>> events = <DateTime, List<Event>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    hitHolidayApiCall();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay.value, selectedDay)) {
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = focusedDay;
      selectedEvents.value = getEventsForDay(selectedDay);
    }
  }

  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat.value != format) {
      calendarFormat.value = format;
    }
  }

  List<Event> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void onEventTapped(Event event) {
    print('Event tapped: ${event.title}');
  }

  void deleteEvent(Event event) {
    selectedEvents.remove(event);
    events.forEach((key, value) {
      value.remove(event);
    });
    update();
  }

  void hitHolidayApiCall() {
    customLoader.show();
    Get.find<AuthenticationApiService>().holidaysCalenderApiCall().then((value) {
      _addEventFromApi(value);
      print("calender id: ${value.id}");
      customLoader.hide();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void _addEventFromApi(dynamic calendarData) {
    final start = DateTime.parse(calendarData.start);
    final end = DateTime.parse(calendarData.end);
    final event = Event(
      calendarData.title,
      'Holiday',
      isHoliday: true,
      color: Color(int.parse(calendarData.color.replaceAll('#', '0xFF'))),
      start: start,
      end: end,
    );

    // Add the event to all days between start and end
    for (var day = start; day.isBefore(end.add(Duration(days: 1))); day = day.add(Duration(days: 1))) {
      if (events[day] == null) {
        events[day] = [event];
      } else {
        events[day]!.add(event);
      }
    }

    update();
  }
}