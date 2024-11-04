import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class TechnicianListViewScreenController extends GetxController {
  final searchController = TextEditingController();
  RxBool isLoading = true.obs;
  RxList<TechnicianResults> allTechnicians = <TechnicianResults>[].obs;
  RxList<TodayAttendance> TechnicianAttendance = <TodayAttendance>[].obs;
  RxList<TechnicianResults> filteredTechnicians = <TechnicianResults>[].obs;

  // Add this line to fix the null issue
  RxBool isTableView = false.obs;

  @override
  void onInit() {
    super.onInit();
    hitGetTechnicianApiCall();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void fetchTechnicians() {
    filteredTechnicians.assignAll(allTechnicians);
    update();
  }

  void refreshList() {
    hitGetTechnicianApiCall();
  }

  void hitGetTechnicianApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var roleWiseData = {
      'role': 'technician'
    };

    Get.find<AuthenticationApiService>()
        .getTechnicianApiCall(parameters: roleWiseData)
        .then((value) async {
      allTechnicians.assignAll(value.results);
      TechnicianAttendance.clear();

      // Extract attendance data from each technician
      for (var technician in allTechnicians) {
        if (technician.todayAttendance != null) {
          TechnicianAttendance.add(technician.todayAttendance!);
        }
      }

      List<String> technicianIds = allTechnicians
          .map((result) => result.id.toString())
          .toList();
      await storage.write(attendanceId, technicianIds.join(','));
      print("technician Data: ${storage.read(attendanceId)}");

      customLoader.hide();
      toast('Technicians fetched successfully');
      isLoading.value = false;
    }).catchError((error, stackTrace) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void importTechnicians() {
    // TODO: Implement import functionality
  }

  void exportTechnicians() {
    // TODO: Implement export functionality
  }

  // Update the toggleView method to use the RxBool
  void toggleView(bool isTable) {
    isTableView.value = isTable;
    update();
  }
}