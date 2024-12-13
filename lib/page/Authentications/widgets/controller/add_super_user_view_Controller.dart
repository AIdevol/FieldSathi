import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../presentations/controllers/super_view_screen_controller.dart';

class AddSuperUserViewController extends GetxController{
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  RxBool isLoading = true.obs;

  var phoneCountryCode = "".obs;



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
    var parametersData = {
        "first_name":firstNameController.text,
        "last_name":lastNameController.text,
        "emp_id":employeeIdController.text,
        "email":emailController.text,
        "phone_number":phoneController.text,
        "role":"superuser",
        "date_joined":joiningDateController.text
    };
    Get.find<AuthenticationApiService>().postSuperUserApiCall(dataBody: parametersData).then((value){
        customLoader.hide();
        toast("Manager created successfully");
        Get.back();
        Get.put(SuperViewScreenController()).hitsuperUserApiCall();
        update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value =false;
    });
}

}