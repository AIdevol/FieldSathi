import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/lead_list_view_controller.dart';
import 'package:tms_sathi/response_models/lead_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../main.dart';

class LeadFormFieldController extends GetxController{
  final TextEditingController companyController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController additionalNotesController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();

  // LeadPostResponseModel leadlistData = LeadPostResponseModel().obs;
  RxBool isLoading = true.obs;
  List<String> regionValues = [
    'Select Region'
        "North",
    "West",
    'East',
    'South'
  ];

  String defaultValue  = 'Select Region';

  var phoneCountryCode ="".obs;

  void updateRegion(String newValue){
    defaultValue = newValue;
    update();
  }

  bool validateForm() {
    if (companyController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        countryController.text.isEmpty ||
        stateController.text.isEmpty ||
        cityController.text.isEmpty ||
        sourceController.text.isEmpty) {
      toast('Please fill out all required fields.');
      return false;
    }
    return true;
  }

  void onSubmitForm() {
    if (validateForm()) {
      toast('Lead form submitted successfully.');
    }
  }

  @override
  void onClose() {
    companyController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    additionalNotesController.dispose();
    sourceController.dispose();
    super.onClose();
  }

  void hitPostLeadListAPiCall(){
    if (!validateForm()) return;
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var leadFormData = {
      "companyName":companyController.text,
      "firstName":firstNameController.text,
      "lastName":lastNameController.text,
      "email":emailController.text,
      "mobile":phoneController.text,
      "address":addressController.text,
      "country":countryController.text,
      "state":stateController.text,
      "city":cityController.text,
      "notes":additionalNotesController.text,
      "source":sourceController.text
    };
    print("lead data: $leadFormData");
    Get.find<AuthenticationApiService>().postLeadListApiCall(dataBody: leadFormData).then((value){
      customLoader.hide();
      toast("Lead Created successfully");
      // Get.toNamed(AppRoutes.leadListScreen);
      Get.back();
      Get.put(LeadListViewController()).fetchedLeadListApiCall();
      update();
    }).onError((error, stackError){
      toast(error.toString());
      customLoader.hide();
    });
  }

  // void hitPostLeadlistApiCall(){
  //   isLoading.value = true;
  //   customLoader.show();
  //   FocusManager.instance.primaryFocus!.context;
  //   Map<String ,dynamic> leadData = {
  //     "companyName":companyController.text,
  //     "firstName":firstNameController.text,
  //     "lastName":lastNameController.text,
  //     "email": emailController.text,
  //     "mobile":phoneController.text,
  //     "address":addressController.text,
  //     "country":countryController.text,
  //     "state":stateController.text,
  //     "city": cityController.text,
  //     "source": sourceController,
  //     "notes": additionalNotesController.text,
  //     "status": 'In-Discussion',
  //   };
  //   Get.find<AuthenticationApiService>().postLeadListApiCall(dataBody: leadData).then((value){
  //     customLoader.hide();
  //     toast('Successfully added Lead list');
  //     update();
  //   }).onError((error, stackError){
  //     customLoader.hide();
  //     toast(error.toString());
  //   });
  // }
}