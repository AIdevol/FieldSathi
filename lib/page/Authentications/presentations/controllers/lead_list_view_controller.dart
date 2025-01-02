import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/lead_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../response_models/interaction_leads_response_model.dart';
import '../../../../response_models/leaves_history_response_model.dart';

class LeadListViewController extends GetxController{
  RxList<String> leadStatusValue = [
    "---Select Status---",
    "Inactive",
    "Interact",
    "In-Discussion",
    "Quote Sent",
    "Service Taken",
    "Not Interested",
  ].obs;

  RxList<String> leadDateWiseValue = [
    "---Select Date---",
    "Today",
    "Tomorrow",
    "Yesterday",
    "This Week",
    "This Month",
  ].obs;
  RxString dropdownValue = "---Select Status---".obs;
  RxString dropdownDateValue = "---Select Date---".obs;
  RxBool isLoading = true.obs;
  RxList<LeadResult> leadListData = <LeadResult>[].obs;
  RxList<LeadResult> leadFilters = <LeadResult>[].obs;
  RxList<LeadResult> leadPaginationsData = <LeadResult>[].obs;
  RxList<LeadHistoryResponseModel>leadHistoryData = <LeadHistoryResponseModel>[].obs;
  RxList<InteractionLeadsResponseModel>interactinData = <InteractionLeadsResponseModel>[].obs;
  late TextEditingController searchController;

  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  final int itemsPerPage = 10;
  RxString InActiveValue = "".obs ;
  RxString IntractValue = "".obs ;
  RxString IndiscussionValue = "".obs ;
  RxString QuoteSentValue = "".obs ;
  RxString ServiceTakenValue = "".obs ;
  RxString NoInterestedValue = "".obs ;
  final TextEditingController companyController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController additionalNotesController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
@override
  void onInit(){
  searchController = TextEditingController();
  super.onInit();
  searchController.addListener(applyFilter);
  fetchedLeadListApiCall();
}
  void updateSelectedStatusFilter(String? newValue) {
    if (newValue != null) {
      dropdownValue.value = newValue;
      applyFilter();
    }
  }

  void updateSelectedDateFilter(String? newValue) {
    if (newValue != null) {
      dropdownDateValue.value = newValue;
      applyFilter();
    }
  }
  void applyFilter() {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      // If the search field is empty, reset the filter
      leadFilters.assignAll(leadListData);
    } else {
      // Apply filter logic
      leadFilters.assignAll(leadListData.where((lead) {
        return lead.firstName!.toLowerCase().contains(query) ||
            lead.lastName!.toLowerCase().contains(query) ||
            lead.companyName!.toLowerCase().contains(query) ||
            lead.mobile!.contains(query);
      }).toList());
    }

    // Update pagination based on the filtered results
    currentPage.value = 1;
    updatePaginatedTechnicians();
  }


@override
  void onClose(){
  companyController.dispose();
  firstNameController.dispose();
  lastNameController.dispose();
  emailController.dispose();
  phoneController.dispose();
  addressController.dispose();
  countryController.dispose();
  stateController.dispose();
  cityController.dispose();
  additionalNotesController.dispose();
  sourceController.dispose();
  super.onClose();
}
  void calculateTotalPages() {
    totalPages.value = (leadFilters.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }
  }

  void updatePaginatedTechnicians() {
    List<LeadResult> sourceList = leadFilters.isEmpty
        ? leadListData
        : leadFilters;
    totalPages.value = (sourceList.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }

    int startIndex = (currentPage.value - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    endIndex = endIndex > sourceList.length ? sourceList.length : endIndex;
    leadPaginationsData.value = sourceList.sublist(
        startIndex,
        endIndex
    );

    update();
  }


  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      updatePaginatedTechnicians();
      print("next page tapped value: ${currentPage.value}");
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      updatePaginatedTechnicians();
      print("previous page tapped value: ${currentPage.value}");

    }
  }

  void goToFirstPage() {
    currentPage.value = 1;
    updatePaginatedTechnicians();
  }

  void goToLastPage() {
    currentPage.value = totalPages.value;
    updatePaginatedTechnicians();
  }

  void fetchedLeadListApiCall(){
  isLoading.value = true;
  customLoader.show();
  FocusManager.instance.primaryFocus!.context;
  var leadDatalist = {
    "page":currentPage.value,
    "page_size":"all"
  };
    Get.find<AuthenticationApiService>().getLeadListApiCall(parameters: leadDatalist).then((value){
      leadListData.assignAll(value.results);
      leadFilters.assignAll(value.results);
      leadPaginationsData.assignAll(value.results);
      calculateTotalPages();
      fetchLeadStatusListApiCall();
      customLoader.hide();
      toast("Lead list fetched successfully");
      update();
    }).onError((error,stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }


void fetchLeadStatusListApiCall(){
  isLoading.value = true;
  FocusManager.instance.primaryFocus!.unfocus();
  Get.find<AuthenticationApiService>().getLeadStatusApiCall().then((value){
    InActiveValue.value = value.inactive.toString();
    IntractValue.value = value.interact.toString();
    IndiscussionValue.value = value.inDiscussion.toString();
    QuoteSentValue.value = value.quoteSent.toString();
    ServiceTakenValue.value = value.serviceTaken.toString();
    NoInterestedValue.value = value.notInterested.toString();
    toast("Lead Status fetch succesffuly");
    customLoader.hide();
    update();
  }).onError((error, stackError){
    customLoader.hide();
    toast(error.toString());
    isLoading.value = false;
  });
  }

  void hitLeadPutMethodApiCall(String id){
  isLoading.value = true;
  customLoader.show();
  FocusManager.instance.primaryFocus!.unfocus();
  var primaryLeadData = {
    "companyName":companyController.text.trim()??"",
    "firstName":firstNameController.text.trim()??"",
    "lastName":lastNameController.text.trim()??"",
    "email":emailController.text.trim()??"",
    "mobile":phoneController.text.trim()??"",
    "address":addressController.text.trim()??"",
    "country":countryController.text.trim()??"",
    "state":stateController.text.trim()??"",
    "city":cityController.text.trim()??'',
    "notes":addressController.text ?? "",
    "source":sourceController.text.trim()
  };
  Get.find<AuthenticationApiService>().putLeadListApiCall(dataBody: primaryLeadData,id: id).then((value){
    toast("Updated Lead Successfully");
    customLoader.hide();
    fetchedLeadListApiCall();
    Get.back();
    update();
  }).onError((error, stackError){
    toast(error.toString());
    customLoader.hide();
    isLoading.value = false;
  });
  }

  void hitDeleteLeadListApiCall(String id){
  isLoading.value = true;
  FocusManager.instance.primaryFocus!.unfocus();
  Get.find<AuthenticationApiService>().deleteLeadListApiCall(id: id).then((value){
    toast("deleted Lead List Successfully");
    fetchedLeadListApiCall();
    update();
  }).onError((error, stackError){
    toast(error.toString());
    isLoading.value = false;
    fetchedLeadListApiCall();
  });
  }

  Future<void> hitLeadHistoryViewApiCall({required String id})async {
  isLoading.value = true;
  // customLoader.show();
  FocusManager.instance.primaryFocus!.unfocus();
  Get.find<AuthenticationApiService>().getLeadHistoryApiCall(id: id).then((history){
    leadHistoryData.assignAll(history);
    customLoader.hide();
    update();
  }).onError((error,stackError){
    toast(error.toString());
    customLoader.hide();
  });
}

Future<void> hitgetInteractionApiCall({required String id})async{
  isLoading.value = true;
  // customLoader.show();
  FocusManager.instance.primaryFocus!.unfocus();
  var parameterData = {
    'lead_id':id
  };
  Get.find<AuthenticationApiService>().getLeadInteractionApiCall(parameters: parameterData).then((interation){
    interactinData.assignAll(interation);
    customLoader.hide();
    update();
  }).onError((error,stackError){
    toast(error.toString());
    customLoader.hide();
  });
}
}
