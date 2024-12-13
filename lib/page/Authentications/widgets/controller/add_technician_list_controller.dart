import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../response_models/add_technician_response_model.dart';
import '../../presentations/controllers/technician_list_view_screen_controller.dart';

class AddTechnicianListController extends GetxController{

  late TextEditingController employeeIdController;
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController dateJoiningController;

  late FocusNode employeeIdFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode firstFocusNode;
  late FocusNode lastFocusNode;
  late FocusNode phoneFocusNode;
  RxString phoneCountryCode = ''.obs;
  @override
  void onInit(){
    employeeIdController = TextEditingController();
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    dateJoiningController = TextEditingController();

    employeeIdFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    firstFocusNode = FocusNode();
    lastFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose(){
    employeeIdController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    dateJoiningController.dispose();
    super.onClose();
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateJoiningController.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
    }
  }

  void hitAddTechnicianApiCall(){
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var elementBody={
      "emp_id":employeeIdController.text,
      "first_name":firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "phone_number":phoneCountryCode.value+phoneController.text,
      "dob": dateJoiningController.text,
      "role":"technician"
    };
    // var parameterBody = {
    //   "role": "technician"
    // };
    Get.find<AuthenticationApiService>().addTechnicialPostApiCall(dataBody: elementBody).then((value){
      var mainData = value;
      print("maindata of technician= $mainData");
      customLoader.hide();
      toast('Technician Added Successfully!');
      Get.back();
      Get.put(TechnicianListViewScreenController()).hitGetTechnicianApiCall();
      // Get.offAllNamed(AppRoutes.technicianListsScreen);
      update();  // update to the method after data entered
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }
}
