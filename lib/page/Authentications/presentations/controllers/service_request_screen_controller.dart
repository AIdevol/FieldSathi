import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/expenses_response_model.dart';
import 'package:tms_sathi/response_models/export_import_directory/expense_export_response_model.dart';
import 'package:tms_sathi/response_models/service_requests_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class ServiceRequestScreenController extends GetxController {
  RxList<String> selecteValue = [
    "--Please Select Status--"
        "Submitted",
    "Approved",
    "Dispatched"
  ].obs;
  RxString dropDownValue = "--Please Select Status--".obs;

  final isSearching = false.obs;
  final searchController = TextEditingController();
  final RxString searchText = ''.obs;
  final RxList<ServiceRequest> servicesRequestsData = <
      ServiceRequest>[].obs;
  final RxList<ServiceRequestsResponseModel> filteredRequests = <
      ServiceRequestsResponseModel>[].obs;
  final RxBool isLoading = true.obs;
  RxList<ExportServiceResponse> exportData = <ExportServiceResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    hitGetServiceRequestsResponseAPiCall();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchText.value = '';
      searchController.clear();
      // filteredRequests.assignAll(serviceRequests);
    }
  }

  void updateSearch(String value) {
    searchText.value = value;
    // _filterRequests();
  }

  void updateStatus(String status) {
    // Implement the logic to filter based on the status
    // _filterRequests();
  }

  void _onSearchChanged() {
    updateSearch(searchController.text);
  }

  // void _filterRequests() {
  //   final query = searchText.value.toLowerCase();
  //   filteredRequests.assignAll(serviceRequests.where((request) {
  //     final matchesSearch = request.ticketId.toLowerCase().contains(query) ||
  //         request.customerName.toLowerCase().contains(query);
  //     return matchesSearch;
  //   }).toList());
  //

  void deleteRequest(ServiceRequestsResponseModel request) {
    // Implement the delete logic here
  }

  void editRequest(ServiceRequestsResponseModel request) {
    // Implement the edit logic here
  }

  void downloadData() {
    // Implement download logic here
  }

  void hitGetServiceRequestsResponseAPiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getServiceRequestsApiCall().then((
        value) async{
      filteredRequests.assignAll(value);
      servicesRequestsData.clear();
      for (var response in {value} ){
        servicesRequestsData.addAll(servicesRequestsData);
      }
      List<String> attendanceIds = filteredRequests.map((technician) => technician.serviceRequests.toString()).toList();
      await storage.write(serviceRequestsId, attendanceIds);
      customLoader.hide();
      toast('Service fetched Successfully');
      update();
    }).onError((error, stackError) {
      print('afahfahdfafkahjakhfajhfa===================');
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }


  void hitdownloadExpenseServiceExcelSheetApiCall() async {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getDownLoadExportServiceResponse().then((value)async{
      print('downloaded data: $value');
      if (await _requestStoragePermission()) {
          Directory? directory = await getExternalStorageDirectory();
          String filePath = "${directory?.path}/expense_data.xlsx";
          await _writeExternalMemoryStuff(filePath, value.data);
          toast('Download successful: $filePath');
        } else {
          toast("Not Downloading");
        }
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
    // try {
    //   final response = Get.find<AuthenticationApiService>()
    //       .getDownLoadExportServiceResponse();
    //   print("export data: ${response}");
    //   if (await _requestStoragePermission()) {
    //     Directory? directory = await getExternalStorageDirectory();
    //     String filePath = "${directory?.path}/expense_data.xlsx";
    //     await _writeExternalMemoryStuff(filePath, exportData.data);
    //     toast('Download successful: $filePath');
    //   } else {
    //     toast("Not Downloading");
    //   }
    //   update();
    // } catch (e) {
    //   toast(e.toString());
    // } finally {
    //   customLoader.hide();
    // }
  }

  _requestStoragePermission() async {
    if (await Permission.storage
        .request()
        .isGranted) {
      return true;
    } else {
      toast("Storage permission denied.");
      return false;
    }
  }

  _writeExternalMemoryStuff(String filePath, List<int>data) async {
    File file = File(filePath);
    await file.writeAsBytes(data);
  }

}



// import 'package:get/get.dart';
//
// class ServiceRequestScreenController extends GetxController {
//
//   RxList<String> selecteValue = [
//     "--Please Select Status--"
//     "Submitted",
//     "Approved",
//     "Dispatched"
//   ].obs;
//
//   // To store the currently selected value
//   RxString dropDownValue = "--Please Select Status--".obs;
//
//   RxList<ServiceRequest> serviceRequests = <ServiceRequest>[].obs;
//   var isSearching = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Add static data for testing
//     serviceRequests.addAll([
//       ServiceRequest(
//         sNo: 1,
//         ticketId: 'TKT12345',
//         customerName: 'John Doe',
//         subCustomerName: 'Jane Smith',
//         technicianName: 'Michael Brown',
//         address: '123 Main St, City',
//         materialsRequired: 'Cable, Router',
//         status: 'Pending',
//         courierCNO: 'CNO98765',
//         docktNo: 'DCK123',
//         hubAddress: 'Hub 1, Downtown',
//         dispatchedLocation: 'Location 1',
//         remark: 'Urgent',
//       ),
//       ServiceRequest(
//         sNo: 2,
//         ticketId: 'TKT67890',
//         customerName: 'Alice Wonderland',
//         subCustomerName: 'Bob Builder',
//         technicianName: 'Chris Red',
//         address: '456 High St, City',
//         materialsRequired: 'Modem',
//         status: 'Completed',
//         courierCNO: 'CNO12345',
//         docktNo: 'DCK678',
//         hubAddress: 'Hub 2, Uptown',
//         dispatchedLocation: 'Location 2',
//         remark: 'Normal Priority',
//       ),
//       // Add more static data as needed
//     ]);
//   }
//
//   void toggleSearch() {
//     isSearching.value = !isSearching.value;
//   }
//
//   void downloadData() {
//     // Implement download functionality
//   }
//
//   void updateSearch(String value) {
//     // Implement search functionality
//   }
//
//   void updateStatus(String value) {
//     // Implement status filter functionality
//   }
//
//   void editRequest(ServiceRequest request) {
//     // Implement edit functionality
//   }
//
//   void deleteRequest(ServiceRequest request) {
//     serviceRequests.remove(request); // Implement delete functionality
//   }
// }
// class ServiceRequest {
//   final int sNo;
//   final String ticketId;
//   final String customerName;
//   final String subCustomerName;
//   final String technicianName;
//   final String address;
//   final String materialsRequired;
//   final String status;
//   final String courierCNO;
//   final String docktNo;
//   final String hubAddress;
//   final String dispatchedLocation;
//   final String remark;
//
//   ServiceRequest({
//     required this.sNo,
//     required this.ticketId,
//     required this.customerName,
//     required this.subCustomerName,
//     required this.technicianName,
//     required this.address,
//     required this.materialsRequired,
//     required this.status,
//     required this.courierCNO,
//     required this.docktNo,
//     required this.hubAddress,
//     required this.dispatchedLocation,
//     required this.remark,
//   });
// }
