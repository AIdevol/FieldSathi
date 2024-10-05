import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddAmcViewController extends GetxController {
  List<Appointment> events = [];

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void fetchEvents() {
    // TODO: Implement API call to fetch events from backend
    // For now, we'll use dummy data
    events = [
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 2)),
        subject: 'Sample AMC Event',
        notes: 'This is a sample event',
      ),
    ];
    update();
  }

  void addEvent(Appointment newEvent) {
    events.add(newEvent);
    // TODO: Implement API call to save new event to backend
    update();
  }
}