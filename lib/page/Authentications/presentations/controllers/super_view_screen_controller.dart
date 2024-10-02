import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../response_models/leaves_response_model.dart';
import '../../../../response_models/super_user_response_model.dart';

class SuperViewScreenController extends GetxController{

  RxList<Result> filteredData = <Result>[].obs;

  RxBool isLoading = false.obs;


  @override
  void onInit(){
    hitsuperUserApiCall();
    super.onInit();
  }

  @override
  void onClose(){
    super.onClose();
  }


  void hitsuperUserApiCall(){
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var dataParameters ={
      "role": "superuser"
    };
    Get.find<AuthenticationApiService>().getSuperUserApiCall(parameters: dataParameters).then((value){
    var superData = value;
    print("sueruser = $superData");
    customLoader.hide();
    update();
    }).onError((error ,stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }
}