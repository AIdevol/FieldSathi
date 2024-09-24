import 'package:get/get.dart';
import 'package:tms_sathi/navigations/navigation.dart';

class LeaveReportViewScreenController extends GetxController{

  final List<String> leaveStatus = [
    "selected status",
    "Submitted",
    "Approved",
    "Rejected"
  ].obs;
  RxString dropdownValue = "Selected Status".obs;
}