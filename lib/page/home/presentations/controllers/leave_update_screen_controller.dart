import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/leave_allocation_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/const_local_keys.dart';

class LeaveUpdateScreenController extends GetxController {
 late TextEditingController sickLeaveController;
 late TextEditingController casualLeaveController;
 late TextEditingController probationPeriodController;

 late FocusNode sickLeaveFocusNode;
 late FocusNode casualLeaveFocusNode;
 late FocusNode probationLeaveFocusNode;
 RxList<LeaveAllocationResponseModel> leavesAllocationData = <LeaveAllocationResponseModel>[].obs;
 RxBool  isLoading = false.obs;

  int _probationPeriod = 0;
  int _casualLeaveCount = 0;
  int _sickLeaveCount = 0;

  @override
  void onInit() {
    sickLeaveController = TextEditingController();
    casualLeaveController = TextEditingController();
    probationPeriodController = TextEditingController();

    sickLeaveFocusNode = FocusNode();
    casualLeaveFocusNode = FocusNode();
    probationLeaveFocusNode = FocusNode();
    super.onInit();
    sickLeaveController.text = _sickLeaveCount.toString();
    casualLeaveController.text = _casualLeaveCount.toString();
    probationPeriodController.text = _probationPeriod.toString();
    hitGetAssignedLeavesApiCall();
  }

void onClose(){
    sickLeaveController.dispose();
    casualLeaveController.dispose();
    probationPeriodController.dispose();

    sickLeaveFocusNode.dispose();
    casualLeaveFocusNode.dispose();
    probationLeaveFocusNode.dispose();
    super.onClose();
}
  void increaseProbationPeriod() {
      _probationPeriod++;
      probationPeriodController.text = _probationPeriod.toString();
      update();
  }

  void decreaseProbationPeriod() {
    if (_probationPeriod > 0) {
      _probationPeriod--;
      probationPeriodController.text = _probationPeriod.toString();
      update();
    }
  }

 void increaseCasualLeaves() {
   _casualLeaveCount++;
   casualLeaveController.text = _casualLeaveCount.toString();
   update();
 }

 void decreaseCasualLeaves() {
   if (_casualLeaveCount > 0) {
     _casualLeaveCount--;
     probationPeriodController.text = _casualLeaveCount.toString();
     update();
   }
 }

 void increaseSickLeaves() {
   _sickLeaveCount++;
   sickLeaveController.text = _sickLeaveCount.toString();
   update();
 }

 void decreaseSickLeaves() {
   if (_sickLeaveCount > 0) {
     _sickLeaveCount--;
     sickLeaveController.text = _sickLeaveCount.toString();
     update();
   }
 }


 void hitGetAssignedLeavesApiCall()async{
  //   isLoading.value = true;
  //   customLoader.show();
  //   FocusManager.instance.primaryFocus!.context;
  //   try{
  //     final responseData = await Get.find<AuthenticationApiService>().getLeavesALLocationApiCall();
  //     leavesAllocationData.assignAll(responseData);
  //    if (leavesAllocationData.isNotEmpty){
  //      LeaveAllocationResponseModel data = leavesAllocationData[0];
  //      sickLeaveController.text = data.allocatedSickLeave.toString();
  //      casualLeaveController.text = data.allocatedCasualLeave.toString();
  //      probationPeriodController.text = data.months.toString();
  //    }
  //   }
  //   catch(error){
  //       toast(error.toString());
  //   }finally{
  //     customLoader.hide();
  //     isLoading.value = false;
  //   }
  // }
     isLoading.value = true;
     customLoader.show();
     FocusManager.instance.primaryFocus!.context;
   Get.find<AuthenticationApiService>().getLeavesALLocationApiCall().then((value)async{
       leavesAllocationData.assignAll(value);

        if (leavesAllocationData.isNotEmpty){
          LeaveAllocationResponseModel data = leavesAllocationData[0];
          await storage.write(leavesAllocationId, data.id.toString());
          print('leavesid = ${data.id.toString()}');
          sickLeaveController.text = data.allocatedSickLeave.toString();
          casualLeaveController.text = data.allocatedCasualLeave.toString();
          probationPeriodController.text = data.months.toString();
        }
      customLoader.hide();
      toast("leaves Period Located succeffully");
      update();
    }).onError((error, stackError){
      isLoading.value = false;
      customLoader.hide();
      toast(error.toString());
    });
 }

 void hitPutAssignedLeavesApiCall()async{
    final allocationId= await storage.read(leavesAllocationId);
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var leavesData = {
      'months':probationPeriodController.text,
      'allocated_sick_leave':sickLeaveController.text,
      'allocated_casual_leave': casualLeaveController.text
    };
    Get.find<AuthenticationApiService>().putLeavesAllocationApiCall(dataBody:leavesData,id:allocationId).then((value){
      var leavesAllocationData = value;
      customLoader.hide();
      print(leavesAllocationData);
      hitGetAssignedLeavesApiCall();
      toast('update successfully leaves allocation');
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
 }
}