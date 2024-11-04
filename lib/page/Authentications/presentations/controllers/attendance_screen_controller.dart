import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/attendance_response_model.dart';
import 'package:tms_sathi/response_models/user_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class AttendanceScreenController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<TMSResponseModel> attendanceResponses = <TMSResponseModel>[].obs;
  RxList<TMSResult> attendanceData = <TMSResult>[].obs;

  RxInt totalUsers = 0.obs;
  RxInt totalPresent = 0.obs;
  RxInt totalAbsent = 0.obs;
  RxInt totalIdle = 0.obs;
  RxDouble attendanceRate = 0.0.obs;

  final RxMap<String, String> userAttendanceStatus = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    hitGetAttendanceApiCall();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void calculateStatistics() {
    totalUsers.value = attendanceData.length;

    // Reset counters
    totalPresent.value = 0;
    totalAbsent.value = 0;
    totalIdle.value = 0;

    for (var technician in attendanceData) {
      // Assuming the attendance status is stored in userAttendanceStatus map
      String status = userAttendanceStatus[technician.id] ?? 'absent';

      switch (status.toLowerCase()) {
        case 'present':
          totalPresent.value++;
          break;
        case 'absent':
          totalAbsent.value++;
          break;
        case 'idle':
          totalIdle.value++;
          break;
      }
    }

    // Calculate attendance rate (present + idle users / total users)
    if (totalUsers.value > 0) {
      attendanceRate.value = ((totalPresent.value + totalIdle.value) / totalUsers.value) * 100;
    }

    update();
  }

  // Method to update attendance status for a specific user
  void updateUserAttendanceStatus(String userId, String status) {
    userAttendanceStatus[userId] = status;
    calculateStatistics();
  }

  void hitGetAttendanceApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    // var roleWiseData = {
    //   'role': 'technician'
    // };
    Get.find<AuthenticationApiService>().getuserDetailsApiCall().then((value) async {
      attendanceData.assignAll(value.results);
      // attendanceData.clear();
      // for (var technician in attendanceResponses) {
      //   attendanceData.assignAll(technician.results);
      //   // if (!userAttendanceStatus.containsKey(attendanceData.)) {
      //   //   userAttendanceStatus[technician.id.toString()] = 'absent';
      //   // }
      // }
      List<String> attendanceIds = attendanceData.map((technician) => technician.id.toString()).toList();
      await storage.write(attendanceId, attendanceIds);
      print("${storage.read(attendanceId)}");
      customLoader.hide();
      toast('Attendance fetched successfully');
      isLoading.value = false;
      update();
        }).catchError((error, stackTrace) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }
}