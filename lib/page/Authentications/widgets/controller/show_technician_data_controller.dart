import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/attendance_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../response_models/user_response_model.dart';

class ShowTechnicianDataController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<TMSResponseModel> attendanceResponses = <TMSResponseModel>[].obs;
  RxList<TMSResult> attendanceResultsData = <TMSResult>[].obs;
  RxSet<AttendanceUserResponseModel> userAttendanceData = <AttendanceUserResponseModel>{}.obs;
  RxList<UserAttendanceResults> userAttendance = <UserAttendanceResults>[].obs;
  RxString searchQuery = ''.obs;
  final color = '#1976D2'.obs;
  final selectedDate = DateTime.now().obs;
  final attendanceDatas = <DateTime, bool>{}.obs;

  void markAttendance(DateTime date, bool isPresent) {
    attendanceDatas[date] = isPresent;
    update();
  }
  // Computed list of filtered members
  List<TMSResult> get filteredMembers {
    if (searchQuery.value.isEmpty) {
      return attendanceResultsData.where((tech) =>
      tech.role?.toLowerCase() != 'admin' &&
      tech.role?.toLowerCase() != 'customer' &&
          tech.role?.toLowerCase() != 'subcustomer'
      ).toList();
    }

    final query = searchQuery.value.toLowerCase();
    return attendanceResultsData.where((tech) {
      final isNotCustomer = tech.role?.toLowerCase() != 'customer' &&
          tech.role?.toLowerCase() != 'subcustomer';

      final fullName = '${tech.firstName} ${tech.lastName}'.toLowerCase();
      final empId = tech.empId?.toString().toLowerCase() ?? '';

      return isNotCustomer && (
          fullName.contains(query) ||
              empId.contains(query)
      );
    }).toList();
  }

  void filterMembers(String query) {
    searchQuery.value = query;
    update(); // Trigger UI update
  }

  String? getAttendanceDateForDay(DateTime day) {
    for (var result in userAttendance) {
      DateTime attendanceDate = DateTime.parse(result.date!);
      if (isSameDay(day, attendanceDate)) {
        return DateFormat('yyyy-MM-dd').format(attendanceDate);
      }
    }
    return null;
  }



  @override
  void onInit() {
    super.onInit();
    hitGetAttendanceApiCall();
    // hitGetUserAttendanceApiCall();
  }

  void hitGetAttendanceApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var rolesParameters = {
      "role": ["technician", "agent", "superuser", "sales"],
      // "page":1,
      // "status":"",
      // "search":"",
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getuserDetailsApiCall(parameter: rolesParameters).then((value) async {
      attendanceResultsData.assignAll(value.results!);

      customLoader.hide();
      toast('Team members data fetched successfully');
      isLoading.value = false;
      update();
    }).catchError((error, stackTrace) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }


  void hitGetUserAttendanceApiCall(String attendanceid){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var userIdParameter = {
      'user_id': attendanceid
    };
    Get.find<AuthenticationApiService>().getCalenderViewUserAttendanceApiCall(parameter: userIdParameter).then((value){
      userAttendanceData.add(value);
      userAttendance.assignAll(value.results!);
      customLoader.hide();
      toast("Attendance Fetched Successfully");
      update();
      attendanceDatas.clear();
      for (var result in value.results!) {
        DateTime attendanceDate = DateTime.parse(result.date!);
        attendanceDatas[attendanceDate] = result.status == 'absent' ? false : true;
      }
      // for(var )
    }).onError((error,stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }
}

