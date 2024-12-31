import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/response_models/expenses_response_model.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/attendance_response_model.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../response_models/ticket_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

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

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

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
  }
  @override
  void onClose() {
    searchController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.onClose();
  }

  Future<void> initializeData() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      await hitGetTechnicianApiCall();
      hitGetExpenseApiCallDetails(storage.read(userId));
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
    FocusManager.instance.primaryFocus!.unfocus();
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

Future<void>refreshApiCall()async {
  hitGetTechnicianApiCall();
}
  Future<void>refreshExpenseApiCall(String id)async {
    hitGetExpenseApiCallDetails(id);
  }
  void clearExpenseResults() {
    expenseResult.clear();
    update();
    hitGetTechnicianApiCall();
  }

  void hitDeleteApiCall(String id){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    
  }



  void downLoadExportModelView(BuildContext context, ExpenditureScreenController controller) {
    DateTime? startDate;
    DateTime? endDate;

    Future<DateTime?> _selectDate(BuildContext context, {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime.now(),
      );
      return picked;
    }

    void _handleStartDateSelection() async {
      final picked = await _selectDate(
        context,
        initialDate: startDate ?? DateTime.now(),
        lastDate: endDate ?? DateTime.now(),
      );
      if (picked != null) {
        startDate = picked;
        controller.startDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      }
    }

    void _handleEndDateSelection() async {
      final picked = await _selectDate(
        context,
        initialDate: endDate ?? DateTime.now(),
        firstDate: startDate ?? DateTime(2000),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        endDate = picked;
        controller.endDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.8,
              maxWidth: Get.width * 0.8,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Download Report",
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 15,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.close))
                  ],
                ),
                divider(color: Colors.grey),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.startDateController,
                        labletext: 'Start Date',
                        hintText: "dd-mm-yyyy",
                        readOnly: true,
                        onTap: _handleStartDateSelection,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "To",
                        style: MontserratStyles.montserratBoldTextStyle(
                          size: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.endDateController,
                        labletext: 'End Date',
                        hintText: "dd-mm-yyyy",
                        readOnly: true,
                        onTap: _handleEndDateSelection,
                      ),
                    ),
                  ],
                ),
                vGap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      context,
                      'Cancel',
                      Icons.cancel,
                      onTap: () {
                        Get.back();
                      },
                    ),
                    _buildActionButton(
                      context,
                      'Download Excel',
                      Icons.download,
                      onTap: () {
                        if (startDate == null || endDate == null) {
                          Get.snackbar(
                            'Error',
                            'Please select both start and end dates',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }
                        // controller.downloadTicketData();
                        // Add your download logic here
                        // You can access the selected dates using startDate and endDate
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

  }
  Widget _buildActionButton(
      BuildContext context,
      String label,
      IconData icon,
      {required VoidCallback onTap}
      ) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: MontserratStyles.montserratSemiBoldTextStyle(size: 13),
      ),
    );
  }
}

