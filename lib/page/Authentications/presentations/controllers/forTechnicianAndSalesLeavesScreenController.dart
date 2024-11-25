import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/attendance_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/const_local_keys.dart';

class ForTechcnicianandsalesAttendanceScreeenController extends GetxController {
  // Observables
  RxBool isLoading = true.obs;
  RxBool isPunchInSelected = true.obs;
  var selectedDates = <DateTime>[].obs;
  RxList<AttendanceResponseModel>attendanceData= <AttendanceResponseModel>[].obs;
  // Track current punch in/out session
  Rx<DateTime?> currentPunchInTime = Rx<DateTime?>(null);
  Rx<DateTime?> currentPunchOutTime = Rx<DateTime?>(null);
  RxString currentStatus = "idle".obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentStatus();
    hitAttendanceHistoryApiCall();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getCurrentStatus() {
    isLoading.value = false;
  }

  void togglePunchInOut(bool isPunchIn) {
    isPunchInSelected.value = isPunchIn;
  }

  Future<void> punchInOrOut() async {
    DateTime now = DateTime.now();
    String currentDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    try {
      isLoading.value = true;
      customLoader.show();
      FocusManager.instance.primaryFocus?.unfocus();

      if (isPunchInSelected.value) {
        currentPunchInTime.value = now;
        currentStatus.value = "active";

        var punchInData = {
          "user": storage.read(userId),
          "check_in": now.toUtc().toIso8601String(),
          "check_out": null,
          "status": "active",
          "date": currentDate
        };

        await Get.find<AuthenticationApiService>().postPunchInApiCall(
            dataBody: punchInData
        );

        if (!selectedDates.contains(now)) {
          selectedDates.add(now);
        }
      } else {
        // Handle Punch Out
        currentPunchOutTime.value = now;
        currentStatus.value = "completed";

        var punchOutData = {
          "user": storage.read(userId),
          "check_in": currentPunchInTime.value?.toUtc().toIso8601String(),
          "check_out": now.toUtc().toIso8601String(),
          "status": "completed",
          "date": currentDate
        };

        await Get.find<AuthenticationApiService>().postPunchOutApiCall(
            dataBody: punchOutData
        );
      }
      toast(isPunchInSelected.value ? 'Punched in successfully' : 'Punched out successfully');
      // // Show success message
      // Get.snackbar(
      //   'Success',
      //   isPunchInSelected.value ? 'Punched in successfully' : 'Punched out successfully',
      //   snackPosition: SnackPosition.BOTTOM,
      // );

    } catch (error) {
      toast(error.toString());
      print("Error in punchInOrOut: $error");
    } finally {
      isLoading.value = false;
      customLoader.hide();
    }
  }

  Future<void> exportAttendance() async {
    try {
      isLoading.value = true;
      customLoader.show();

      // Create attendance report data
      final reportData = selectedDates.map((date) {
        return {
          "date": "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
          "check_in": currentPunchInTime.value?.toIso8601String(),
          "check_out": currentPunchOutTime.value?.toIso8601String(),
          "status": currentStatus.value,
        };
      }).toList();
      
      print("Exporting Attendance Data: $reportData");
      toast("Attendance report exported successfully");

    } catch (error) {
      toast(error.toString());
      print("Error in exportAttendance: $error");
    } finally {
      isLoading.value = false;
      customLoader.hide();
    }
  }
  
  
  void hitAttendanceHistoryApiCall(){
    isLoading.value =true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var userid = {
      "user_id": storage.read(userId)
    };
    Get.find<AuthenticationApiService>().getAttendanceHistoryApiCall(parameters: userid).then((value){
      attendanceData.assignAll(value);
      toast("Attendance history Fethced successfully");
      customLoader.hide();
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
    }
}