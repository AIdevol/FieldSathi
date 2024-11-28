import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/response_models/expenses_response_model.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/attendance_response_model.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../response_models/ticket_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class ExpenditureScreenController extends GetxController{
  final isSearching = false.obs;
  RxBool isLoading = true.obs;
  RxList<TechnicianResponseModel> technicianData =<TechnicianResponseModel>[].obs;
  RxList<TechnicianData> technicianresults = <TechnicianData>[].obs;
  final searchController = TextEditingController();

  final hasError = false.obs;
  final searchResults = <String>[].obs;
  RxList<ExpensesResponseModel> expensesData = <ExpensesResponseModel>[].obs;
  RxList<ExpenseResult> expenseResult =<ExpenseResult>[].obs;
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
    initializeData();
    // hitGetExpenseResponseModel();
  }
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> initializeData() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      await hitGetTechnicianApiCall();
      isLoading.value = false;
    } catch (e) {
      hasError.value = true;
      isLoading.value = false;
      print('Error initializing data: $e');
    }
  }

  Future<void> hitGetTechnicianApiCall() async{
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var roleWiseData = {
      'role': ['technician', 'sales'],
      'page_size':"all"
    };
    Get.find<AuthenticationApiService>().getTechnicianApiCall(parameters: roleWiseData).then((value) async {
      technicianresults.assignAll(value.results!);
      List<String> technicianIds = technicianresults.map((result) => result.id.toString()).toList();
      await storage.write(attendanceId, technicianIds.join(','));
      print("technician data: ${storage.read(attendanceId)}");
      customLoader.hide();
      toast('Technicians fetched successfully');
      update();
      // hitGetExpenseResponseModel();
        }).catchError((error, stackTrace) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }


  // void fetchTechnicianDetailsApiCall() async {
  //   isLoading.value = true;
  //   customLoader.show();
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   var parametersData = <String, dynamic>{
  //     'role':["technician", "sales"],
  //     // 'role':'sales',
  //   };
  //   try {
  //     final response = await Get.find<AuthenticationApiService>()
  //         .getTechnicianDetailsApiCall(parameters: parametersData);
  //     if (response != null) {
  //       // ticketResult.assignAll(response.results);
  //       // applyFilters(); // Apply initial filters
  //     }
  //   } catch (error) {
  //     toast('Error fetching ticket details: ${error.toString()}');
  //   } finally {
  //     customLoader.hide();
  //     isLoading.value = false;
  //   }
  // }

  void hitGetExpenseApiCallDetails(String technicianId)async{
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var expencesData = {
      'technician': technicianId,
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getExpensesApiCall(parameters: expencesData).then((value){
      expenseResult.assignAll(value.results);
      customLoader.hide();
      toast('Expenses fetched successfully');
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value= false;
    });
  }


  void clearExpenseResults() {
    expenseResult.clear();
    update();
    hitGetTechnicianApiCall();
  }
}

