
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:tms_sathi/response_models/super_user_response_model.dart';

class AgentsViewScreenController extends GetxController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController searchController;

  late FocusNode firstNameFocusNode;
  late FocusNode lastNameFocusNode;
  late FocusNode emailFocusnode;
  late FocusNode phoneFocusNode;

  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  final int itemsPerPage = 10;
  RxBool isLoading = false.obs;
  RxList<Result> agentsData = <Result>[].obs;
  RxList<Result> filteredAgentsData = <Result>[].obs;
  RxList<Result> agentsPaginationsData = <Result>[].obs;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    searchController = TextEditingController();

    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    emailFocusnode = FocusNode();
    phoneFocusNode = FocusNode();

    searchController.addListener(filterAgents);
    super.onInit();
    hitGetAgentsDetailsApiCall();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
  void calculateTotalPages() {
    totalPages.value = (filteredAgentsData.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }
  }

  void filterAgents() {
    String searchTerm = searchController.text.toLowerCase().trim();

    if (searchTerm.isEmpty) {
      filteredAgentsData.assignAll(agentsData);
    } else {
      filteredAgentsData.value = agentsData.where((agent) {
        final fullName = '${agent.firstName ?? ''} ${agent.lastName ?? ''}'.toLowerCase();
        final email = (agent.email ?? '').toLowerCase();
        final phoneNumber = (agent.phoneNumber ?? '').toLowerCase();

        return fullName.contains(searchTerm) ||
            email.contains(searchTerm) ||
            phoneNumber.contains(searchTerm);
      }).toList();
    }

    currentPage.value = 1;
    calculateTotalPages();
    updatePaginatedTechnicians();
  }



  void updatePaginatedTechnicians() {
    List<Result> sourceList = filteredAgentsData.isEmpty
        ? agentsData
        : filteredAgentsData;
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
    agentsPaginationsData.value = sourceList.sublist(
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

  void hitGetAgentsDetailsApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var parameterdata = {
      "role": "agent",
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getAgentDetailsApiCall(
        parameters: parameterdata).then((value) async {
      agentsData.assignAll(value.results);
      filteredAgentsData.assignAll(value.results);
      agentsPaginationsData.assignAll(value.results);
      List<String> agentIds = agentsData.map((agent) => agent.id.toString()).toList();
      await storage.write(agentId, agentIds.join(','));
      customLoader.hide();
      calculateTotalPages();
      toast("Agents Fetched Successfully");
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitPutAgentsDetailsApiCall(String agentId) {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var agentDetails = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone_number": phoneController.text,
      "email": emailController.text,
    };
    // var parameterdata = {
    //   "role": "agent"
    // };

    Get.find<AuthenticationApiService>().putAgentDetailwsApiCall(
        dataBody: agentDetails, id: agentId).then((value) {
      var agentdetails = value;
      print('agent posted data = $agentdetails');
      customLoader.hide();
      toast('Agent Updated successfully');
      hitGetAgentsDetailsApiCall();
      Get.back();
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void hitUpdateStatusValue(String agentId) {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var updatedData = {
      "status": "inactive"  // You might want to toggle this based on current status
    };
    Get.find<AuthenticationApiService>().putAgentDetailwsApiCall(dataBody: updatedData, id: agentId).then((value) {
      customLoader.hide();
      toast("Status Updated");
      hitGetAgentsDetailsApiCall();  // Refresh the list after updating
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }

  void hitDeleteStatuApiValue(String agentId){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();

  }

  Future<void>hitRefreshApiData()async{
    hitGetAgentsDetailsApiCall();
  }
}