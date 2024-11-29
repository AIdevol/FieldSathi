import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../response_models/sales_response_model.dart';

class SalesViewScreenController extends GetxController{
  RxBool isLoading = true.obs;
  RxSet<SalesResponseModel> salesResponse = <SalesResponseModel>{}.obs;
  RxList<SalesResutls> salesData = <SalesResutls>[].obs;

  late TextEditingController employeeIdController;
  late TextEditingController dateJoiningController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  late FocusNode employeeIdFocusNode;
  late FocusNode lastFocusNode;
  late FocusNode dateJoiningFocusNode;
  late FocusNode firstFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode phoneFocusNode;

  @override
  void onInit(){
    employeeIdController = TextEditingController();
    dateJoiningController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    lastFocusNode = FocusNode();
    employeeIdFocusNode = FocusNode();
    dateJoiningFocusNode = FocusNode();
    firstFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    super.onInit();
    hitGetSalesApiCall();
  }
  @override
  void onClose(){
    employeeIdController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    dateJoiningController.dispose();
    emailController.dispose();
    phoneController.dispose();

    lastFocusNode.dispose();
    dateJoiningFocusNode.dispose();
    employeeIdFocusNode.dispose();
    firstFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    super.onClose();
  }

  int _currentPage = 0;
  final int _itemsPerPage = 10;

  int get currentPage => _currentPage;
  int get totalPages => (salesData.length / _itemsPerPage).ceil();

  List<SalesResutls> getPaginatedSalesData() {
    if (salesData.isEmpty) return [];
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;

    return salesData.sublist(
        startIndex,
        endIndex > salesData.length ? salesData.length : endIndex
    );
  }

  void initializePagination() {
    _currentPage = 0;
    update();
  }

  bool canPreviousPage() => _currentPage > 0;
  bool canNextPage() => _currentPage < totalPages - 1;

  void previousPage() {
    if (canPreviousPage()) {
      _currentPage--;
      update();
    }
  }

  void nextPage() {
    if (canNextPage()) {
      _currentPage++;
      update();
    }
  }

  // Method to be called when sales data is first loaded or refreshed
  // void setSalesData(SalesResutls data) {
  //   salesData = data;
  //   initializePagination();
  // }

  void hitGetSalesApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var salesParameters={
      "role":"sales",
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getSalesDetailsApiCall(parameters: salesParameters).then((value){
      salesData.assignAll(value.results);
      customLoader.hide();
      toast("Sales fetch successfully");
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitRefreshGetSalesApiCall(){
    hitGetSalesApiCall();
  }
  void initializeWithSalesData(SalesResutls salesData) {
    employeeIdController.text = salesData.empId ?? '';
    dateJoiningController.text = salesData.dateJoined.toString() ?? '';
    firstNameController.text = salesData.firstName ?? '';
    lastNameController.text = salesData.lastName ?? '';
    emailController.text = salesData.email!;
    phoneController.text = salesData.phoneNumber!;
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
      dateJoiningController.text = formattedDate;
    }
  }

  void updateSalesData(String agentId) {
    var updateData = {
      "employee_id": employeeIdController.text,
      "date_joined": dateJoiningController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "phone_number": phoneController.text,
    };

    customLoader.show();
    Get.find<AuthenticationApiService>()
        .updateAddSalesDetailsApiCall(
      dataBody: updateData,
      id: agentId
      // agentId: agentId,
    )
        .then((value) {
      customLoader.hide();
      Get.back(); // Close dialog
      hitRefreshGetSalesApiCall(); // Refresh the list
      toast("Sales data updated successfully");
    }).catchError((error) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void clearFormData() {
    employeeIdController.clear();
    dateJoiningController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
  }

  Future<void> deleteSalesData(String id)async {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().deleteAddSalesDetailsApiCall(id: id).then((value){
      customLoader.hide();
      toast("deleted sales person");
      hitGetSalesApiCall();
      update();
    }).onError((error,stackError){
      customLoader.hide();
      hitGetSalesApiCall();
    });
  }
}

  // selectDate(BuildContext context) {}
