import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/amc_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class AMCScreenController extends GetxController{
  RxBool isLoading = false.obs;
  RxList<AmcResponseModel> amcData = <AmcResponseModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    hitGetAmcDetailsApiCall();
  }

  @override
  void onClose(){
    super.onClose();
  }

  void hitGetAmcDetailsApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    // try{
    //   final amcValues=Get.find<AuthenticationApiService>().getAmcDetailsApiCall();
    //   amcData.assignAll(amcValues);
    //   toast("Amc Fetched successfully");
    //   customLoader.hide();
    // }catch(error){
    //   toast(error.toString());
    // }finally {
    //   customLoader.hide();
    //   isLoading.value = false;
    // }
    Get.find<AuthenticationApiService>().getAmcDetailsApiCall().then((value){
      amcData.assignAll(value);
      customLoader.hide();
      toast("AMC successfully Fetched");
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }
}