import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
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

  DateTime? selectedDate;
  RxBool isLoading = false.obs;
  RxList<Result> agentsData = <Result>[].obs;

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
    if (!_validateForm()) return;

    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();

    var agentDetails = {
      "id": employeeIdController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone_number": phoneController.text,
      "email": emailController.text,
      "joining_date": selectedDate?.toIso8601String(), // Add joining date to API call
    };

    var parameterData = {
      "role": "agent"
    };

    Get.find<AuthenticationApiService>()
        .postAgentDetailwsApiCall(
      dataBody: agentDetails,
      parameters: parameterData,
    )
        .then((value) {
      customLoader.hide();
      toast('Agent Created successfully');
      Get.back(); // Navigate back after successful creation
      update();
    })
        .onError((error, stackTrace) {
      customLoader.hide();
      toast(error.toString());
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