import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/fsr_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/const_local_keys.dart';

class FsrViewcontroller extends GetxController {
  final TextEditingController searchController = TextEditingController();
  late TextEditingController checkPointStatusCheckingController;
  late FocusNode checkPointStatusCheckingFocusNode;
  final RxString searchQuery = ''.obs;
  final RxList<FsrResponseModel> filteredTickets = <FsrResponseModel>[].obs;

  List<FsrResponseModel> allFsr = <FsrResponseModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkPointStatusCheckingController = TextEditingController();
    checkPointStatusCheckingFocusNode = FocusNode();
    filteredTickets.assignAll(allFsr);
    searchController.addListener(_onSearchChanged);
    hitGetfsrDetailsApiCall();
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    checkPointStatusCheckingController.dispose();
    checkPointStatusCheckingFocusNode.dispose();
    searchController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    updateSearch(searchController.text);
  }

  void updateSearch(String query) {
    searchQuery.value = query;
    _filterTickets();
  }

  void _filterTickets() {
    if (searchQuery.isEmpty) {
      filteredTickets.assignAll(allFsr);
    } else {
      filteredTickets.assignAll(allFsr.where((FsrData) =>
          FsrData.fsrName!.toLowerCase().contains(searchQuery.toLowerCase())));
    }
    update();
  }

  void makeChanges(String id) {
    // Implement the logic for making changes to a ticket
    print('Making changes to ticket with ID: $id');
    // You can navigate to a new screen or show a dialog for editing
    // For example:
    // Get.to(() => EditTicketScreen(ticketId: id));
  }
  void hitGetfsrDetailsApiCall()async{
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getfsrDetailsApiCall().then((value)async{
       allFsr.assignAll(value);
      customLoader.hide();

      if (allFsr is FsrResponseModel){
        var fsrid = allFsr.first.id.toString();
        print('aldjfklasf= ${fsrid}');
        await storage.write(FsrId, fsrid);
      }
      toast('FSR Fetched Successfully');
      update();
    }).onError((error, stackError){
        customLoader.hide();
        toast(error.toString());
    });
  }

  void hitPostCheckingStatusApiCall(){
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
      var checkPointData = {
        "status_name":checkPointStatusCheckingController.text
      };
      Get.find<AuthenticationApiService>().postcheckPointStatusDetailsApiCall(dataBody: checkPointData).then((value){
        customLoader.hide();
        toast('updated checking status');
        update();
      }).onError((error, stackError){
        customLoader.hide();
        toast(error.toString());
      });
  }


}
