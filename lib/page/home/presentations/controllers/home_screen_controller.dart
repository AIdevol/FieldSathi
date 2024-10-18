import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:tms_sathi/utilities/custom_dialogue.dart';

import '../../../../response_models/amc_response_model.dart';
import '../../../../response_models/fsr_response_model.dart';
import '../../../../response_models/lead_response_model.dart';
import '../../../../response_models/services_response_model.dart';
import '../../../../response_models/ticket_response_model.dart';

class HomeScreenController extends GetxController{
  final RxString profileImageUrl = ''.obs;
  final RxBool isLoading = true.obs;
  List<FsrResponseModel> allFsr = <FsrResponseModel>[].obs;
  RxList<LeadGetResponseModel> leadListData = <LeadGetResponseModel>[].obs;
  RxList<AmcResponseModel> amcData = <AmcResponseModel>[].obs;
  RxList<TicketResponseModel> ticketData = <TicketResponseModel>[].obs;
  final RxList<ServiceCategoriesResponseModel> allServices = <ServiceCategoriesResponseModel>[].obs;
  final RxList<ServiceCategoriesResponseModel> filteredServices = <ServiceCategoriesResponseModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    hitGetuserDetailsApiCall();
    hitGetfsrDetailsApiCall();
    fetchedLeadListApiCall();
    hitGetAmcDetailsApiCall();
    hitServiceCategoriesApiCall();
  }

  @override
  void onClose(){
    super.onClose();
  }

  void onReady(){
    super.onReady();
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomDialogue(
          onOkTap: () {
            Get.back();
          },
          title: 'Welcome',
          desc: 'Welcome to your universe',
        );
      },
    );
  }

  void hitGetuserDetailsApiCall(){
    isLoading.value = true;
    final userid = storage.read(userId);
    print("userId++++: $userid");
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;

    Get.find<AuthenticationApiService>().userDetailsApiCall(id: userid).then((value){
      var userData = value;
      customLoader.hide();
      profileImageUrl.value = userData.profileImage ?? '';
      toast('Details successfully fetched');
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitGetfsrDetailsApiCall()async{
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getfsrDetailsApiCall().then((value)async{
      allFsr.assignAll(value);
      customLoader.hide();

      if (allFsr is FsrResponseModel){
        var fsrid = allFsr.first.id.toString();
        print('aldjfklasf= ${fsrid}');
        await storage.write(FsrId, fsrid);
      }
      // toast('FSR Fetched Successfully');
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }
  void fetchedLeadListApiCall(){
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getLeadListApiCall().then((value){
      leadListData.assignAll(value);
      customLoader.hide();
      // toast("Lead list fetched successfully");
      update();
    }).onError((error,stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitGetAmcDetailsApiCall(){
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    // try{
    //   final amcValues=Get.find<AuthenticationApiService>().getAmcDetailsApiCall();
    //   amcData.assignAll(amcValues);
    //   toast("Amc Fetched successfully");
    //   customLoader.hide();
    // }catch(error){
    //   toast(error.toString());
    // }finally {
    //   customLoader.hide();
    //   isLoading.value = false;
    // }
    Get.find<AuthenticationApiService>().getAmcDetailsApiCall().then((value){
      amcData.assignAll(value);
      // List<String>amcIds=amcData.
      customLoader.hide();
      // toast("AMC successfully Fetched");
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void fetchTicketsApiCall() async {
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      final tickets = await Get.find<AuthenticationApiService>().getticketDetailsApiCall();
      ticketData.assignAll(tickets);
      // applyFilters();
    } catch (error) {
      toast(error.toString());
    } finally {
      customLoader.hide();
      isLoading.value = false;
    }
  }

  Future<void> hitServiceCategoriesApiCall() async {
    try {
      isLoading.value = true;
      // customLoader.show();
      FocusManager.instance.primaryFocus?.unfocus();

      final value = await Get.find<AuthenticationApiService>().getServiceCategoriesApiCall();
      allServices.assignAll(value);
      filteredServices.assignAll(value);

      final serviceCatIds = allServices.map((services) => services.id.toString()).toList();
      await storage.write(serviceCategoriesId, serviceCatIds);

      customLoader.hide();
      update();
    } catch (error) {
      customLoader.hide();
      toast(error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}