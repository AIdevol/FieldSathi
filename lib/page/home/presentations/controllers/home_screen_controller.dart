import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/today_ticket_response_model.dart';
import 'package:tms_sathi/response_models/user_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:tms_sathi/utilities/custom_dialogue.dart';

import '../../../../constans/role_based_keys.dart';
import '../../../../response_models/amc_response_model.dart';
import '../../../../response_models/fsr_response_model.dart';
import '../../../../response_models/lead_response_model.dart';
import '../../../../response_models/services_response_model.dart';
import '../../../../response_models/ticket_response_model.dart';

class HomeScreenController extends GetxController{
  final RxString profileImageUrl = ''.obs;
  final RxBool isLoading = true.obs;
  List<FsrResponseModel> allFsr = <FsrResponseModel>[].obs;
  RxList<LeadResult> leadListData = <LeadResult>[].obs;
  RxList<AmcResult> amcResultData = <AmcResult>[].obs;
  RxList<TicketResponseModel> ticketData = <TicketResponseModel>[].obs;
  RxList<TicketResult>ticketResultData = <TicketResult>[].obs;
  final RxList<ServiceCategoryResponseModel> allServices = <ServiceCategoryResponseModel>[].obs;
  final RxList<ServiceCategoryResponseModel> filteredServices = <ServiceCategoryResponseModel>[].obs;
  RxList<TodaysTicket> todayResponseData = <TodaysTicket>[].obs;
  @override
  void onInit(){
    super.onInit();
    hitGetuserDetailsApiCall();
    hitGetfsrDetailsApiCall();
    fetchedLeadListApiCall();
    fetchTicketsApiCall();
    hitGetAmcDetailsApiCall();
    hitServiceCategoriesApiCall();
    hitTodayTicketDataApiCall();
    // checkFirstTimeUser();
  }

  @override
  void onClose(){
    super.onClose();
  }

  void checkFirstTimeUser()async{
    bool isFirstTime = storage.read(FIRST_TIME_KEY) ?? true;
    // super.onReady();
    if(isFirstTime != null ) {
      WidgetsBinding.instance.addPostFrameCallback((_){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
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
    });
     await storage.write(FIRST_TIME_KEY, false);
    }
  }
  // WidgetsBinding.instance.addPostFrameCallback

  void hitGetuserDetailsApiCall(){
    isLoading.value = true;
    final userid = storage.read(userId);
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().userDetailsApiCall(id: userid).then((value)async{
      var userData = value;
      customLoader.hide();
      profileImageUrl.value = userData.profileImage ?? '';
      await storage.write(userid, userData.id??'');
      await storage.write(userRole, userData.role??'');
      print("current user: ${await storage.read(userRole)}");
      toast('Details successfully fetched');
      update();
    }).onError((error, stackError){
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitGetfsrDetailsApiCall()async{
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getfsrDetailsApiCall().then((value)async{
      customLoader.hide();
      if (allFsr is FsrResponseModel) {
        update();
      }
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  
  void fetchedLeadListApiCall(){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getLeadListApiCall().then((value){
      leadListData.assignAll(value.results!);
      update();
    }).onError((error,stackError){
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitGetAmcDetailsApiCall(){
    isLoading.value = true;
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
      var amcData = value;
      amcResultData.assignAll(value.results!);
      List<String>amcIds=amcResultData.map((amcValue)=>amcValue.id.toString()).toList();
      print("kya bhai amc ka Id bhi dekh liye: $amcIds");
      update();
    }).onError((error, stackError){
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
      var ticketData=(tickets.results);
      final List ticket = ticketData.map((ticketData)=>ticketData..toString()).toList();
      final List ticketStatus = ticketData.map((ticketData)=>ticketData.status.toString()).toList();
      await storage.write(ticketId, ticket);
      print('hello bhai apka ticket data idhr hai: ${storage.read(ticketId)}');
      print('hello bhai apks ticket status idhr hai: $ticketStatus');
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

      // allServices.assignAll(value.results);
      // filteredServices.assignAll(value);

      final serviceCatIds = allServices.map((services) => services.results.toString()).toList();
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

void hitTodayTicketDataApiCall(){
  isLoading.value = true;
  FocusManager.instance.primaryFocus?.unfocus();
  Get.find<AuthenticationApiService>().getTodayTicketDetailsApiCall().then((value){
    todayResponseData.assignAll(value.todaysTickets);
    print("ticket today:${value.todaysTickets}");
    update();
  }).onError((error,stackError){
    customLoader.hide();
    toast(error.toString());
    isLoading.value = false;
  });

}

  Future<void> refereshAllTicket()async{
    customLoader.show();
    hitGetuserDetailsApiCall();
    hitGetfsrDetailsApiCall();
    fetchedLeadListApiCall();
    fetchTicketsApiCall();
    hitGetAmcDetailsApiCall();
    hitServiceCategoriesApiCall();
    customLoader.hide();
    // checkFirstTimeUser();
  }
  
}