import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/lead_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class LeadListViewController extends GetxController{
  RxBool isLoading = true.obs;
  RxList<LeadGetResponseModel> leadListData = <LeadGetResponseModel>[].obs;

@override
  void onInit(){
  super.onInit();
  fetchedLeadListApiCall();
}

@override
  void onClose(){
  super.onClose();
}

  void fetchedLeadListApiCall(){
  isLoading.value = true;
  customLoader.show();
  FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getLeadListApiCall().then((value){
      leadListData.assignAll(value);
      customLoader.hide();
      toast("Lead list fetched successfully");
      update();
    }).onError((error,stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }
}