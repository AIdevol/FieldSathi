import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/super_view_screen_controller.dart';
import 'package:tms_sathi/response_models/agents_response_model.dart';

import '../../../../main.dart';
import '../../../../response_models/super_user_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class AgentsListController extends GetxController {
  late TextEditingController employeeIdController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController joiningDateController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  late FocusNode employeeIdFocusNode;
  late FocusNode firstNameFocusNode;
  late FocusNode lastNameFocusNode;
  late FocusNode joiningDateFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode phoneFocusNode;
  var phoneCountryCode = ''.obs;
  DateTime? selectedDate;
  RxBool isLoading = false.obs;
  RxList<Result> filteredData = <Result>[].obs;

  @override
  void onInit() {
    employeeIdController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    joiningDateController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    employeeIdFocusNode = FocusNode();
    firstNameFocusNode = FocusNode();
    joiningDateFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    employeeIdController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    joiningDateController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void hitPostAgentsDetailsApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var agentDetails = {
      "emp_id": employeeIdController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone_number": phoneController.text,
      "email": emailController.text,
      "date_joined": selectedDate != null
    ? DateFormat('yyyy-MM-dd').format(selectedDate!)
        : "",
      "role":"agent",// Add joining date to API call
    };
    print("agents enetered data:$agentDetails");
    Get.find<AuthenticationApiService>().postAgentDetailwsApiCall(dataBody: agentDetails).then((value) {
      customLoader.hide();
      toast('Agent Created successfully');
      hitsuperUserApiCall();
      // Get.put(SuperViewScreenController()).hitsuperUserApiCall();
      Get.back(); // Navigate back after successful creation
      update();
    })
        .onError((error, stackTrace) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void hitsuperUserApiCall(){
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    var dataParameters ={
      "role": "superuser",
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getSuperUserApiCall(parameters: dataParameters).then((value){
      filteredData.assignAll(value.results);
      List<String> managerIds= filteredData.map((manager)=>manager.id.toString()).toList();
      print("sueruser = ${managerIds}");
      update();
    }).onError((error ,stackError){
      toast(error.toString());
      isLoading.value = false;
    });
  }
  bool _validateForm() {
    if (employeeIdController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        selectedDate == null) {
      toast('Please fill all required fields');
      return false;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      toast('Please enter a valid email address');
      return false;
    }

    if (!GetUtils.isPhoneNumber(phoneController.text)) {
      toast('Please enter a valid phone number');
      return false;
    }

    return true;
  }
}