import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:tms_sathi/utilities/custom_dialogue.dart';

class HomeScreenController extends GetxController{

  @override
  void onInit(){
    super.onInit();
    hitGetuserDetailsApiCall();
  }

  @override
  void onClose(){
    super.onClose();
  }

  void onReady(){
    super.onReady();
    showDialog(
        context: Get.context!, builder: (BuildContext context){
        return CustomDialogue(title: "Welcome", content: "Welcome to your Universe");
    });
  }
  void hitGetuserDetailsApiCall(){
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().userDetailsApiCall().then((value){
      customLoader.hide();
      toast('Details successfully fetched');
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }
}