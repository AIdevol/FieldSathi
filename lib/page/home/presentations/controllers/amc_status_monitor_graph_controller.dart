import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../../main.dart';
import '../../../../response_models/amc_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class AmcStatusMonitorGraphController extends GetxController {
  RxBool isLoading = false.obs;
  final _touchedIndex = (-1).obs;
  int get touchedIndex => _touchedIndex.value;
  void setTouchedIndex(int index) => _touchedIndex.value = index;
  RxList<AmcResult> amcResultData = <AmcResult>[].obs;

  RxInt upcomingCount = 0.obs;
  RxInt renewalCount = 0.obs;
  RxInt completedCount = 0.obs;
  RxInt expiredCount = 0.obs;
  RxInt totalCount = 0.obs;


  @override
  void onInit() {
    super.onInit();
    hitGetAmcDetailsApiCall();
    hitAmcCountApiCall();
  }

  void hitGetAmcDetailsApiCall(){
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getAmcDetailsApiCall().then((value){
      amcResultData.assignAll(value.results!);
      List<String>amcIds=amcResultData.map((amcValue)=>amcValue.id.toString()).toList();
      customLoader.hide();
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitAmcCountApiCall(){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().getAmcCountsApiCall().then((value){
      totalCount.value = value.total!;
      upcomingCount.value = value.upcoming!;
      renewalCount.value = value.renewal!;
      completedCount.value = value.completed!;
      expiredCount.value = value.expired!;
      toast("Amc Counts fetched successfully");
      print("total : ${totalCount.value}");
      print("upcomingCount : ${upcomingCount.value}");
      update();
    }).onError((error,stackError){
      toast(error.toString());
      customLoader.hide();
      isLoading.value = false;
    });
  }


}