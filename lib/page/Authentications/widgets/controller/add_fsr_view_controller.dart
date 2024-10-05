import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../presentations/controllers/fsr_screen_controller.dart';

class AddFSRViewController extends GetxController{
    late TextEditingController firstNameController;
    late TextEditingController discriptionController;

    late FocusNode firstNameFocusNode;
    late FocusNode discriptionFocusNode;



  @override
  void onInit(){
    firstNameController = TextEditingController();
    discriptionController = TextEditingController();

    firstNameFocusNode = FocusNode();
    discriptionFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose(){
    firstNameController.dispose();
    discriptionController.dispose();
    firstNameFocusNode.dispose();
    discriptionFocusNode.dispose();
    super.onClose();
  }

  void hitPostFsrDetailsApiCall(){
    // final checkpointsdata = Get.put(FsrViewcontroller()).checkPointStatusCheckingController;
      customLoader.show();
      FocusManager.instance.primaryFocus!.context;
      var postData = {
        "fsrName": firstNameController.text,
        "categories": [
        {"name": discriptionController.text,
        "checkpoints": ''}
      ]
      };
      Get.find<AuthenticationApiService>().postfsrDetailsApiCall(dataBody: postData).then((value){
        customLoader.hide();
        toast('post updated successfully');
        update();
      }).onError((error, stackError){
        customLoader.hide();
        toast(error.toString());
      });
  }
}