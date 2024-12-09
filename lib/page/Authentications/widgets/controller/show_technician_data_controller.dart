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
  RxList<TmsResponseModel> attendanceResponses = <TmsResponseModel>[].obs;
  RxList<TMSResult> attendanceResultsData = <TMSResult>[].obs;
  RxList<TMSResult> attendanceFilterdata = <TMSResult>[].obs;
  RxList<TMSResult> attendancePaginationData = <TMSResult>[].obs;
  RxList<AttendanceUserResponseModel> userAttendanceData = <AttendanceUserResponseModel>[].obs;
  // RxList<UserAttendanceResults> userAttendance = <UserAttendanceResults>[].obs;
  RxString searchQuery = ''.obs;
  final color = '#1976D2'.obs;
  final selectedDate = DateTime.now().obs;
  final attendanceDatas = <DateTime, bool>{}.obs;
  final RxInt currentPage = 1.obs;
  final int itemsPerPage = 10;
  final RxInt totalPages = 0.obs;
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
    for (var result in userAttendanceData) {
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
  void calculateTotalPages() {
    totalPages.value = (attendanceFilterdata.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }
  }

  void updatePaginatedTechnicians() {
    List<TMSResult> sourceList = attendanceFilterdata.isEmpty
        ? attendanceResultsData
        : attendanceFilterdata;
    totalPages.value = (sourceList.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }

    int startIndex = (currentPage.value - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    endIndex = endIndex > sourceList.length ? sourceList.length : endIndex;
    attendancePaginationData.value = sourceList.sublist(
        startIndex,
        endIndex
    );

    update();
  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      updatePaginatedTechnicians();
      print("next page tapped value: ${currentPage.value}");
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      updatePaginatedTechnicians();
      print("previous page tapped value: ${currentPage.value}");

    }
  }

  void goToFirstPage() {
    currentPage.value = 1;
    updatePaginatedTechnicians();
  }

  void goToLastPage() {
    currentPage.value = totalPages.value;
    updatePaginatedTechnicians();
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
      attendanceFilterdata.assignAll(value.results!);
      attendancePaginationData.assignAll(value.results!);
      customLoader.hide();
      toast('Team members data fetched successfully');
      calculateTotalPages();
      isLoading.value = false;
      update();
    }).catchError((error, stackTrace) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }


  hitGetUserAttendanceApiCall(String attendanceid){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();

    var userIdParameter = {'user_id': attendanceid};

    Get.find<AuthenticationApiService>()
        .getCalenderViewUserAttendanceApiCall(parameter: userIdParameter)
        .then((value){
      userAttendanceData.assignAll(value);

      attendanceDatas.clear();
      for (var result in value) {
        if (result.date != null) {
          DateTime attendanceDate = DateTime.parse(result.date!);
          attendanceDatas[attendanceDate] = _determineAttendanceStatus(result.status);
        }
      }
      hitGetAttendanceApiCall();
      customLoader.hide();
      toast("Attendance Fetched Successfully");
      update();
    })
        .onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

// Helper method to determine attendance status more flexibly
  bool _determineAttendanceStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'present':
      case 'checkedin':
        return true;
      case 'absent':
      case 'idle':
      default:
        return false;
    }
  }
}

