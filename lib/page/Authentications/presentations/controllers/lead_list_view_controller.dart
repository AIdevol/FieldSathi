import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/lead_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class LeadListViewController extends GetxController{
  RxList<String> leadStatusValue = [
    "Select Status",
    "Inactive",
    "Interact",
    "In-Discussion",
    "Quote Sent",
    "Service Taken",
    "Not Interested",
  ].obs;

  RxString dropdownValue = "Select Status".obs;
  RxBool isLoading = true.obs;
  RxList<LeadResult> leadListData = <LeadResult>[].obs;

  RxString InActiveValue = "".obs ;
  RxString IntractValue = "".obs ;
  RxString IndiscussionValue = "".obs ;
  RxString QuoteSentValue = "".obs ;
  RxString ServiceTakenValue = "".obs ;
  RxString NoInterestedValue = "".obs ;
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
@override
  void onInit(){
  super.onInit();
  fetchedLeadListApiCall();
  fetchLeadStatusListApiCall();
}

@override
  void onClose(){
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

  void fetchedLeadListApiCall(){
  isLoading.value = true;
  // customLoader.show();
  FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getLeadListApiCall().then((value){
      leadListData.assignAll(value.results!);
      customLoader.hide();
      toast("Lead list fetched successfully");
      update();
    }).onError((error,stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }


void fetchLeadStatusListApiCall(){
  isLoading.value = true;
  customLoader.show();
  FocusManager.instance.primaryFocus!.unfocus();
  Get.find<AuthenticationApiService>().getLeadStatusApiCall().then((value){
    InActiveValue.value = value.inactive.toString();
    IntractValue.value = value.interact.toString();
    IndiscussionValue.value = value.inDiscussion.toString();
    QuoteSentValue.value = value.quoteSent.toString();
    ServiceTakenValue.value = value.serviceTaken.toString();
    NoInterestedValue.value = value.notInterested.toString();
    toast("Lead Status fetch succesffuly");
    customLoader.hide();
    update();
  }).onError((error, stackError){
    customLoader.hide();
    toast(error.toString());
    isLoading.value = false;
  });
  }
}