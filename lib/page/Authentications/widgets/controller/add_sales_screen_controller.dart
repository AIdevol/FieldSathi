import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/sales_view_screen_controller.dart';

import '../../../../main.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class AddSalesScreenController extends GetxController{
  late TextEditingController employeeIdController;
  late TextEditingController dateJoiningController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  late FocusNode employeeIdFocusNode;
  late FocusNode lastFocusNode;
  late FocusNode firstFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode phoneFocusNode;

  var phoneCountryCode = ''.obs;


  @override
  void onInit(){
    employeeIdController = TextEditingController();
    dateJoiningController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    lastFocusNode = FocusNode();
    employeeIdFocusNode = FocusNode();
    firstFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    super.onInit();
}

  @override
  void onClose(){
    employeeIdController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    dateJoiningController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
    FocusManager.instance.primaryFocus!.unfocus();
    var elementBody={
      "emp_id":employeeIdController.text,
      "first_name":firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "phone_number":phoneCountryCode.value + phoneController.text,
      "date_joined": dateJoiningController.text,
      "role": "sales"
    };
    // var parameterBody = {
    //   "role": "technician"
    // };
    Get.find<AuthenticationApiService>().postAddSalesDetailsApiCall(dataBody: elementBody).then((value){
      var mainData = value;
      print("maindata of sales= $mainData");
      customLoader.hide();
      toast('Sales Added Successfully!');
      Get.back();
      Get.put(SalesViewScreenController()).hitGetSalesApiCall();
      update();  // update to the method after data entered
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }
}