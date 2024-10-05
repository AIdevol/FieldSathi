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
          body: SfCalendar(
            view: CalendarView.month,
            dataSource: MeetingDataSource(controller.events),
            onTap: (CalendarTapDetails details) {
              if (details.targetElement == CalendarElement.calendarCell) {
                _showAddEventDialog(context, controller, selectedDate: details.date);
              }
            },
            monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
          ),
        ),
      ),
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