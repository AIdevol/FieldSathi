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
    super.onInit();
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
    });
  }

  Future<void> refreshSupperData()async{
    hitsuperUserApiCall();
  }
}