import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class TechnicianListViewScreenController extends GetxController {
  final searchController = TextEditingController();
  RxBool isLoading = true.obs;
  RxList<TechnicianData> allTechnicians = <TechnicianData>[].obs;
  RxList<TechnicianData> filteredTechnicians = <TechnicianData>[].obs;
  RxBool isTableView = true.obs;
  RxList<TechnicianData> paginatedTechnicians = <TechnicianData>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  final int itemsPerPage = 10;

  final employeeIdController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final joiningDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    hitGetTechnicianApiCall();
    searchController.addListener(onSearchChanged);
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    employeeIdController.dispose();
    joiningDateController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void calculateTotalPages() {
    totalPages.value = (filteredTechnicians.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }
  }

  void updatePaginatedTechnicians() {
    List<TechnicianData> sourceList = filteredTechnicians.isEmpty
        ? allTechnicians
        : filteredTechnicians;
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
    paginatedTechnicians.value = sourceList.sublist(
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

  void onSearchChanged() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredTechnicians.assignAll(allTechnicians);
    } else {
      filteredTechnicians.assignAll(allTechnicians.where((technician) =>
      technician.firstName!.toLowerCase().contains(query) ||
          technician.lastName!.toLowerCase().contains(query) ||
          technician.email!.toLowerCase().contains(query) ||
          technician.phoneNumber!.toLowerCase().contains(query)));
    }

    // Update total pages and current page for filtered results
    totalPages.value = (filteredTechnicians.length / itemsPerPage).ceil();
    currentPage.value = 1;
    updatePaginatedTechnicians();
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      joiningDateController.text = formattedDate;
    }
  }

  Future<void> hitGetTechnicianApiCall() async {
    try {
      isLoading.value = true;
      // customLoader.show();
      FocusManager.instance.primaryFocus?.unfocus();

      final roleWiseData = {
        'role': 'technician',
        "page":currentPage.value,
        "page_size": 'all'
      };

      final response = await Get.find<AuthenticationApiService>()
          .getTechnicianApiCall(parameters: roleWiseData);

      // Update both lists
      allTechnicians.assignAll(response.results!);
      filteredTechnicians.assignAll(response.results!); // Initialize filtered list
      paginatedTechnicians.assignAll(response.results!);
      // Store technician IDs
      calculateTotalPages();
      updatePaginatedTechnicians();
      final technicianIds = response.results?.map((e) => e.id.toString()).toList();
      await storage.write(attendanceId, technicianIds?.join(','));

      customLoader.hide();
      toast('Technicians fetched successfully');
    } catch (error, stackTrace) {
      print('Error fetching technicians: $error');
      print('Stack trace: $stackTrace');
      customLoader.hide();
      toast('Error fetching technicians: ${error.toString()}');
    } finally {
      isLoading.value = false;
      update(); // Ensure UI updates
    }
  }

  void refreshList() {
    hitGetTechnicianApiCall();
  }

  Future<void> deleteTechnician(String technicianId) async {
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus;
    Get.find<AuthenticationApiService>().deleteTechnicianDetailsApiCall(id: technicianId).then((value){
      customLoader.hide();
      toast("Deleted data successfully");
      hitGetTechnicianApiCall();
      update();
    }).onError((error, stackError){
      hitGetTechnicianApiCall();
      customLoader.hide();
      isLoading.value = false;
    });

  }

  // Add method to handle technician editing
  void updateTechnicianApiCall(String agentId){
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var elementBody={
      "emp_id":employeeIdController.text,
      "first_name":firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "phone_number":phoneController.text,
      "date_joined": joiningDateController.text,
      "role":"technician"
    };

    Get.find<AuthenticationApiService>().updateTechnicialPostApiCall(dataBody: elementBody,id: agentId).then((value){
      var mainData = value;
      print("maindata of technician= $mainData");
      customLoader.hide();
      toast('Technician Updated Successfully!');
      update();
      Get.back();
    }).onError((error, stackError){
      customLoader.hide();
      // toast(error.toString());
      toast(error.toString());
    });
  }

  void importTechnicians() {
    // Implement import functionality
  }

  void exportTechnicians() {
    // Implement export functionality
  }

  // Method to handle search
  void updateSearch(String query) {
    searchController.text = query;
    // _onSearchChanged will be called automatically due to listener
  }

  Future<void>refreshAllData()async{
    hitGetTechnicianApiCall();
  }
}