import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/main.dart';

class AddSuperUserViewController extends GetxController{
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  RxBool isLoading = true.obs;



  @override
  void onInit(){
    super.onInit();
  }

  @override
  void onClose(){
    joiningDateController.dispose();
    employeeIdController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

void hitPostAddSupperApiCallApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;

}

}