import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../response_models/super_user_response_model.dart';

class AgentsViewScreenController extends GetxController{
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  late FocusNode firstNameFocusNode;
  late FocusNode lastNameFocusNode;
  late FocusNode emailFocusnode;
  late FocusNode phoneFocusNode;
  RxBool isLoading = false.obs;
  RxList<Result> agentsData = <Result>[].obs;


  @override
  void onInit(){
    firstNameController = TextEditingController();
    lastNameController  = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    emailFocusnode = FocusNode();
    phoneFocusNode = FocusNode();
    super.onInit();
    hitGetAgentsDetailsApiCall();
  }

  @override
  void onClose(){
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void hitGetAgentsDetailsApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var parameterdata ={
      "role":"agent"
    };
    Get.find<AuthenticationApiService>().getAgentDetailsApiCall(parameters: parameterdata).then((value){
      agentsData.assignAll(value.results);
      // var agentsData = value;
      // print("ajdfladjf= ${value.results.}")
      customLoader.hide();
      toast("Agents Fetched Successfully");
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }
}