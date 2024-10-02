import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:intl/intl.dart';

class LeaveReportViewScreenController extends GetxController {
  RxList<String> filterTypes = [
    "Select Status",
    "Submitted",
    "Approved",
    "Rejected",
  ].obs;

  RxString selectedFilter = "Select Status".obs;
  Rx<LeaveResponseModel?> leaveManagementData = Rx<LeaveResponseModel?>(null);
  RxList<Results> filteredLeaves = <Results>[].obs;
    RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    hitLeavesApiCall();
  }

  void hitLeavesApiCall() {
    customLoader.show();
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    Get.find<AuthenticationApiService>().getLeavesApiCall().then((value) {
      var leavesData = value;
      if (value is Map<String, dynamic>) {
        // leaveManagementData.value = LeaveResponseModel.fromJson(leavesData);
        applyFilters();
        customLoader.hide();
        toast("Fetched leaves successfully");
      } else {
        throw Exception('Unexpected response format');
      }
      isLoading.value = false;
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void updateSelectedFilter(String? newValue) {
    if (newValue != null) {
      selectedFilter.value = newValue;
      applyFilters();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void applyFilters() {
    if (leaveManagementData.value == null) return;

    filteredLeaves.value = leaveManagementData.value!.results!.where((leave) {
      final nameMatch = '${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase());
      final statusMatch = selectedFilter.value == "Select Status" || leave.status == selectedFilter.value;
      return nameMatch && statusMatch;
    }).toList();
  }

  void showLeaveDetails(Results leave) {
    Get.dialog(
      AlertDialog(
        title: Text('Leave Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'),
              Text('Phone: ${leave.userId?.phoneNumber ?? ''}'),
              Text('Role: ${leave.userId?.role ?? ''}'),
              Text('From Date: ${formatDate(DateTime.parse(leave.startDate ?? ''))}'),
              Text('To Date: ${formatDate(DateTime.parse(leave.endDate ?? ''))}'),
              Text('Days: ${calculateDays(DateTime.parse(leave.startDate ?? ''), DateTime.parse(leave.endDate ?? ''))}'),
              Text('Reason: ${leave.reason ?? ''}'),
              Text('Status: ${leave.status ?? ''}'),
              Text('Leave Type: ${leave.leaveType ?? ''}'),
              Text('Company: ${leave.userId?.companyName ?? ''}'),
              Text('Email: ${leave.userId?.email ?? ''}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  int calculateDays(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays + 1;
  }
}