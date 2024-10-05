import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'package:intl/intl.dart';

class LeaveReportViewScreenController extends GetxController {
  final TextEditingController statusController = TextEditingController();
  RxList<String> filterTypes = [
    "Select Status",
    "Submitted",
    "Approved",
    "Rejected",
  ].obs;

  RxList<String> selectedStatus = [
    "Select Status",
    "Submitted",
    "Approved",
    "Rejected",
  ].obs;

  RxString defaultSelectedStatus = 'Select Status'.obs;
  RxString selectedFilter = "Select Status".obs;
  Rx<LeaveResponseModel> leaveManagementData = LeaveResponseModel().obs;
  RxList<Results> filteredLeaves = <Results>[].obs;
    RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;

  LeaveResponseModel resultsData = LeaveResponseModel();

  @override
  void onInit() {
    super.onInit();
    hitLeavesApiCall();
  }

  void hitLeavesApiCall() {
    customLoader.show();
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    Get.find<AuthenticationApiService>().getLeavesApiCall().then((value) {
       // resultsData.assignAll(leaveManagementData.value.results);
      if (value is LeaveResponseModel){
        leaveManagementData.value = value;
        if (leaveManagementData.value.results != null && leaveManagementData.value.results!.isNotEmpty) {
          leaveManagementData.value.results!.forEach((result) async {
            print('Leave ID: ${result.id}');
            await storage.write(leavesId, result.id??"");
          });
        } else {
          print('No leave results found');
        }

      } else {
        throw Exception('Unexpected response format: ${value.runtimeType}');
      }
      applyFilters();
      customLoader.hide();
      isLoading.value = false;
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitUpdateStatusPutAPiCall()async{
    final leaveId = await storage.read(leavesId);
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var statusValue={
      "status": statusController.text
    };
    Get.find<AuthenticationApiService>().putLeavesApiCall(dataBody: statusValue, id: leaveId).then((value){
       leaveManagementData.value = value;
       customLoader.hide();
       toast("Successfully updated Status ");
       hitLeavesApiCall();
       update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }


  void updateSelectedFilter(String? newValue) {
    if (newValue != null) {
      selectedFilter.value = newValue;
      applyFilters();
    }
  }

void updateSelectedStatus(String? newValue){
    if(newValue != null){
      defaultSelectedStatus.value = newValue;

    }
}
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void applyFilters() {
    if (leaveManagementData.value == null) return;

    filteredLeaves.value = leaveManagementData.value!.results!.where((leave) {
      final nameMatch = '${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase());
      final statusMatch = selectedFilter.value == "Select Status" || leave.status == selectedFilter.value;
      return nameMatch && statusMatch;
    }).toList();
  }

  void showLeaveDetails(Results leave) {
    Get.dialog(
      AlertDialog(
        title: Text('Leave Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'),
              Text('Phone: ${leave.userId?.phoneNumber ?? ''}'),
              Text('Role: ${leave.userId?.role ?? ''}'),
              Text('From Date: ${formatDate(DateTime.parse(leave.startDate ?? ''))}'),
              Text('To Date: ${formatDate(DateTime.parse(leave.endDate ?? ''))}'),
              Text('Days: ${calculateDays(DateTime.parse(leave.startDate ?? ''), DateTime.parse(leave.endDate ?? ''))}'),
              Text('Reason: ${leave.reason ?? ''}'),
              Text('Status: ${leave.status ?? ''}'),
              Text('Leave Type: ${leave.leaveType ?? ''}'),
              Text('Company: ${leave.userId?.companyName ?? ''}'),
              Text('Email: ${leave.userId?.email ?? ''}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  int calculateDays(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays + 1;
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:tms_sathi/constans/const_local_keys.dart';
// import 'package:tms_sathi/main.dart';
// import 'package:tms_sathi/response_models/leaves_response_model.dart';
// import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
// import 'package:intl/intl.dart';
//
// class LeaveReportViewScreenController extends GetxController {
//   final RxList<String> filterTypes = [
//     "Select Status",
//     "Submitted",
//     "Approved",
//     "Rejected",
//   ].obs;
//
//   final RxString selectedFilter = "Select Status".obs;
//   final Rx<LeaveResponseModel> leaveManagementData = LeaveResponseModel().obs;
//   final RxList<Results> filteredLeaves = <Results>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString searchQuery = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     hitLeavesApiCall();
//   }
//
//   Future<void> hitLeavesApiCall() async {
//     try {
//       isLoading.value = true;
//       FocusManager.instance.primaryFocus?.unfocus();
//       customLoader.show();
//
//       final response = await Get.find<AuthenticationApiService>().getLeavesApiCall();
//
//       if (response is LeaveResponseModel) {
//         leaveManagementData.value = response;
//       } else if (response is Map<String, dynamic>) {
//         // leaveManagementData.value = LeaveResponseModel.fromJson(response);
//       } else {
//         throw Exception('Unexpected response format: ${response.runtimeType}');
//       }
//
//       applyFilters();
//     } catch (error) {
//       toast(error.toString());
//     } finally {
//       customLoader.hide();
//       isLoading.value = false;
//       update();
//     }
//   }
//
//   void updateSelectedFilter(String? newValue) {
//     if (newValue != null) {
//       selectedFilter.value = newValue;
//       applyFilters();
//     }
//   }
//
//   void updateSearchQuery(String query) {
//     searchQuery.value = query;
//     applyFilters();
//   }
//
//   void applyFilters() {
//     if (leaveManagementData.value.results == null) return;
//
//     filteredLeaves.value = leaveManagementData.value.results!.where((leave) {
//       final nameMatch = '${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'
//           .toLowerCase()
//           .contains(searchQuery.value.toLowerCase());
//       final statusMatch = selectedFilter.value == "Select Status" || leave.status == selectedFilter.value;
//       return nameMatch && statusMatch;
//     }).toList();
//   }
//
//   void showLeaveDetails(Results leave) {
//     Get.dialog(
//       AlertDialog(
//         title: Text('Leave Details'),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Name: ${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'),
//               Text('Phone: ${leave.userId?.phoneNumber ?? ''}'),
//               Text('Role: ${leave.userId?.role ?? ''}'),
//               Text('From Date: ${formatDate(DateTime.parse(leave.startDate ?? ''))}'),
//               Text('To Date: ${formatDate(DateTime.parse(leave.endDate ?? ''))}'),
//               Text('Days: ${calculateDays(DateTime.parse(leave.startDate ?? ''), DateTime.parse(leave.endDate ?? ''))}'),
//               Text('Reason: ${leave.reason ?? ''}'),
//               Text('Status: ${leave.status ?? ''}'),
//               Text('Leave Type: ${leave.leaveType ?? ''}'),
//               Text('Company: ${leave.userId?.companyName ?? ''}'),
//               Text('Email: ${leave.userId?.email ?? ''}'),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             child: Text('Close'),
//             onPressed: () => Get.back(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String formatDate(DateTime date) {
//     return DateFormat('yyyy-MM-dd').format(date);
//   }
//
//   int calculateDays(DateTime startDate, DateTime endDate) {
//     return endDate.difference(startDate).inDays + 1;
//   }
//
//   // Helper method to refresh the data
//   void refreshData() {
//     hitLeavesApiCall();
//   }
//
//   // Helper method to get the color based on leave status
//   Color getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'approved':
//         return Colors.green;
//       case 'rejected':
//         return Colors.red;
//       case 'submitted':
//         return Colors.orange;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   void exportData() {
//     toast('Export functionality not implemented yet.');
//   }
// }