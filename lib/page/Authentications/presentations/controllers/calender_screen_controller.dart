import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/holidays_calender_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';


class CalendarController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  final RxList<Result> selectedEventsResult = <Result>[].obs;
  final RxMap<DateTime, List<Result>> events = RxMap<DateTime, List<Result>>({});

  @override
  void onInit() {
    super.onInit();
    selectedDay.value = DateTime.now();
    hitHolidayApiCall();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay.value, selectedDay)) {
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = focusedDay;
      selectedEventsResult.value = getEventsForDay(selectedDay);
    }
  }

  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat.value != format) {
      calendarFormat.value = format;
    }
  }

  List<Result> getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void hitHolidayApiCall() {
    customLoader.show();
    Get.find<AuthenticationApiService>().holidaysCalenderApiCall().then((value) {
      if (value is HolidaysCalendarResponseModel) {
        for (var result in value.results) {
          _addEventFromApi(result);
        }
      }
      customLoader.hide();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void _addEventFromApi(Result holidayData) {
    try {
      if (holidayData.start == null || holidayData.end == null) return;

      final start = DateTime.parse(holidayData.start!);
      final end = DateTime.parse(holidayData.end!);

      // Add the event to all days between start and end
      for (var day = start;
      day.isBefore(end.add(const Duration(days: 1)));
      day = day.add(const Duration(days: 1))) {
        final dateKey = DateTime(day.year, day.month, day.day);
        events.update(dateKey, (existingEvents) {
          existingEvents.add(holidayData);
          return existingEvents;
        }, ifAbsent: () => [holidayData]);
      }

      // Update selected events if the current selected day has this event
      if (selectedDay.value != null) {
        selectedEventsResult.value = getEventsForDay(selectedDay.value!);
      }

      update();
    } catch (e) {
      print('Error adding event: $e');
    }
  }
}
