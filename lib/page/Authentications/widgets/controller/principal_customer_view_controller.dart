import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/customer_list_view_controller.dart';
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
    void onInit() {
      companyNameController = TextEditingController();
      customerNameController = TextEditingController();
      phoneController = TextEditingController();
      emailController = TextEditingController();
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
      companyNameFocusNode = FocusNode();
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


    @override
    void onClose() {
      companyNameController.dispose();
      customerNameController.dispose();
      phoneController.dispose();
      emailController.dispose();
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

    RxList<String> regionValues = [
    // 'Select Region'
    "North",
    "West",
    'East',
    'South'
  ].obs;

  RxString defaultValue  = 'North'.obs;

  var phoneCountryCode = "".obs;

  void updateRegion(String newValue){
    defaultValue.value = newValue;
    update();
  }

    void hitPostCustomerApiCall() {
      // Validate input fields
      if (emailController.text.isEmpty ||
          phoneController.text.isEmpty ||
          customerNameController.text.isEmpty) {
        toast("Please fill in required fields");
        return;
      }

      isLoading.value = true;
      customLoader.show();
      FocusManager.instance.primaryFocus!.unfocus();

      var primaryData = {
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
      print("customer data ${primaryData}");
      Get.find<AuthenticationApiService>()
          .postCustomerListApiCall(dataBody: primaryData)
          .then((value) {
        print("customerdata : $value");
        customLoader.hide();
        Get.back();
        Get.put(CustomerListViewController()).hitGetCustomerListApiCall();
        toast("Customer Added Successfully");
        update();
      }).onError((error, stackTrace) {
        customLoader.hide();
        toast(error.toString());
        isLoading.value = false;
      });
    }
}