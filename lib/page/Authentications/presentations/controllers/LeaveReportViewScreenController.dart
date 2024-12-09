import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:intl/intl.dart';

class LeaveReportViewScreenController extends GetxController {
  final TextEditingController statusController = TextEditingController();
  RxList<String> filterTypes = [
    "Select Status",
    "Submitted",
    "Approved",
    "Rejected",
  ].obs;

  RxList<String> selectedStatus = [
    "Select Status",
    "Submitted",
    "Approved",
    "Rejected",
  ].obs;

  RxString defaultSelectedStatus = 'Submitted'.obs;
  RxString selectedFilter = "Select Status".obs;
  // Rx<LeaveResponseModel> leaveManagementData = LeaveResponseModel().obs;
  RxList<LeaveResult> leavesData = <LeaveResult>[].obs;
  RxList<LeaveResult> filteredLeaves = <LeaveResult>[].obs;
  RxList<LeaveResult> leavesPaginationsData = <LeaveResult>[].obs;

  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  final int itemsPerPage = 10;

  @override
  void onInit() {
    super.onInit();
    hitLeavesApiCall();
  }

  void applyFilters() {
    // Create a copy of the original leaves data
    List<LeaveResult> tempLeaves = List.from(leavesData);

    // Filter by status
    if (selectedFilter.value != "Select Status") {
      tempLeaves = tempLeaves.where((leave) =>
      leave.status?.toLowerCase() == selectedFilter.value.toLowerCase()
      ).toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      tempLeaves = tempLeaves.where((leave) {
        final name = '${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'.toLowerCase();
        final reason = leave.reason?.toLowerCase() ?? '';
        final leaveType = leave.leaveType?.toLowerCase() ?? '';
        final searchTerm = searchQuery.value.toLowerCase();

        return name.contains(searchTerm) ||
            reason.contains(searchTerm) ||
            leaveType.contains(searchTerm);
      }).toList();
    }

    // Update filtered leaves
    filteredLeaves.value = tempLeaves;

    // Recalculate pagination
    calculateTotalPages();
    updatePaginatedTechnicians();
  }

  void calculateTotalPages() {
    totalPages.value = (filteredLeaves.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }
  }

  void updatePaginatedTechnicians() {
    int startIndex = (currentPage.value - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    endIndex = endIndex > filteredLeaves.length ? filteredLeaves.length : endIndex;

    leavesPaginationsData.value = filteredLeaves.sublist(
        startIndex,
        endIndex
    );

    update();
  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      updatePaginatedTechnicians();
    }
  }


  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      updatePaginatedTechnicians();
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

  void hitLeavesApiCall() {
    customLoader.show();
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    var leavefilteredPage = {
      "page": currentPage.value,
      "page_size": "all"
    };
    Get.find<AuthenticationApiService>().getLeavesApiCall(parameter: leavefilteredPage).then((value) {
      leavesData.assignAll(value.results);
      filteredLeaves.assignAll(value.results);
      leavesPaginationsData.assignAll(value.results);
      customLoader.hide();
      calculateTotalPages();
      updatePaginatedTechnicians();
      isLoading.value = false;
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitUpdateStatusPutAPiCall()async{
    final leaveId = await storage.read(leavesId);
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var statusValue={
      "status": defaultSelectedStatus
    };
    Get.find<AuthenticationApiService>().putLeavesApiCall(dataBody: statusValue, id: leaveId).then((value){
       // leaveManagementData.value = value;
       customLoader.hide();
       toast("Successfully updated Status ");
       hitLeavesApiCall();
       update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }


  void updateSelectedFilter(String? newValue) {
    if (newValue != null) {
      selectedFilter.value = newValue;
      applyFilters();
    }
  }

void updateSelectedStatus(String? newValue){
    if(newValue != null){
      defaultSelectedStatus.value = newValue;

    }
}
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  // void applyFilters() {
  //   if (leaveManagementData.value == null) return;
  //
  //   filteredLeaves.value = leaveManagementData.value!.results!.where((leave) {
  //     final nameMatch = '${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'
  //         .toLowerCase()
  //         .contains(searchQuery.value.toLowerCase());
  //     final statusMatch = selectedFilter.value == "Select Status" || leave.status == selectedFilter.value;
  //     return nameMatch && statusMatch;
  //   }).toList();
  // }

  void showLeaveDetails(LeaveResult leave) {
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
              Text('Company: ${leave.userId.firstName ?? ''}'),
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

 Future<void> hitRefreshApiCall()async{
   hitLeavesApiCall();
 }
}
