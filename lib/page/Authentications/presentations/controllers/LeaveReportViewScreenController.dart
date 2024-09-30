import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:intl/intl.dart';

class LeaveReportViewScreenController extends GetxController {
  RxInt casualLeaves = 0.obs;
  RxList<String> filterTypes = [
    "Select Status",
    "Submitted",
    "Approved",
    "Rejected",
  ].obs;

  void incrementCasualLeaves() {
    casualLeaves.value++;
  }

  void decrementCasualLeaves() {
    if (casualLeaves.value > 0) {
      casualLeaves.value--;
    }
  }

  RxList<String> roleTypes = [
    "Agent",
    "Technician",
    "Manager",
  ].obs;

  RxString selectedRoleFilter = "Agent".obs;
  RxString selectedFilter = "Select Status".obs;
  Rx<LeaveManagementResponseModel?> leaveManagementData = Rx<LeaveManagementResponseModel?>(null);
  RxList<Result> filteredLeaves = <Result>[].obs;
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    hitLeavesApiCall();
  }

  Future<void> hitLeavesApiCall() async {
    customLoader.show();
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      final response = await Get.find<AuthenticationApiService>().getLeavesApiCall();
      leaveManagementData.value = leaveManagementFromJson(response.toString());
      applyFilters();
      toast("Fetched leaves successfully");
    } catch (error) {
      toast(error.toString());
    } finally {
      customLoader.hide();
      isLoading.value = false;
      update();
    }
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

    filteredLeaves.value = leaveManagementData.value!.results.where((leave) {
      final nameMatch = '${leave.userId.firstName} ${leave.userId.lastName}'
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase());
      final statusMatch = selectedFilter.value == "Select Status" || leave.status == selectedFilter.value;
      return nameMatch && statusMatch;
    }).toList();
  }

  void showLeaveDetails(Result leave) {
    Get.dialog(
      AlertDialog(
        title: Text('Leave Details'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Name: ${leave.userId.firstName} ${leave.userId.lastName}'),
            Text('Phone: ${leave.userId.phoneNumber}'),
            Text('Profile: ${leave.userId.role}'),
            Text('From Date: ${formatDate(leave.startDate)}'),
            Text('To Date: ${formatDate(leave.endDate)}'),
            Text('Days: ${calculateDays(leave.startDate, leave.endDate)}'),
            Text('Reason: ${leave.reason}'),
            Text('Status: ${leave.status}'),
          ],
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