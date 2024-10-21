import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/attendance_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class ShowTechnicianDataController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<TechnicianAttendanceResponseModel> attendanceResponses = <TechnicianAttendanceResponseModel>[].obs;
  RxList<TechnicianData> attendanceData = <TechnicianData>[].obs;

  @override
  void onInit() {
    super.onInit();
    hitGetAttendanceApiCall();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void hitGetAttendanceApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var roleWiseData = {
      'role': 'technician'
    };
    Get.find<AuthenticationApiService>().getAttendanceApiCall(parameters: roleWiseData).then((value) async {
      // attendanceResponses.assignAll(value);
      // attendanceData.clear();
      // for (var response in attendanceResponses) {
      //   attendanceData.addAll(response.results);
      // }
      print('ajdfjafj: ${attendanceData}');
      List<String> attendanceIds = attendanceData.map((technician) => technician.id.toString()).toList();
      await storage.write(attendanceId, attendanceIds);
      // print("Techniciandata at ${}"); // Debug print
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