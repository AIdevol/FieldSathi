import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/calender_view_amc_controller.dart';
import 'package:tms_sathi/response_models/holidays_calender_response_model.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controllers/calender_screen_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      init: CalendarController(),
      builder: (controller) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)
            ),
            title: Text(
                'Calendar',
                style: MontserratStyles.montserratBoldTextStyle(
                    color: blackColor,
                    size: 15
                )
            ),
            backgroundColor: appColor,
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Calendar View'),
                Tab(text: 'List View',),
              ],
              labelStyle: MontserratStyles.montserratBoldTextStyle(
                  color: blackColor,
                  size: 14
              ),
              unselectedLabelStyle: MontserratStyles.montserratNormalTextStyle(
                  color: blackColor,
                  size: 14
              ),
              indicatorColor: Colors.black87,
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.black87,
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async{
              await controller.refreshContentsCalendar();
            },
            child: TabBarView(
              children: [
                _buildCalendarTab(controller),
                _buildListTab(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarTab(CalendarController controller) {
    return Column(
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
          child: _buildEventsList(controller),
        ),
      ],
    );
  }

  // Widget _buildListTab(CalendarController controller) {
  //   return Obx(() => ListView.builder(
  //     padding: const EdgeInsets.all(16),
  //     itemCount: controller.selectedEventsResult.length,
  //     itemBuilder: (BuildContext context, index) {
  //       final event = controller.selectedEventsResult[index];
  //       final startDate = DateTime.parse(event.start!);
  //       final endDate = DateTime.parse(event.end!);
  //
  //       return Card(
  //         elevation: 2,
  //         margin: const EdgeInsets.only(bottom: 12),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         child: ListTile(
  //           contentPadding: const EdgeInsets.all(16),
  //           title: Text(
  //             event.title ?? '',
  //             style: MontserratStyles.montserratBoldTextStyle(
  //                 color: blackColor,
  //                 size: 15
  //             ),
  //           ),
  //           subtitle: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const SizedBox(height: 8),
  //               Text(
  //                   '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
  //                   style: MontserratStyles.montserratNormalTextStyle(
  //                       color: blackColor,
  //                       size: 15
  //                   )
  //               ),
  //             ],
  //           ),
  //           leading: Container(
  //             padding: const EdgeInsets.all(8),
  //             decoration: BoxDecoration(
  //               color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')).withOpacity(0.2),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Icon(
  //               Icons.celebration,
  //               color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')),
  //               size: 24,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   ));
  // }
  Widget _buildListTab(CalendarController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.allEvents.length,
      itemBuilder: (BuildContext context, int index) {
        final event = controller.allEvents[index];
        final startDate = DateTime.parse(event.start!);
        final endDate = DateTime.parse(event.end!);

        // Format dates in a more readable way
        String getFormattedDate(DateTime date) {
          final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
          return '${date.day} ${months[date.month - 1]} ${date.year}';
        }
        final duration = endDate.difference(startDate).inDays + 1;

        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              _buildShowDetailsOfTheCard(context, controller, event);
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.celebration,
                      color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Title
                        Text(
                          event.title ?? 'Untitled Event',
                          style: MontserratStyles.montserratBoldTextStyle(
                            color: blackColor,
                            size: 16,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 16,
                                color: Colors.grey[600]
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${getFormattedDate(startDate)} - ${getFormattedDate(endDate)}',
                                style: MontserratStyles.montserratNormalTextStyle(
                                  color: Colors.grey[600]!,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4
                          ),
                          decoration: BoxDecoration(
                            color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            duration > 1 ? '$duration Days' : '1 Day',
                            style: MontserratStyles.montserratNormalTextStyle(
                              color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')),
                              size: 12,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildEventsList(CalendarController controller) {
    return Obx(() => ListView.builder(
      itemCount: controller.selectedEventsResult.length,
      itemBuilder: (BuildContext context, index) {
        final event = controller.selectedEventsResult[index];
        final startDate = DateTime.parse(event.start!);
        final endDate = DateTime.parse(event.end!);

        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: (){
              _buildShowDetailsOfTheCard(context, controller, event);
            },
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                event.title ?? '',
                style: MontserratStyles.montserratBoldTextStyle(
                    color: blackColor,
                    size: 15
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                      '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
                      style: MontserratStyles.montserratNormalTextStyle(
                          color: blackColor,
                          size: 15
                      )
                  ),
                ],
              ),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.celebration,
                  color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')),
                  size: 24,
                ),
              ),
            ),
          ),
        );
      },
    ));
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

Future<void> _buildShowDetailsOfTheCard(BuildContext context, CalendarController controller, Result event) {
  // Controller for the text field
  final titleController = controller.getHolidayController(event.id.toString(), event.title ?? '');
  final startDate = DateTime.parse(event.start!);
  final endDate = DateTime.parse(event.end!);

  String getFormattedDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

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
                    'Holiday Details',
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

              // Event Icon and Color
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.celebration,
                      color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Holiday Event',
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        size: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Title Field
              Text(
                'Event Title',
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: appColor)
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                style: MontserratStyles.montserratNormalTextStyle(
                  size: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Date Information
              Text(
                'Date Range',
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      '${getFormattedDate(startDate)} - ${getFormattedDate(endDate)}',
                      style: MontserratStyles.montserratNormalTextStyle(
                        size: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Duration
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Duration: ${endDate.difference(startDate).inDays + 1} Days',
                  style: MontserratStyles.montserratNormalTextStyle(
                    size: 14,
                    color: Color(int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')),
                  ),
                ),
              ),
              const Spacer(),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        size: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      controller.hitDeleteHolidayApiCall(event.id.toString());
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      controller.hitPutHolidayApiCall(event.id.toString());
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Save',
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