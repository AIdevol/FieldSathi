import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/response_models/expenses_response_model.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/attendance_response_model.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class ExpenditureScreenController extends GetxController{
  final isSearching = false.obs;
  RxBool isLoading = true.obs;
  RxList<TechnicianResponseModel> technicianData =<TechnicianResponseModel>[].obs;
  RxList<TechnicianResults> results = <TechnicianResults>[].obs;
  final searchController = TextEditingController();
  final searchResults = <String>[].obs;
  RxList<ExpensesResponseModel> expensesData = <ExpensesResponseModel>[].obs;
  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
      searchResults.clear();
    }
  }

  void performSearch(String query) {
    // Implement your search logic here
    // This is a placeholder implementation
    searchResults.value = [
      'Result 1 for $query',
      'Result 2 for $query',
      'Result 3 for $query',
    ];
  }

  @override
  void onInit(){
    super.onInit();
    // hitGetTechnicianApiCall();
    // hitGetExpenseResponseModel();
  }
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }


  // void hitGetTechnicianApiCall() {
  //   isLoading.value = true;
  //   customLoader.show();
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   var roleWiseData = {
  //     'role': 'technician'
  //   };
  //   Get.find<AuthenticationApiService>().getTechnicianApiCall(parameters: roleWiseData).then((value) async {
  //     technicianData.assignAll(value);
  //     results.clear();
  //     for (var technician in value) {
  //       results.addAll(technician.results);
  //     }
  //     List<String> technicianIds = results.map((result) => result.id.toString()).toList();
  //     await storage.write(attendanceId, technicianIds.join(','));
  //     customLoader.hide();
  //     toast('Technicians fetched successfully');
  //     isLoading.value = false;
  //     // hitGetExpenseResponseModel();
  //       }).catchError((error, stackTrace) {
  //     customLoader.hide();
  //     toast(error.toString());
  //     isLoading.value = false;
  //   });
  // }




  void hitGetExpenseResponseModel()async{
    final technicianId = await storage.read(attendanceId);
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var expencesData = {
      'technician': technicianId
    };
    Get.find<AuthenticationApiService>().getExpensesApiCall(parameters: expencesData).then((value){
      // expencesData.assignAll(value);
      customLoader.hide();
      toast('Expenses fetched successfully');
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value= false;
    });
  }
}

