import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:tms_sathi/utilities/custom_dialogue.dart';

class HomeScreenController extends GetxController{
  final RxString profileImageUrl = RxString('');

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
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomDialogue(
          onOkTap: () {
            Get.back();
          },
          title: 'Welcome',
          desc: 'Welcome to your universe',
        );
      },
    );
  }
  void hitGetuserDetailsApiCall(){
    final userid = storage.read(userId);
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().userDetailsApiCall(id: userid).then((value){
      var userData = value;
      customLoader.hide();
      profileImageUrl.value = userData.profileImage ?? '';
      toast('Details successfully fetched');
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }
}