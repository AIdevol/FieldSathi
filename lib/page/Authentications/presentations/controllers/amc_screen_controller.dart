import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/amc_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class AMCScreenController extends GetxController{

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
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getAmcDetailsApiCall().then((value){
      var amcdatalist = value;
      customLoader.hide();
      toast("AMC successffuly Fetched");
      update();
    }).onError((error, stackError){
      customLoader.hide();
    });
  }
}