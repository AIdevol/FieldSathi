import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/profile_screen_controller.dart';

import '../../../../services/APIs/auth_services/auth_api_services.dart';
import '../../../../services/login_service.dart';

class AccountViewScreenController extends GetxController{
  late TextEditingController branchController;
  late TextEditingController ifscController;
  late TextEditingController accountController;
  late TextEditingController UPIController;
  late TextEditingController paymentController;
  late TextEditingController branchAdressController;

  late FocusNode brancfocusenode;
  late FocusNode ifscfocusnode;
  late FocusNode accountfocusnode;
  late FocusNode Upifocusnode;
  late FocusNode paymentfocusnode;
  late FocusNode branchAddressFocusNode;


  @override
  void onInit(){
    branchController = TextEditingController();
    ifscController = TextEditingController();
    accountController = TextEditingController();
    UPIController = TextEditingController();
    paymentController = TextEditingController();
    branchAdressController = TextEditingController();

    brancfocusenode = FocusNode();
    ifscfocusnode = FocusNode();
    accountfocusnode = FocusNode();
    Upifocusnode = FocusNode();
    paymentfocusnode = FocusNode();
    branchAddressFocusNode = FocusNode();

    hitAccountApiCall();
    super.onInit();
  }

  @override
  void onClose(){
    branchController.dispose();
    ifscController.dispose();
    accountController.dispose();
    UPIController.dispose();
    paymentController.dispose();
    branchAdressController.dispose();

    brancfocusenode.dispose();
    ifscfocusnode.dispose();
    accountfocusnode.dispose();
    Upifocusnode.dispose();
    paymentfocusnode.dispose();
    branchAddressFocusNode.dispose();
    super.onClose();
  }

//   ===============================================Account Api call===================================================================

  void refreshNewUpdatedData(){

    cleanControllers();
    hitAccountApiCall();
    update();
  }

  void cleanControllers(){
    branchController.clear();
    paymentController.clear();
    ifscController.clear();
    accountController.clear();
    UPIController.clear();
    branchAdressController.clear();
  }

 hitAccountApiCall(){
    final id = storage.read(userId);
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    Get.find<AuthenticationApiService>().userDetailsApiCall(id:id).then((value){
      var accountData = value;
      branchController.text = accountData.bankName??'';
      ifscController.text = accountData.ifscSwift??'';
      accountController.text = accountData.accountNumber??'';
      UPIController.text = accountData.upiId?? '';
      paymentController.text = accountData.paymentLink??'';
      branchAdressController.text = accountData.branchAddress ??'';
      toast("Account details successfully fetched");
      customLoader.hide();
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
}


 hitUpdateAccountApiCall(){
Get.put(GetLoginModalService());
   final id = storage.read(userId);
   customLoader.show();
   FocusManager.instance.primaryFocus?.unfocus();
   var accountBody = {
     "bankName":branchController.text,
     "ifscSwift":ifscController.text,
     "accountNumber":accountController.text,
     "branchAddress": branchController.text,
     "upiId": UPIController.text,
     "paymentLink":paymentController.text
   };
   Get.find<AuthenticationApiService>().updateUserDetailsApiCall(id:id, dataBody:accountBody).then((value){
     var accountData = value;
     Get.find<GetLoginModalService>().getUserDataModal(UserDataModel: accountData);
     refreshNewUpdatedData();
     toast("Account Updated Successfully");
     customLoader.hide();
     update();
   }).onError((error, stackError){
     customLoader.hide();
     toast(error.toString());
   });
 }
}