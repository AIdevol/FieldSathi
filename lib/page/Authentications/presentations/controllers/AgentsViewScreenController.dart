// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:tms_sathi/constans/const_local_keys.dart';
// import 'package:tms_sathi/main.dart';
// import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
//
// import '../../../../response_models/super_user_response_model.dart';
//
// class AgentsViewScreenController extends GetxController {
//   late TextEditingController firstNameController;
//   late TextEditingController lastNameController;
//   late TextEditingController emailController;
//   late TextEditingController phoneController;
//
//   late FocusNode firstNameFocusNode;
//   late FocusNode lastNameFocusNode;
//   late FocusNode emailFocusnode;
//   late FocusNode phoneFocusNode;
//   RxBool isLoading = false.obs;
//   RxList<Result> agentsData = <Result>[].obs;
//
//   @override
//   void onInit() {
//     firstNameController = TextEditingController();
//     lastNameController = TextEditingController();
//     emailController = TextEditingController();
//     phoneController = TextEditingController();
//
//     firstNameFocusNode = FocusNode();
//     lastNameFocusNode = FocusNode();
//     emailFocusnode = FocusNode();
//     phoneFocusNode = FocusNode();
//     super.onInit();
//     hitGetAgentsDetailsApiCall(agentId);
//   }
//
//   @override
//   void onClose() {
//     firstNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     super.onClose();
//   }
//
//   void hitGetAgentsDetailsApiCall(agentId) {
//     isLoading.value = true;
//     customLoader.show();
//     FocusManager.instance.primaryFocus!.context;
//     var parameterdata = {
//       "role": "agent"
//     };
//     Get.find<AuthenticationApiService>().getAgentDetailsApiCall(
//         parameters: parameterdata).then((value) async{
//       agentsData.assignAll(value.results);
//       List<String> agentIds = agentsData.map((agent) => agent.id.toString()).toList();
//       await storage.write(agentId, agentIds.join(','));
//       List<String>firstName = agentsData.map((agent)=> agent.firstName.toString()).toList();
//      List<String>lastName = agentsData.map((agent)=> agent.lastName.toString()).toList();
//       List<String>email = agentsData.map((agent)=> agent.email.toString()).toList();
//       List<String>phone = agentsData.map((agent)=> agent.phoneNumber.toString()).toList();
//       firstNameController.text = firstName.join(',');
//       lastNameController.text = lastName.join(',');
//       emailController.text = email.join(',');
//       phoneController.text = phone.join(',');
//       customLoader.hide();
//       toast("Agents Fetched Successfully");
//       update();
//     }).onError((error, stackError) {
//       customLoader.hide();
//       toast(error.toString());
//       isLoading.value = false;
//     });
//   }
//
//   void hitPutAgentsDetailsApiCall(agentId) {
//     isLoading.value = true;
//     customLoader.show();
//     FocusManager.instance.primaryFocus!.context;
//     var agentDetails = {
//       "first_name": firstNameController.text,
//       "last_name": lastNameController.text,
//       "phone_number": phoneController.text,
//       "email": emailController.text,
//     };
//     var parameterdata = {
//       "role": "agent"
//     };
//
//     Get.find<AuthenticationApiService>().putAgentDetailwsApiCall(
//         dataBody: agentDetails, parameters: parameterdata, id: agentId).then((value) {
//       var agentdetails = value;
//       print('agent posted data = $agentdetails');
//       customLoader.hide();
//       toast('Agent Created successfully');
//       hitGetAgentsDetailsApiCall(agentId);
//       Get.back();
//       update();
//     }).onError((error, stackError) {
//       customLoader.hide();
//       toast(error.toString());
//     });
//   }
//
//
//   void hitUpdateStatusValue(agentId){
//     isLoading.value = true;
//     customLoader.show();
//     FocusManager.instance.primaryFocus!.context;
//     var UpdatedData ={
//       "status":""
//     };
//     Get.find<AuthenticationApiService>().putAgentDetailwsApiCall(dataBody:UpdatedData ,id: agentId).then((value){
//       customLoader.hide();
//       toast("Status Updated");
//       update();
//     }).onError((error, stackError){
//       customLoader.hide();
//       toast(error.toString());
//     });
//
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:tms_sathi/response_models/super_user_response_model.dart';

class AgentsViewScreenController extends GetxController {
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
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
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
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void hitGetAgentsDetailsApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var parameterdata = {
      "role": "agent",
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getAgentDetailsApiCall(
        parameters: parameterdata).then((value) async {
      agentsData.assignAll(value.results);
      List<String> agentIds = agentsData.map((agent) => agent.id.toString()).toList();
      await storage.write(agentId, agentIds.join(','));
      customLoader.hide();
      toast("Agents Fetched Successfully");
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitPutAgentsDetailsApiCall(String agentId) {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var agentDetails = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone_number": phoneController.text,
      "email": emailController.text,
    };
    var parameterdata = {
      "role": "agent"
    };

    Get.find<AuthenticationApiService>().putAgentDetailwsApiCall(
        dataBody: agentDetails, parameters: parameterdata, id: agentId).then((value) {
      var agentdetails = value;
      print('agent posted data = $agentdetails');
      customLoader.hide();
      toast('Agent Updated successfully');
      hitGetAgentsDetailsApiCall();
      Get.back();
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void hitUpdateStatusValue(String agentId) {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var updatedData = {
      "status": "inactive"  // You might want to toggle this based on current status
    };
    Get.find<AuthenticationApiService>().putAgentDetailwsApiCall(dataBody: updatedData, id: agentId).then((value) {
      customLoader.hide();
      toast("Status Updated");
      hitGetAgentsDetailsApiCall();  // Refresh the list after updating
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void hitDeleteStatuApiValue(String agentId){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();

  }
}