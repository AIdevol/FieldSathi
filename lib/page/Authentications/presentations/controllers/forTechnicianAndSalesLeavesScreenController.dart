import 'package:get/get.dart';

class ForTechcnicianandsalesAttendanceScreeenController extends GetxController {
  // Observables
  var isPunchInSelected = true.obs;
  var selectedDates = <DateTime>[].obs;

  void togglePunchInOut(bool isPunchIn) {
    isPunchInSelected.value = isPunchIn;
  }

  void punchInOrOut() {
    DateTime today = DateTime.now();
    if (!selectedDates.contains(today)) {
      selectedDates.add(today);
    }
  }

  void exportAttendance() {
    // Implement export functionality
    print("Exporting Attendance...");
  }
}
