import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final bool isHoliday;

  Event(this.title, this.description, {this.isHoliday = false});
}

class CalenderViewAmcController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  final RxList<Event> selectedEvents = <Event>[].obs;

  final Map<DateTime, List<Event>> events = {};

  @override
  void onInit() {
    super.onInit();
    _addHolidays();
  }

  void _addHolidays() {
    // Add some example holidays
    _addEvent(DateTime(2024, 1, 1), 'New Year\'s Day', 'Holiday', isHoliday: true);
    _addEvent(DateTime(2024, 7, 4), 'Independence Day', 'Holiday', isHoliday: true);
    _addEvent(DateTime(2024, 12, 25), 'Christmas Day', 'Holiday', isHoliday: true);
    // Add more holidays as needed
  }

  void _addEvent(DateTime date, String title, String description, {bool isHoliday = false}) {
    final event = Event(title, description, isHoliday: isHoliday);
    if (events[date] == null) {
      events[date] = [event];
    } else {
      events[date]!.add(event);
    }
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
}