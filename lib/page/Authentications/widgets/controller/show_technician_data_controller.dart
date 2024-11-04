import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/attendance_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../response_models/user_response_model.dart';

class ShowTechnicianDataController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<TMSResponseModel> attendanceResponses = <TMSResponseModel>[].obs;
  RxList<TMSResult> attendanceResultsData = <TMSResult>[].obs;

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
    Get.find<AuthenticationApiService>().getuserDetailsApiCall().then((value) async {
      // attendanceResponses.assignAll(value);
      attendanceResultsData.assignAll(value.results);
      // print("${storage.read(attendanceId)}");
      // attendanceResultsData.clear();
      // print('ajdfjafj: ${attendanceResultsData}');
      // for (var user in attendanceResponses){
      //   attendanceResultsData.assignAll(user.results);
      // }
      // attendanceData.clear();
      // for (var response in attendanceResponses) {
      //   attendanceData.addAll(response.results);
      // }
      // print('ajdfjafj: ${attendanceData}');
      // List<String> attendanceIds = attendanceResultsData.map((technician) => technician.id.toString()).toList();
      // await storage.write(attendanceId, attendanceIds);
      print("Techniciandata at ${storage.read(attendanceId)}"); // Debug print
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