import 'dart:math';

import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/holidays_calender_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import '../../../../constans/const_local_keys.dart';
import '../../../../utilities/google_fonts_textStyles.dart';

class CalendarController extends GetxController {
  final RxBool isLoading = true.obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  final RxList<Result> selectedEventsResult = <Result>[].obs;
  final RxMap<DateTime, List<Result>> events = RxMap<DateTime, List<Result>>({});
  final RxList<Result> allEvents = <Result>[].obs;
  final RxBool isHolidayValid = true.obs;
  final RxString holidayError = ''.obs;

  // Map to store TextEditingController for each holiday
  final RxMap<String, TextEditingController> holidayControllers = RxMap<String, TextEditingController>({});
  final List<String> _holidayColors = [
    '#FF5252', // Red
    '#448AFF', // Blue
    '#66BB6A', // Green
    '#FFA726', // Orange
    '#AB47BC', // Purple
    '#26A69A', // Teal
    '#EC407A', // Pink
    '#7E57C2', // Deep Purple
    '#FFB300', // Amber
    '#26C6DA', // Cyan
  ];

  int _currentColorIndex = 0;

  // Method to get next color in rotation
  String getNextHolidayColor() {
    String color = _holidayColors[_currentColorIndex];
    _currentColorIndex = (_currentColorIndex + 1) % _holidayColors.length;
    return color;
  }

  // Method to generate a random color from the palette
  String getRandomHolidayColor() {
    return _holidayColors[Random().nextInt(_holidayColors.length)];
  }

  // Method to get color based on holiday title
  String getColorForHoliday(String title) {
    // Generate a consistent index based on the title
    int index = title.length + title.codeUnits.fold(0, (a, b) => a + b);
    return _holidayColors[index % _holidayColors.length];
  }

  // Method to suggest color based on holiday type
  String getSuggestedHolidayColor(String title) {
    title = title.toLowerCase();

    // Festival/Celebration related
    if (title.contains('festival') ||
        title.contains('celebration') ||
        title.contains('new year')) {
      return '#FFA726'; // Orange for festive mood
    }

    // National holidays
    if (title.contains('national') ||
        title.contains('independence') ||
        title.contains('republic')) {
      return '#FF5252'; // Red for national importance
    }

    // Religious holidays
    if (title.contains('christmas') ||
        title.contains('diwali') ||
        title.contains('eid') ||
        title.contains('puja')) {
      return '#AB47BC'; // Purple for religious significance
    }

    // Nature/seasonal related
    if (title.contains('spring') ||
        title.contains('summer') ||
        title.contains('monsoon') ||
        title.contains('winter')) {
      return '#66BB6A'; // Green for nature
    }

    // Default to a randomly selected color
    return getRandomHolidayColor();
  }
  @override
  void onInit() {
    super.onInit();
    selectedDay.value = DateTime.now();
    hitHolidayApiCall();
  }

  @override
  void onClose() {
    // Dispose all controllers
    for (var controller in holidayControllers.values) {
      controller.dispose();
    }
    holidayControllers.clear();
    super.onClose();
  }

  // Get or create controller for a specific holiday
  TextEditingController getHolidayController(String holidayId, String initialTitle) {
    if (!holidayControllers.containsKey(holidayId)) {
      holidayControllers[holidayId] = TextEditingController(text: initialTitle);
    }
    return holidayControllers[holidayId]!;
  }

  // Update specific holiday controller
  void updateHolidayController(String holidayId, String newTitle) {
    if (holidayControllers.containsKey(holidayId)) {
      holidayControllers[holidayId]!.text = newTitle;
    } else {
      holidayControllers[holidayId] = TextEditingController(text: newTitle);
    }
  }

  // Clear specific holiday controller
  void clearHolidayController(String holidayId) {
    if (holidayControllers.containsKey(holidayId)) {
      holidayControllers[holidayId]!.clear();
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay.value, selectedDay)) {
      this.selectedDay.value = selectedDay;
      this.focusedDay.value = focusedDay;
      selectedEventsResult.value = getEventsForDay(selectedDay);
      _showAddHolidayDialog(Get.context!, selectedDay);
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
    Get.find<AuthenticationApiService>().holidaysCalenderApiCall().then((value) async {
      if (value is HolidayResponseModel) {
        events.clear();
        allEvents.clear();
        allEvents.addAll(value.results);

        // Initialize controllers for all events
        for (var result in value.results) {
          if (result.id != null && result.title != null) {
            updateHolidayController(result.id.toString(), result.title!);
          }
          _addEventFromApi(result);
        }

        allEvents.sort((a, b) {
          final aDate = DateTime.parse(a.start ?? '');
          final bDate = DateTime.parse(b.start ?? '');
          return aDate.compareTo(bDate);
        });

        if (selectedDay.value != null) {
          selectedEventsResult.value = getEventsForDay(selectedDay.value!);
        }
      }

      List<String> calendarid = allEvents.map((Cal) => Cal.id.toString()).toList();
      await storage.write(calendarId, calendarid);
      customLoader.hide();
      update();
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

      for (var day = start;
      day.isBefore(end.add(const Duration(days: 1)));
      day = day.add(const Duration(days: 1))) {
        final dateKey = DateTime(day.year, day.month, day.day);
        events.update(dateKey, (existingEvents) {
          existingEvents.add(holidayData);
          return existingEvents;
        }, ifAbsent: () => [holidayData]);
      }
      update();
    } catch (e) {
      print('Error adding event: $e');
    }
  }

  Future<void> _showAddHolidayDialog(BuildContext context, DateTime selectedDate) {
    final titleController = TextEditingController();
    final startDateController = TextEditingController(
        text: '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
    );
    final endDateController = TextEditingController(
        text: '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
    );
    DateTime startDate = selectedDate;
    DateTime endDate = selectedDate;
    final Rx<String> selectedColor = getNextHolidayColor().obs;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          backgroundColor: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: const BoxConstraints(maxHeight: 500),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Holiday',
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                const Divider(height: 20),

                // Title Field
                Text(
                  'Holiday Title',
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: titleController,

                  decoration: InputDecoration(
                    hintText: 'Enter holiday title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Date Range
                Text(
                  'Date Range',
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: startDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: startDate,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2025),
                              );
                              if (picked != null) {
                                startDate = picked;
                                startDateController.text =
                                '${picked.day}/${picked.month}/${picked.year}';
                              }
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: endDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: endDate,
                                firstDate: startDate,
                                lastDate: DateTime(2025),
                              );
                              if (picked != null) {
                                endDate = picked;
                                endDateController.text =
                                '${picked.day}/${picked.month}/${picked.year}';
                              }
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                          size: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (titleController.text.trim().isEmpty) {
                          toast('Please enter holiday title');
                          return;
                        }

                        // Prepare holiday data
                        final holidayData = {
                          'title': titleController.text.trim(),
                          'start': '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}',
                          'end': '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}',
                          'color': selectedColor.value, // Default color
                        };

                        // Call API to create holiday
                        customLoader.show();
                        Get.find<AuthenticationApiService>()
                            .postholidaysCalenderApiCall(dataBody: holidayData)
                            .then((value) {
                          customLoader.hide();
                          toast('Holiday added successfully');
                          Get.back();
                          hitHolidayApiCall(); // Refresh calendar
                        }).catchError((error) {
                          customLoader.hide();
                          toast(error.toString());
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Add Holiday',
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void hitPutHolidayApiCall(String eventId) {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    final controller = holidayControllers[eventId];
    if (controller == null) {
      customLoader.hide();
      toast("Error: Holiday controller not found");
      return;
    }

    var holidayData = {
      "title": controller.text.trim()
    };

    Get.find<AuthenticationApiService>()
        .putholidaysCalenderApiCall(id: eventId, dataBody: holidayData)
        .then((value) {
      toast("Edit Successfully");
      hitHolidayApiCall();
      customLoader.hide();
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void hitDeleteHolidayApiCall(String eventId) {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();

    Get.find<AuthenticationApiService>()
        .deleteholidaysCalenderApiCall(id: eventId)
        .then((value) {
      toast("Delete Successfully");
      holidayControllers.remove(eventId);

      hitHolidayApiCall();
      customLoader.hide();
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  Future<void>refreshContentsCalendar()async{
    hitHolidayApiCall();
  }
}