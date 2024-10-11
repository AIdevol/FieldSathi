import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/response_models/agents_response_model.dart';

import '../../../../main.dart';
import '../../../../response_models/super_user_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class AgentsListController extends GetxController{

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

  AgentsPostResponseModel localValueAgentsData = AgentsPostResponseModel();


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
    // hitGetAgentsDetailsApiCall();
  }

  @override
  void onClose(){
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }



  void hitPostAgentsDetailsApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var agentDetails = {
      "first_name":firstNameController.text,
      "last_name":lastNameController.text,
      "phone_number":phoneController.text,
      "email": emailController.text,
    };
    var parameterdata ={
      "role":"agent"
    };
    Get.find<AuthenticationApiService>().postAgentDetailwsApiCall(dataBody: agentDetails,parameters:parameterdata ).then((value){
      var localValueAgentsData = value;
      print('agent posted data = $localValueAgentsData');
      // hitGetAgentsDetailsApiCall();
      customLoader.hide();
      toast('Agent Created successfully');
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }
}