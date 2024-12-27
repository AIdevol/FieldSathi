import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import '../../../../response_models/user_leaves_Data_response_model.dart';

class ShowUserLeaveScreenDataController extends GetxController {
  final RxList<UserLeaveDatum> leaveData = <UserLeaveDatum>[].obs;
  final RxList<UserLeaveDatum> leavesDataPagination = <UserLeaveDatum>[].obs;
  final RxBool isLoading = true.obs;
  final RxInt recordsPerPage = 10.obs;
  final RxString searchQuery = ''.obs;
  final RxInt currentPage = 1.obs;

  // Computed properties for pagination
  int get totalPages => (filteredData.length / recordsPerPage.value).ceil();
  List<UserLeaveDatum> get filteredData => leaveData.where((f) =>
      f.toString().toLowerCase().contains(searchQuery.value.toLowerCase())
  ).toList();

  List<UserLeaveDatum> get paginatedData {
    final startIndex = (currentPage.value - 1) * recordsPerPage.value;
    final endIndex = startIndex + recordsPerPage.value;
    final filtered = filteredData;

    if (startIndex >= filtered.length) return [];
    return filtered.sublist(
        startIndex,
        endIndex > filtered.length ? filtered.length : endIndex
    );
  }

  @override
  void onInit() {
    super.onInit();
    hitGetUserLeavesDataApiCall();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    currentPage.value = 1; // Reset to first page when searching
    update();
  }

  void nextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
      update();
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      update();
    }
  }

  void updateRecordsPerPage(int value) {
    recordsPerPage.value = value;
    currentPage.value = 1; // Reset to first page when changing records per page
    update();
  }

  void hitGetUserLeavesDataApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().getUserLeavesDataApiCall().then((value) {
      leaveData.assignAll(value.userLeaveData);
      leavesDataPagination.assignAll(value.userLeaveData);
      toast("User Fetched Successfully");
      customLoader.hide();
      update();
    }).onError((error, stackError) {
      toast(error.toString());
      customLoader.hide();
    });
  }

  Future<void> refreshIndicatorRecallApi() async {
    hitGetUserLeavesDataApiCall();
  }
}