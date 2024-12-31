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
      final statusController = TextEditingController();
      final searchController = TextEditingController();
      final courierContactNumberController = TextEditingController();
      final docktNoController = TextEditingController();
      final hubAddressController = TextEditingController();
      final whereToDispatchedController = TextEditingController();
      final remarkController = TextEditingController();
      final approvedController = TextEditingController();

      RxList<String> selecteValue = [
        "--Select Status--",
        "Submitted",
        "Approved",
        "Dispatched"
      ].obs;

      RxList<String> statusOptions = [
        "--Select Status--",
        "Submitted",
        "Approved",
        "Dispatched"
      ].obs;

      RxString selectStatusValue = " ".obs;
      RxString dropDownValue = "--Select Status--".obs;

      final isSearching = false.obs;
      final RxString searchText = ''.obs;
      final RxList<ServiceRequest> servicesRequestsData = <ServiceRequest>[].obs;
      final RxList<ServiceRequest> servicesPaginationsData = <ServiceRequest>[].obs;
      final RxSet<ServiceRequestResponseModel> ServiceRequestsDetails = <ServiceRequestResponseModel>{}.obs;
      final RxBool isLoading = true.obs;
      RxList<ExportServiceResponse> exportData = <ExportServiceResponse>[].obs;
      final RxList<ServiceRequest> filteredRequests = <ServiceRequest>[].obs;

      final approvalRemarkController = TextEditingController();
      RxInt currentPage = 1.obs;
      RxInt totalPages = 0.obs;
      final int itemsPerPage = 10;

      @override
      void onInit() {
        super.onInit();
        hitGetServiceRequestsResponseAPiCall();
        // searchController.addListener(_onSearchChanged);
        filteredRequests.assignAll(servicesRequestsData);
      }

      @override
      void onClose() {
        searchController.dispose();
        statusController.dispose();
        courierContactNumberController.dispose();
        docktNoController.dispose();
        hubAddressController.dispose();
        whereToDispatchedController.dispose();
        remarkController.dispose();
        approvedController.dispose();
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
      void calculateTotalPages() {
        totalPages.value = (filteredRequests.length / itemsPerPage).ceil();
        if (currentPage.value > totalPages.value) {
          currentPage.value = totalPages.value;
        }
        if (currentPage.value < 1) {
          currentPage.value = 1;
        }
      }
      void updatePaginatedTechnicians() {
        List<ServiceRequest> sourceList = filteredRequests.isEmpty
            ? servicesRequestsData
            : filteredRequests;
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
        servicesPaginationsData.value = sourceList.sublist(
            startIndex,
            endIndex
        );

        update();
      }
      void _applyFilters() {
        List<ServiceRequest> results = servicesRequestsData;

        if (searchText.value.isNotEmpty) {
          final query = searchText.value.toLowerCase();
          results = results.where((request) {
            final matchesTaskName = request.ticket!.taskName?.toLowerCase().contains(query) ?? false;
            final matchesCustomerName = request.ticket!.custName?.toLowerCase().contains(query) ?? false;
            final matchesTechnicianName = request.ticket!.technicianName?.toLowerCase().contains(query) ?? false;

            return matchesTaskName || matchesCustomerName || matchesTechnicianName;
          }).toList();
        }

        // Apply status filter if a status is selected
        if (dropDownValue.value != "--Please Select Status--") {
          results = results.where((request) =>
          request.status?.toLowerCase() == dropDownValue.value.toLowerCase()
          ).toList();
        }

        // Update the filtered results
        filteredRequests.assignAll(results);
        update();
      }


      void updateStatus(String status) {
        // Implement the logic to filter based on the status
        // _filterRequests();
      }

      void updateSearch(String value) {
        searchText.value = value;
        _applyFilters();
      }


      void hitGetServiceRequestsResponseAPiCall() {
        isLoading.value = true;
        customLoader.show();
        FocusManager.instance.primaryFocus!.context;
        var parameterAllServicesRequets={
          "page_size":"all"
        };
        Get.find<AuthenticationApiService>().getServiceRequestsApiCall(parameters:parameterAllServicesRequets ).then((value) async{
          ServiceRequestsDetails.add(value);
          servicesRequestsData.assignAll(value.results);
          filteredRequests.assignAll(value.results);
          servicesPaginationsData.assignAll(value.results);
          List<String> serviceRequetsIds = servicesRequestsData.map((technician) => technician.id.toString()).toList();
          List<String> statusValue = servicesRequestsData.map((technician) => technician.status.toString()).toList();
          await storage.write(serviceRequestsId, serviceRequetsIds);
          statusController.text = statusValue.join(',');
          print("ajfaf: ${statusController.text}");
          calculateTotalPages();
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
      Map<String, int> getStatusCounts() {
        Map<String, int> counts = {};
        for (var request in servicesRequestsData) {
          counts[request.status.toString()] = (counts[request.status] ?? 0) + 1;
        }
        return counts;
      }

      void hitUpdateStatusApiCall(String? status){
        isLoading.value = true;
        customLoader.show();
        FocusManager.instance.primaryFocus!.unfocus();
        // Get.find<AuthenticationApiService>().
      }

     Future<void>hitRefreshservicesApiCall()async{
       hitGetServiceRequestsResponseAPiCall();
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
