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
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  RxSet<TmsResponseModel> attendanceResponses = <TmsResponseModel>{}.obs;
  RxList<TMSResult> attendanceData = <TMSResult>[].obs;

  RxInt totalUsers = 0.obs;
  RxInt totalPresent = 0.obs;
  RxInt totalAbsent = 0.obs;
  RxInt totalIdle = 0.obs;
  RxDouble attendanceRate = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // hitGetAttendanceApiCall();
    hitGetAttendanceCountApiCall();
  }

  @override
  void onClose() {
    startDateController.dispose();
    endDateController.dispose();
    super.onClose();
  }



  void hitGetAttendanceApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    Get.find<AuthenticationApiService>().getuserDetailsApiCall().then((value) async {
      attendanceResponses.add(value);
      attendanceData.assignAll(value.results!);

      // Store attendance IDs in local storage
      List<String> attendanceIds = attendanceData.map((user) => user.id.toString()).toList();
      await storage.write(attendanceId, attendanceIds);
      // calculateStatistics();
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

  void hitGetAttendanceCountApiCall(){
    isLoading.value=true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().getAttendanceCountApiCall().then((countsValue){
      totalUsers.value = countsValue.totalCount!;
      totalPresent.value = countsValue.totalPresent!;
      totalAbsent.value = countsValue.totalAbsent!;
      totalIdle.value = countsValue.totalIdle!;
      customLoader.hide();
      toast("Counts fetched successfully");
      update();
    }).onError((error,stackError){
      toast(error.toString());
      customLoader.hide();
    });
  }

  void searchTechnicians(String query) {
    if (query.isEmpty) {
      hitGetAttendanceApiCall();
    } else {
      var filteredData = attendanceData.where((user) {
        final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.toLowerCase();
        final email = user.email?.toLowerCase();
        final phone = user.phoneNumber?.toLowerCase();
        final searchLower = query.toLowerCase();

        return fullName.contains(searchLower) ||
            email!.contains(searchLower) ||
            phone!.contains(searchLower);
      }).toList();

      attendanceData.assignAll(filteredData);
      // calculateStatistics();
    }
  }



  void refreshAttendance()  {
     hitGetAttendanceApiCall();
  }
}