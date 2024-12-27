import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_amc_view_controller.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class AddAmcCalenderView extends GetView<AddAmcViewController> {
  const AddAmcCalenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<AddAmcViewController>(
        init: AddAmcViewController(),
        builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            title: Text(
              "AMC Calendar",
              style: MontserratStyles.montserratBoldTextStyle(
                size: 20,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _showAddEventDialog(context, controller),
              ),
            ],
          ),
          body: Column(
            children: [
              _buildViewSelector(controller),
              Expanded(
                child: SfCalendar(
                  view: controller.currentView,
                  dataSource: MeetingDataSource(controller.events),
                  onTap: (CalendarTapDetails details) {
                    if (details.targetElement == CalendarElement.calendarCell) {
                      _showAddEventDialog(context, controller, selectedDate: details.date);
                    } else if (details.targetElement == CalendarElement.appointment) {
                      _showEventDetails(context, details.appointments!.first as Appointment);
                    }
                  },
                  monthViewSettings: MonthViewSettings(
                    appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                    showAgenda: true,
                  ),
                  timeSlotViewSettings: TimeSlotViewSettings(
                    startHour: 8,
                    endHour: 20,
                    nonWorkingDays: <int>[DateTime.sunday],
                  ),
                  allowedViews: const [
                    CalendarView.day,
                    CalendarView.week,
                    CalendarView.month,
                    CalendarView.schedule,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewSelector(AddAmcViewController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _viewButton('Day', CalendarView.day, controller),
          _viewButton('Week', CalendarView.week, controller),
          _viewButton('Month', CalendarView.month, controller),
          _viewButton('Agenda', CalendarView.schedule, controller),
        ],
      ),
    );
  }

  Widget _viewButton(String title, CalendarView view, AddAmcViewController controller) {
    bool isSelected = controller.currentView == view;
    return InkWell(
      onTap: () => controller.updateCalendarView(view),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? appColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appointment.subject),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${appointment.startTime.toString().split(' ')[0]}'),
              SizedBox(height: 8),
              Text('Time: ${appointment.startTime.toString().split(' ')[1].substring(0, 5)} - '
                  '${appointment.endTime.toString().split(' ')[1].substring(0, 5)}'),
              if (appointment.notes?.isNotEmpty ?? false) ...[
                SizedBox(height: 8),
                Text('Description: ${appointment.notes}'),
              ],
            ],
          ),
          actions: [
            TextButton(
              child: Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop();
                _showEditEventDialog(context, appointment);
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showEditEventDialog(BuildContext context, Appointment appointment) {
    final TextEditingController titleController = TextEditingController(text: appointment.subject);
    final TextEditingController descriptionController = TextEditingController(text: appointment.notes);
    DateTime eventDate = appointment.startTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Event'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Event Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Event Description'),
                ),
                SizedBox(height: 16),
                Text('Date: ${eventDate.toString().split(' ')[0]}'),
                ElevatedButton(
                  child: Text('Select Date'),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: eventDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != eventDate) {
                      eventDate = picked;
                      Get.find<AddAmcViewController>().update();
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Get.find<AddAmcViewController>().removeEvent(appointment);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final controller = Get.find<AddAmcViewController>();
                controller.removeEvent(appointment);
                controller.addEvent(
                  Appointment(
                    startTime: eventDate,
                    endTime: eventDate.add(Duration(hours: 1)),
                    subject: titleController.text,
                    notes: descriptionController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddEventDialog(BuildContext context, AddAmcViewController controller, {DateTime? selectedDate}) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    DateTime eventDate = selectedDate ?? DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Event'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Event Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Event Description'),
                ),
                SizedBox(height: 16),
                Text('Date: ${eventDate.toString().split(' ')[0]}'),
                ElevatedButton(
                  child: Text('Select Date'),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: eventDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != eventDate) {
                      eventDate = picked;
                      controller.update();
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                controller.addEvent(
                  Appointment(
                    startTime: eventDate,
                    endTime: eventDate.add(Duration(hours: 1)),
                    subject: titleController.text,
                    notes: descriptionController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}