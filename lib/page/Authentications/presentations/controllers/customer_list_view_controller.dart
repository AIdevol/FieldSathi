import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/customer_list_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/const_local_keys.dart';

class CustomerListViewController extends GetxController{
  RxBool isLoading = false.obs;
  CustomerDataResponseModel CustomerDataStr = CustomerDataResponseModel();
    RxList<CustomerData> customerListData = <CustomerData>[].obs;
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
    List<String> regionValues = [
      // 'Select Region'
      "North",
      "West",
      'East',
      'South'
    ];

    String defaultValue  = 'North';
  void updateRegion(String newValue){
    defaultValue = newValue;
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

      customerFocusNode = FocusNode();
      phoneFocusNode = FocusNode();
      emailFocusNode = FocusNode();
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
    }

    @override
    void onClose(){
      companyNameController.dispose();
      customerNameController.dispose();
      phoneController.dispose();
      emailController.dispose();
      customerNameController.dispose();
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
      customerFocusNode.dispose();
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

  void hitGetCustomerListApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var parameterdata = {
      "role":"customer",
    };
    Get.find<AuthenticationApiService>().getCustomerListApiCall(parameters: parameterdata).then((value)async{
    customerListData.assignAll(value.results);
    List<String> customerIds = customerListData.map((agent) => agent.id.toString()).toList();
    await storage.write(customerId, customerIds.join(','));
    print('customer id : ${await storage.read(customerId)}');
    customLoader.hide();
    toast('Customer List Successfully Fetched');
    update();
 }).onError((error , stackError){
        customLoader.hide();
        toast(error.toString());
        isLoading.value = false;
    });
  }
}