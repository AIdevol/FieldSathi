import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../response_models/leaves_response_model.dart';
import '../../../../response_models/super_user_response_model.dart';

class SuperViewScreenController extends GetxController{

  RxList<Result> filteredData = <Result>[].obs;
  RxList<Result> datafilter = <Result>[].obs;
  RxList<Result> filterePaginationsData = <Result>[].obs;
  late TextEditingController searchController;

  RxBool isLoading = false.obs;
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
  void onInit(){
    hitsuperUserApiCall();
    searchController = TextEditingController();
    super.onInit();
    searchController.addListener(applyFilter);
  }

  @override
  void onClose(){
    emailController.dispose();
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    employeeIdController.dispose();
    joiningDateController.dispose();
    super.onClose();
  }

  void applyFilter() {
    final query = searchController.text.trim().toLowerCase();
    print("searched element: $query");
    if(query.isEmpty){
      // If search query is empty, reset to original data
      filterePaginationsData.assignAll(datafilter);
    } else {
      // Perform case-insensitive, comprehensive search across multiple fields
      filterePaginationsData.assignAll(datafilter.where((userData) {
        return (userData.firstName?.toLowerCase().contains(query) ?? false) ||
            (userData.lastName?.toLowerCase().contains(query) ?? false) ||
            (userData.empId?.toLowerCase().contains(query) ?? false) ||
            (userData.email?.toLowerCase().contains(query) ?? false) ||
            (userData.phoneNumber?.toLowerCase().contains(query) ?? false) ||
            // Combine first and last name for full name search
            "${userData.firstName ?? ''} ${userData.lastName ?? ''}".toLowerCase().contains(query);
      }).toList());
    }

    // Reset pagination after filtering
    currentPage.value = 1;
    calculateTotalPages();
    updatePaginatedTechnicians();
  }

  void calculateTotalPages() {
    totalPages.value = (datafilter.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }
  }

  void updatePaginatedTechnicians() {
    List<Result> sourceList = datafilter.isEmpty
        ? filteredData
        : datafilter;
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
    filterePaginationsData.value = sourceList.sublist(
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


  void hitsuperUserApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var dataParameters ={
      "role": "superuser",
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getSuperUserApiCall(parameters: dataParameters).then((value){
     filteredData.assignAll(value.results);
     datafilter.assignAll(value.results);
     filterePaginationsData.assignAll(value.results);
    List<String> managerIds= filteredData.map((manager)=>manager.id.toString()).toList();
    print("sueruser = ${managerIds}");
     calculateTotalPages();
    customLoader.hide();
    update();
    }).onError((error ,stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  Future<void> refreshSupperData()async{
    hitsuperUserApiCall();
  }


}