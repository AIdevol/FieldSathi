import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/customer_list_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/const_local_keys.dart';

class CustomerListViewController extends GetxController{
  RxBool isLoading = false.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  final int itemsPerPage = 10;
  // CustomerDataResponseModel CustomerDataStr = CustomerDataResponseModel();
    RxList<CustomerData> customerListData = <CustomerData>[].obs;
  RxList<CustomerData> filteredCustomerListData = <CustomerData>[].obs;
  RxList<CustomerData> customerPaginationData = <CustomerData>[].obs;
    late TextEditingController customerNameController;
    late TextEditingController phoneController;
    late TextEditingController emailController;
    late TextEditingController companyNameController;
    late TextEditingController modelNoController;
    late TextEditingController productTypeController;
    late TextEditingController addressNameController;
    late TextEditingController landMarkController;
    late TextEditingController cityController;
    late TextEditingController stateController;
    late TextEditingController zipController;
    late TextEditingController countryController;
    late TextEditingController selectedRegionController;
    late TextEditingController searchController;

    late FocusNode customerFocusNode;
    late FocusNode phoneFocusNode;
    late FocusNode emailFocusNode;
    late FocusNode companyNameFocusNode;
    late FocusNode modelNoFocusNode;
    late FocusNode productTypeFocusNode;
    late FocusNode addressNamedFocusNode;
    late FocusNode landMarkFocusNode;
    late FocusNode cityFocusNode;
    late FocusNode stateFocusNode;
    late FocusNode zipFocusNode;
    late FocusNode countryFocusNode;
    late FocusNode selectedRegionFocusNode;
    RxList<String> regionValues = [
      // 'Select Region'
      "North",
      "West",
      'East',
      'South'
    ].obs;

    RxString defaultValue  = 'North'.obs;
      void updateRegion(String newValue){
        defaultValue.value = newValue;
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

  void calculateTotalPages() {
    totalPages.value = (filteredCustomerListData.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }
  }

  void updatePaginatedTechnicians() {
    List<CustomerData> sourceList = filteredCustomerListData.isEmpty
        ? customerListData
        : filteredCustomerListData;
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
    customerPaginationData.value = sourceList.sublist(
        startIndex,
        endIndex
    );

    update();
  }

    @override
    void onInit(){
      companyNameController = TextEditingController();
      customerNameController = TextEditingController();
      phoneController = TextEditingController();
      emailController = TextEditingController();
      customerNameController = TextEditingController();
      modelNoController = TextEditingController();
      productTypeController = TextEditingController();
      addressNameController = TextEditingController();
      landMarkController = TextEditingController();
      cityController = TextEditingController();
      stateController = TextEditingController();
      zipController = TextEditingController();
      countryController = TextEditingController();
      selectedRegionController = TextEditingController();
      searchController = TextEditingController();

      customerFocusNode = FocusNode();
      phoneFocusNode = FocusNode();
      emailFocusNode = FocusNode();
      companyNameFocusNode= FocusNode();
      customerFocusNode = FocusNode();
      modelNoFocusNode = FocusNode();
      productTypeFocusNode = FocusNode();
      addressNamedFocusNode = FocusNode();
      landMarkFocusNode = FocusNode();
      cityFocusNode = FocusNode();
      stateFocusNode = FocusNode();
      zipFocusNode = FocusNode();
      countryFocusNode = FocusNode();
      selectedRegionFocusNode = FocusNode();
      super.onInit();
      hitGetCustomerListApiCall();
      searchController.addListener(searchCustomers as VoidCallback );

    }

    @override
    void onClose(){
       customerNameController.dispose();
       phoneController.dispose();
      emailController.dispose();
  companyNameController.dispose();
      modelNoController.dispose();
       productTypeController.dispose();
      addressNameController.dispose();
       landMarkController.dispose();
      cityController.dispose();
      stateController.dispose();
       zipController.dispose();
    countryController.dispose();
       selectedRegionController.dispose();

        customerFocusNode.dispose();
       phoneFocusNode.dispose();
       emailFocusNode.dispose();
       companyNameFocusNode.dispose();
        modelNoFocusNode.dispose();
        productTypeFocusNode.dispose();
        addressNamedFocusNode.dispose();
        landMarkFocusNode.dispose();
        cityFocusNode.dispose();
        stateFocusNode.dispose();
        zipFocusNode.dispose();
        countryFocusNode.dispose();
        selectedRegionFocusNode.dispose();
      super.onClose();
    }

    // searching filteration
  void searchCustomers() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      filteredCustomerListData.assignAll(customerListData);
    } else {
      // Filter the customer list based on multiple attributes
      filteredCustomerListData.value = customerListData.where((customer) {
        return
          // Search across multiple fields
          (customer.customerName?.toLowerCase().contains(query) ?? false) ||
              (customer.companyName?.toLowerCase().contains(query) ?? false) ||
              (customer.email?.toLowerCase().contains(query) ?? false) ||
              (customer.phoneNumber?.toLowerCase().contains(query) ?? false) ||
              (customer.primaryAddress?.toLowerCase().contains(query) ?? false) ||
              (customer.modelNo?.toLowerCase().contains(query) ?? false) ||
              (customer.region?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Reset pagination to first page after filtering
    currentPage.value = 1;

    // Recalculate total pages and update pagination
    calculateTotalPages();
    updatePaginatedTechnicians();
  }
  void hitGetCustomerListApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var parameterdata = {
      "role":"customer",
      'page': currentPage.value,
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getCustomerListApiCall(parameters: parameterdata).then((value)async{
    customerListData.assignAll(value.results);
    filteredCustomerListData.assignAll(value.results);
    customerPaginationData.assignAll(value.results);
    List<String> customerIds = customerListData.map((agent) => agent.id.toString()).toList();
    await storage.write(customerId, customerIds.join(','));
    print('customer id : ${await storage.read(customerId)}');
    calculateTotalPages();
    customLoader.hide();
    toast('Customer List Successfully Fetched');
    update();
 }).onError((error , stackError){
    customLoader.hide();
    toast(error.toString());
    isLoading.value = false;
    });
  }

  Future<void> hitRefresshApiCall() async{
    hitGetCustomerListApiCall();
  }

  void hitPutMethoApiCalltoUpdateCustomerListApiCall(String id){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var primaryCustomerData= {
      "email": emailController.text.trim(),
      "phone_number": phoneController.text.trim(),
      "customer_name": customerNameController.text.trim(),
      "company_name": companyNameController.text.trim() ?? "",
      "brand_names": [productTypeController.text.trim() ?? ""],
      "model_no": modelNoController.text.trim() ?? "",
      "customer_type": "",
      "primary_address": addressNameController.text.trim() ?? "",
      "landmark_paci": landMarkController.text.trim() ?? "",
      "country": countryController.text.trim() ?? "",
      "state": stateController.text.trim() ?? "",
      "city": cityController.text.trim() ?? "",
      "zipcode": zipController.text.trim() ?? "",
      "region": defaultValue.value ?? "North",
      "role": "customer"
    };
    Get.find<AuthenticationApiService>().putCustomerListApiCall(id: id,dataBody: primaryCustomerData).then((value){
        toast('Customer Data Updated Successfully');
        customLoader.hide();
        hitGetCustomerListApiCall();
        update();
    }).onError((error, stackError){
        toast(error.toString());
        customLoader.hide();
        isLoading.value = false;
    });
  }

  void hitDeletemethodApiCall(String id){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().deleteCustomerListApiCall(id: id).then((value){
      toast(value.message.toString());
      hitGetCustomerListApiCall();
      update();
    }).onError((error,stackError){
      hitGetCustomerListApiCall();
      isLoading.value= false;
    });
  }


}