import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/customer_list_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class PrincipalCstomerViewController extends GetxController{
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
    RxBool isLoading = false.obs;
    // CustomerListResponseModel CustomerDataStr = CustomerListResponseModel.fromJson();
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
    }

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

  void hitPostCustomerApiCall(){
      isLoading.value = true;
      customLoader.show();
      FocusManager.instance.primaryFocus!.context;
      var primaryData = {
        "customer_name": customerNameController.text,
        "phone_number": phoneController.text,
        "email":emailController.text,
        "company_name": companyNameController.text,
        "model_no":modelNoController.text,
        "customer_type":productTypeController.text,
        "primary_address":addressNameController.text,
        "landmark_paci":landMarkController.text,
        "city":cityController.text,
        "state":stateController.text,
        "zipcode":zipController.text,
        "country":countryController.text,
        "region": defaultValue,
      };
      var parameterData = {
        "role": "customer"
      };
      Get.find<AuthenticationApiService>().postCustomerListApiCall(dataBody: primaryData, parameters: parameterData).then((value){
        var CustomerDataStr = value;
        print("customerdata : $CustomerDataStr");
        customLoader.hide();
      toast("Customer Added Successfully");
      update();
      }).onError((error, stackError){
        customLoader.hide();
        toast(error.toString());
        isLoading.value = false;
      });
  }
}