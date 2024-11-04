import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/attendance_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class AttendanceGraphViewController extends GetxController {
  RxBool isLoading = true.obs;
  final _touchedIndex = (-1).obs;
  int get touchedIndex => _touchedIndex.value;
  void setTouchedIndex(int index) => _touchedIndex.value = index;

  // Observable values for attendance counts
  RxInt presentCount = 0.obs;
  RxInt absentCount = 0.obs;
  RxInt idleCount = 0.obs;
  RxInt totalCount = 0.obs;

  TechnicianAttendanceResponseModel attendanceResponses = TechnicianAttendanceResponseModel(
      results: [],
      count: null,
      totalPages: null
  );

  @override
  void onInit() {
    super.onInit();
    hitGetAttendanceApiCall();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void calculateAttendance() {
    // Reset counters
    presentCount.value = 0;
    absentCount.value = 0;
    idleCount.value = 0;

    // Set total from the API response
    totalCount.value = attendanceResponses.count ?? 0;

    // Calculate counts for each status
    for (var technician in attendanceResponses.results) {
      final status = technician?.todayAttendance?.status.toLowerCase() ?? '';

      switch (status) {
        case 'present':
          presentCount.value++;
          break;
        case 'absent':
          absentCount.value++;
          break;
        case 'idle':
          idleCount.value++;
          break;
      }
    }

    // Debug prints
    print('Present Count: ${presentCount.value}');
    print('Absent Count: ${absentCount.value}');
    print('Idle Count: ${idleCount.value}');
    print('Total Count: ${totalCount.value}');
  }

  void hitGetAttendanceApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    Get.find<AuthenticationApiService>()
        .getAttendanceApiCall()
        .then((value) async {
      var attendanceResponses = value;
     print("attendanceResponse: :${attendanceResponses..results}");
      calculateAttendance();

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
