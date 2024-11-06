// LeaveUpdateScreenController.dart
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

  RxList<LeaveAllocationResult> leavesAllocationsResult = <LeaveAllocationResult>[].obs;
  RxBool isLoading = false.obs;

  // Track actual numeric values
  RxInt sickLeaveCount = 0.obs;
  RxInt casualLeaveCount = 0.obs;
  RxInt probationPeriod = 0.obs;

  @override
  void onInit() {
    super.onInit();
    sickLeaveController = TextEditingController();
    casualLeaveController = TextEditingController();
    probationPeriodController = TextEditingController();

    sickLeaveFocusNode = FocusNode();
    casualLeaveFocusNode = FocusNode();
    probationLeaveFocusNode = FocusNode();

    // Initialize with default values
    _updateControllerTexts();
    hitGetAssignedLeavesApiCall();
  }

  @override
  void onClose() {
    sickLeaveController.dispose();
    casualLeaveController.dispose();
    probationPeriodController.dispose();

    sickLeaveFocusNode.dispose();
    casualLeaveFocusNode.dispose();
    probationLeaveFocusNode.dispose();
    super.onClose();
  }

  void _updateControllerTexts() {
    sickLeaveController.text = sickLeaveCount.value.toString();
    casualLeaveController.text = casualLeaveCount.value.toString();
    probationPeriodController.text = probationPeriod.value.toString();
  }

  void increaseProbationPeriod() {
    probationPeriod++;
    probationPeriodController.text = probationPeriod.value.toString();
    update();
  }

  void decreaseProbationPeriod() {
    if (probationPeriod.value > 0) {
      probationPeriod--;
      probationPeriodController.text = probationPeriod.value.toString();
      update();
    }
  }

  void increaseCasualLeaves() {
    casualLeaveCount++;
    casualLeaveController.text = casualLeaveCount.value.toString();
    update();
  }

  void decreaseCasualLeaves() {
    if (casualLeaveCount.value > 0) {
      casualLeaveCount--;
      casualLeaveController.text = casualLeaveCount.value.toString();
      update();
    }
  }

  void increaseSickLeaves() {
    sickLeaveCount++;
    sickLeaveController.text = sickLeaveCount.value.toString();
    update();
  }

  void decreaseSickLeaves() {
    if (sickLeaveCount.value > 0) {
      sickLeaveCount--;
      sickLeaveController.text = sickLeaveCount.value.toString();
      update();
    }
  }

  void hitGetAssignedLeavesApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();

    Get.find<AuthenticationApiService>().getLeavesALLocationApiCall().then((value) async {
      leavesAllocationsResult.assignAll(value.results);

      List<String> leaveAllocationids = leavesAllocationsResult
          .map((leavesData) => leavesData.id.toString())
          .toList();
      await storage.write(leavesAllocationId, leaveAllocationids);
      print("ajdfjadsfj: ${storage.read(leavesAllocationId)}");
      if (leavesAllocationsResult.isNotEmpty) {
        LeaveAllocationResult result = leavesAllocationsResult.first;
        // Update Rx values
        sickLeaveCount.value = result.allocatedSickLeave;
        casualLeaveCount.value = result.allocatedCasualLeave;
        probationPeriod.value = result.months;
        // Update controller texts
        _updateControllerTexts();
      }

      customLoader.hide();
      toast("Leaves Period Located successfully");
      update();
    }).onError((error, stackTrace) {
      isLoading.value = false;
      customLoader.hide();
      toast(error.toString());
    });
  }

  void hitPutAssignedLeavesApiCall() async {
    final allocationIds = await storage.read(leavesAllocationId);
    final allocationId = allocationIds is List ? allocationIds.first : allocationIds;
    print('allocationid ${allocationId}');
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();

    var leavesData = {
      'months': probationPeriod.value.toString(),
      'allocated_sick_leave': sickLeaveCount.value.toString(),
      'allocated_casual_leave': casualLeaveCount.value.toString()
    };

    Get.find<AuthenticationApiService>()
        .putLeavesAllocationApiCall(dataBody: leavesData, id: allocationId)
        .then((value) {
      hitGetAssignedLeavesApiCall();
      customLoader.hide();
      toast('Updated leaves allocation successfully');
      update();
    }).onError((error, stackTrace) {
      isLoading.value = false;
      customLoader.hide();
      toast(error.toString());
    });
  }
}