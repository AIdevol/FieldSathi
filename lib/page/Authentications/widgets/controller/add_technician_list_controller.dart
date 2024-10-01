import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class AddTechnicianListController extends GetxController{

  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController dobController;

  late FocusNode emailFocusNode;
  late FocusNode firstFocusNode;
  late FocusNode lastFocusNode;
  late FocusNode phoneFocusNode;

  @override
  void onInit(){
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    dobController = TextEditingController();

    emailFocusNode = FocusNode();
    firstFocusNode = FocusNode();
    lastFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose(){
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    dobController.dispose();
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
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
    }
  }

  void hitAddTechnicianApiCall(){
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var elementBody={
      "first_name":firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "phone_number":phoneController.text,
      "dob": dobController.text
    };
    var parameterBody = {
      "role": "technician"
    };
    Get.find<AuthenticationApiService>().addTechnicialPostApiCall(dataBody: elementBody, parameters: parameterBody).then((value){
      var mainData = value;
      print("maindata of technician= $mainData");
      customLoader.hide();
      toast('Technician Added Successfully!');
      update();  // update to the method after data entered
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }
}
