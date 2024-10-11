import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/customer_list_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/const_local_keys.dart';

class CustomerListViewController extends GetxController{
    RxBool isLoading = false.obs;
    RxList<CustomerData> customerListData = <CustomerData>[].obs;
    @override
    void onInit(){
      super.onInit();
      hitGetCustomerListApiCall();
    }

    @override
    void onClose(){
      super.onClose();
    }

  void hitGetCustomerListApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var parameterdata = {
      "role":"customer",
    };
    Get.find<AuthenticationApiService>().getCustomerListApiCall(parameters: parameterdata).then((value)async{
    customerListData.assignAll(value.results);
    List<String> customerIds = customerListData.map((agent) => agent.id.toString()).toList();
    await storage.write(customerId, customerIds.join(','));
    print('customer id : ${await storage.read(customerId)}');
    customLoader.hide();
    toast('Customer List Successfully Fetched');
    update();
 }).onError((error , stackError){
        customLoader.hide();
        toast(error.toString());
        isLoading.value = false;
    });
  }
}