
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/customerBrand_response_model.dart';
import 'package:tms_sathi/response_models/ticket_history_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import '../../../../response_models/export_ticket_models.dart';
import '../../../../response_models/ticket_response_model.dart';

class TicketListController extends GetxController {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
    Rx<DateTime?> startDate = Rx<DateTime?>(null);
    Rx<DateTime?> endDate = Rx<DateTime?>(null);
  // Filter options
  // RxList<String> filterTypes = [
  //   "Select By",
  //   "Customer Name",
  //   "Sub-Customer Name",
  //   "Technician Name",
  //   "Status",
  //   "Region"
  // ].obs;

  RxList<String> filterStatusValue = [
    "All Status",
    "InActive",
    "Accepted",
    "Rejected",
    "Ongoing",
    "Completed",
    "On-Hold"
  ].obs;
  RxList<String> filteredByValue = [
    "Filter By",
    "Ticket Id",
    "Task Name",
    "Customer Name",
    "Sub-Customer Name",
    "Technician Name",
    "Region"
  ].obs;
  RxString selectedFilter = "All Status".obs;
  RxString selectedFilterBy = "Filter By".obs;
  RxList<TicketResult> ticketResult = <TicketResult>[].obs;
  RxList<TicketResult> filteredtickets = <TicketResult>[].obs;
  RxList<TicketResult> ticketPaginationsData = <TicketResult>[].obs;

  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxInt currentPage = 1.obs;
  final int itemsPerPage = 10;
  final RxInt totalPages = 0.obs;
  final RxList<TicketResult> _allTickets = <TicketResult>[].obs;
  TextEditingController dateController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isAmcSelected = false;
  bool isRateSelected = false;
  RxList<TicketHistoryResponseModel> ticketHistoryData = <TicketHistoryResponseModel>[].obs;

  final  taskNameController = TextEditingController();
  final assignTo = TextEditingController();
  final rateController = TextEditingController();
  final purposeController = TextEditingController();
  final customerNameController = TextEditingController();
  final productNameController = TextEditingController();
  final modelNoController = TextEditingController();
  final fsrController = TextEditingController();
  final servicesDetailsController = TextEditingController();
  final instructionController = TextEditingController();

  void toggleAmc() {
    isAmcSelected = true;
    isRateSelected = false;
    update();
  }

  void toggleRate() {
    isAmcSelected = false;
    isRateSelected = true;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchTicketsApiCall();
    // hitGetCustomerBrandListApiCall(id:510.toString());
  }
@override
void onClose(){
  startDateController.dispose();
  endDateController.dispose();
  taskNameController.dispose();
  rateController.dispose();
  assignTo.dispose();
   purposeController.dispose();
   dateController.dispose();
   customerNameController.dispose();
   productNameController.dispose();
   modelNoController.dispose();
   fsrController.dispose();
   servicesDetailsController.dispose();
   instructionController.dispose();
    super.onClose();
}
  void applyFilters() {
    if (ticketResult.isEmpty) return;

    var filteredTickets = List<TicketResult>.from(_allTickets);

    // Status Filter
    if (selectedFilter.value != "Select By") {
      filteredTickets = filteredTickets.where((ticket) =>
      ticket.status?.toLowerCase() == selectedFilter.value.toLowerCase()
      ).toList();
    }

    // Search Query Filter
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.value.toLowerCase().trim();

      filteredTickets = filteredTickets.where((ticket) {
        // Comprehensive search across multiple fields
        return
          // Customer Name
          (ticket.customerDetails?.firstName?.toLowerCase().contains(query) ?? false) ||
              (ticket.customerDetails?.lastName?.toLowerCase().contains(query) ?? false) ||

              // Sub-Customer Name
              (ticket.subCustomerDetails?.firstName?.toLowerCase().contains(query) ?? false) ||
              (ticket.subCustomerDetails?.lastName?.toLowerCase().contains(query) ?? false) ||

              // Technician Name
              (ticket.assignTo?.firstName?.toLowerCase().contains(query) ?? false) ||
              (ticket.assignTo?.lastName?.toLowerCase().contains(query) ?? false) ||

              // Task Name
              (ticket.taskName?.toLowerCase().contains(query) ?? false) ||

              // Ticket ID
              (ticket.id.toString().toLowerCase().contains(query)) ||

              // Status
              (ticket.status?.toLowerCase().contains(query) ?? false) ||

              // Purpose
              (ticket.purpose?.toLowerCase().contains(query) ?? false) ||

              // Address
              (ticket.ticketAddress?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Update the ticket result with filtered data
    ticketResult.value = filteredTickets;
    calculateTotalPages();
    updatePaginatedTechnicians();
  }

  void updateSelectedStatusFilter(String? newValue) {
    if (newValue != null) {
      selectedFilter.value = newValue;
      applyFilters();
    }
  }
  void updateSelectedFilterByData(String? newValue) {
    if (newValue != null) {
      selectedFilterBy.value = newValue;
      applyFilters();
    }
  }

  void calculateTotalPages() {
    totalPages.value = (filteredtickets.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }
  }

  void updatePaginatedTechnicians() {
    List<TicketResult> sourceList = filteredtickets.isEmpty
        ? ticketResult
        : filteredtickets;
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
    ticketPaginationsData.value = sourceList.sublist(
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


  void fetchTicketsApiCall() async {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var ticketParameterData = {
      // 'page':currentPage.value,
      "page_size":"all"
    };
    try {
      final response = await Get.find<AuthenticationApiService>()
          .getticketDetailsApiCall(parameter: ticketParameterData);
      ticketResult.assignAll(response.results!);
      ticketPaginationsData.assignAll(response.results!);
      filteredtickets.assignAll(response.results!);
      applyFilters(); // Apply initial filters
          List<String> ticketids = ticketResult.map((ids) => ids.id.toString())
          .toList();
      await storage.write(ticketId, ticketids);
      calculateTotalPages();
    } catch (error) {
      toast('Error fetching ticket details: ${error.toString()}');
    } finally {
      customLoader.hide();
      isLoading.value = false;
    }
  }


  void hitUpdateTicketApiCall(String? id){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var updateTicketData= {
      "taskName":taskNameController.text,
      "date":dateController.text,
      "time":"12:15:00",
      "assignTo":25,
      "israte":"false",
      "isamc":"true",
      "rate":null,
      "model":modelNoController.text,
      "purpose":purposeController.text,
      "customerDetails":customerNameController.text,
      "fsrDetails":43,
      "serviceDetails":14,
      "instructions":"afadfadfadfadf",
      "subCustomerDetails":null
    };

    Get.find<AuthenticationApiService>().putTicketDetailsApiCall(id: id,dataBody: updateTicketData).then((value){
      toast("updated successfully");
      customLoader.hide();
      update();
    }).onError((error,stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }



  // bool _searchCustomerName(TicketResult ticket, String query) {
  //   return (ticket.customerDetails.firstName?.toLowerCase().contains(query) ?? false) ||
  //       (ticket.customerDetails.lastName?.toLowerCase().contains(query) ?? false);
  // }
  //
  // bool _searchSubCustomerName(TicketResult ticket, String query) {
  //   return (ticket.subCustomerDetails?.firstName?.toLowerCase().contains(query) ?? false) ||
  //       (ticket.subCustomerDetails?.lastName?.toLowerCase().contains(query) ?? false);
  // }
  //
  // bool _searchTechnicianName(TicketResult ticket, String query) {
  //   final techFirstName = ticket.assignTo.firstName?.toLowerCase() ?? '';
  //   final techLastName = ticket.assignTo.lastName?.toLowerCase() ?? '';
  //   return techFirstName.contains(query) || techLastName.contains(query);
  // }
  //
  // // bool _searchRegion(TicketResult ticket, String query) {
  // //   return (ticket.ticketAddress?.city?.toLowerCase().contains(query) ?? false) ||
  // //       (ticket.ticketAddress?.state?.toLowerCase().contains(query) ?? false) ||
  // //       (ticket.ticketAddress?.country?.toLowerCase().contains(query) ?? false);
  // // }
  //
  // bool _performGenericSearch(TicketResult ticket, String query) {
  //   return _searchCustomerName(ticket, query) ||
  //       _searchSubCustomerName(ticket, query) ||
  //       _searchTechnicianName(ticket, query) ||
  //       (ticket.status.toLowerCase().contains(query));
  //       // _searchRegion(ticket, query);
  // }

  void updateSelectedFilter(String? newValue) {
    if (newValue != null) {
      selectedFilter.value = newValue;
      applyFilters();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  String formatDateTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'N/A';
    // Add your date formatting logic here if needed
    return dateTime;
  }


  // String getFullName(TicketResult user) {
  //   final firstName = user.firstName ?? '';
  //   final lastName = user.lastName ?? '';
  //   return '$firstName $lastName'.trim();
  // }


  // String getFormattedAddress(TicketAddress address) {
  //   final components = [
  //     address.city,
  //     address.state,
  //     address.country,
  //     address.zipcode
  //   ].where((component) => component != null && component.isNotEmpty);
  //
  //   return components.isEmpty ? 'N/A' : components.join(', ');
  // }

  void handleEditTicket(TicketResult ticket) {
    // Implement edit functionality
    // Example: Get.toNamed(AppRoutes.editTicket, arguments: ticket);
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      dateController.text = DateFormat('dd-MMM-yyyy').format(picked);
    }
  }


  // Method to handle delete action
  Future<void> handleDeleteTicket(TicketResult ticket) async {
    try {
      final confirmed = await Get.dialog(
        CupertinoAlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this ticket?'),
          actions: [
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () => Get.back(result: false),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Delete'),
              onPressed: () => Get.back(result: true),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        // Implement delete API call
        // await deleteTicketAPI(ticket.id);
        ticketResult.remove(ticket);
        toast('Ticket deleted successfully');
      }
    } catch (error) {
      toast('Error deleting ticket: ${error.toString()}');
    }
  }

  void downloadTicketData(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var dateParameters = {
      "start_date": startDateController.text,
      "end_date": endDateController.text,
    };
    Get.find<AuthenticationApiService>().exportTicketDataByDate(parameter:dateParameters).then((value){
      customLoader.hide();
      toast("fetch successfully");
      update();
    }).onError((error,stackError){
      toast(error.toString());
      customLoader.hide();
      isLoading.value = false;
    });
  }

  Future<bool> requestPermissionHandler()async{
    if(Platform.isAndroid){
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) {
        return true;
      }
      if (storageStatus.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }

      return false;
    }
    return true;
  }

  void hitGetTicketHistoryApiCall(String id){
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().getTicketHistoryData(id: id).then((value){
      ticketHistoryData.addAll(value);
      // ticketResult.addAll(value)
      // if(value.isNotEmpty){
      //   ticketResult.addAll(ticketHistoryData.);
      // }
      toast("Ticket History Fetched Succesfully");
      customLoader.hide();
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }

  Future<void> hitRefreshAllTicketData()async{
    fetchTicketsApiCall();
  }

  void hitDeleteTicketApiCall(String id){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().deleteticketDetailsApiCall(id: id).then((value){
      toast(value.message.toString());
      customLoader.hide();
      fetchTicketsApiCall();
      update();
    }).onError((error,stackError){
      toast(error.toString());
      customLoader.hide();
    });
  }


}
  //   Future<void> exportToExcel() async {
  //   try {
  //     if (startDate.value == null || endDate.value == null) {
  //       toast('Please select both start and end dates');
  //       return;
  //     }
  //
  //     isLoading.value = true;
  //     customLoader.show();
  //
  //     // Request storage permission
  //     final hasPermission = await requestPermissionHandler();
  //     if (!hasPermission) {
  //       toast('Please grant storage permission to export Excel file');
  //       return;
  //     }
  //
  //     // Filter tickets based on date range
  //     final filteredTickets = ticketResult.where((ticket) {
  //       final ticketDate = DateTime.parse(ticket.date);
  //       return ticketDate.isAfter(startDate.value!) &&
  //           ticketDate.isBefore(endDate.value!.add(Duration(days: 1)));
  //     }).toList();
  //
  //     if (filteredTickets.isEmpty) {
  //       toast('No tickets found in the selected date range');
  //       return;
  //     }
  //
  //     // Create Excel file
  //     final excel = Excel.createExcel();
  //     final Sheet sheet = excel['Tickets'];
  //
  //     // Add headers
  //     for (var i = 0; i < excelColoumn.length; i++) {
  //       final cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
  //       cell.value = CellValue.fromString(excelColoumn[i]);
  //       cell.cellStyle = CellStyle(
  //         bold: true,
  //         horizontalAlign: HorizontalAlign.Center,
  //       );
  //     }
  //
  //     // Add data
  //     for (var i = 0; i < filteredTickets.length; i++) {
  //       final ticket = filteredTickets[i];
  //       final row = i + 1;
  //
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
  //         ..value = ticket.id;
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
  //         ..value = ticket.taskName;
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row))
  //         ..value = DateFormat('dd-MMM-yyyy').format(DateTime.parse(ticket.date));
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row))
  //         ..value = DateFormat('HH:mm').format(DateTime.parse(ticket.date));
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
  //         ..value = getFullName(ticket.assignTo);
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
  //         ..value = ticket.isRated ? 'Yes' : 'No';
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row))
  //         ..value = ticket.rate?.toString() ?? 'N/A';
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row))
  //         ..value = ticket.isAmc ? 'Yes' : 'No';
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row))
  //         ..value = ticket.customerDetails.customerName;
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row))
  //         ..value = ticket.fsrName;
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row))
  //         ..value = ticket.instructions;
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: row))
  //           .value = ticket.status;
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: row))
  //         ..value = formatDateTime(ticket.startDateTime);
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: row))
  //         ..value = formatDateTime(ticket.endDateTime);
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: row))
  //         ..value = ticket.purpose;
  //       sheet.cell(CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: row))
  //         ..value = (ticket.subCustomerDetails?.customerName ?? 'N/A');
  //     }
  //
  //     // Save file
  //     final directory = Directory('/storage/emulated/0/Download');
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //
  //     final fileName = 'tickets_${DateFormat('dd_MM_yyyy').format(startDate.value!)}_to_${DateFormat('dd_MM_yyyy').format(endDate.value!)}.xlsx';
  //     final file = File('${directory.path}/$fileName');
  //
  //     await file.writeAsBytes(excel.encode()!);
  //     toast('Excel file exported successfully to Downloads/$fileName');
  //
  //   } catch (error) {
  //     toast('Error exporting Excel file: ${error.toString()}');
  //   } finally {
  //     isLoading.value = false;
  //     customLoader.hide();
  //   }
  // }

  // void saveTicketsToExcel(List<ExcelTicket> tickets) async {
  //   var excel = Excel.createExcel(); // Create a new Excel sheet
  //   String sheetName = "Tickets";
  //   Sheet sheet = excel[sheetName];
  //
  //   // Add Header Row
  //   sheet.appendRow([
  //     "Ticket ID",
  //     "Task Name",
  //     "Date",
  //     "Time",
  //     "Assigned To",
  //     "Is Rated",
  //     "Rate",
  //     "Is AMC",
  //     "Customer Name",
  //     "FSR Name",
  //     "Instructions",
  //     "Status",
  //     "Start DateTime",
  //     "End DateTime",
  //     "Purpose",
  //     "Sub Customer Name",
  //   ]);
  //
  //   // Add Data Rows
  //   for (var ticket in tickets) {
  //     sheet.appendRow(ticket.toExcelRow());
  //   }
  //
  //   // Save to a file
  //   Directory? directory = await getExternalStorageDirectory();
  //   String path = directory?.path ?? "/storage/emulated/0/Download";
  //   File excelFile = File("$path/Tickets.xlsx");
  //   excelFile.createSync(recursive: true);
  //   excelFile.writeAsBytesSync(excel.encode()!);
  //
  //   print("Excel file saved to $path/Tickets.xlsx");
  // }

  // Future<void> downloadTicketData(String? ticketId) async {
  //   if (ticketId == null){
  //     toast('Invalid Ticket Id');
  //     return;
  //   }
  //   isLoading.value = true;
  //   customLoader.show();
  //   FocusManager.instance.primaryFocus!.context;
  //   final hasPermission = await requestPermissionHandler();
  //   if (!hasPermission) {
  //     isLoading.value = false;
  //     customLoader.hide();
  //     toast('Please grant storage permission from settings to download tickets');
  //     return;
  //   }
  //   Get.find<AuthenticationApiService>().downloadTicketDataByUsername(id: ticketId).then((value)async{
  //     Directory? directory;
  //     if (Platform.isAndroid) {
  //       directory = Directory('/storage/emulated/0/Download');
  //     } else {
  //       directory = await getApplicationDocumentsDirectory();
  //     }
  //
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     final fileName = 'ticket_${ticketId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
  //     final file = File('${directory.path}/$fileName');
  //     await file.writeAsBytes(value);
  //     customLoader.hide();
  //     toast("Ticket data downloaded to: ${file.path}");
  //     update();
  //   }).onError((error, stackError){
  //     isLoading.value = false;
  //     customLoader.hide();
  //     toast(error.toString());
  //   });
  // }




// Future<String> getFilePath(String filename) async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   return join(appDocPath, filename);
  // }

//   void downloadTicketData(String? ticketId) async {
//     if (ticketId == null) {
//       toast("Invalid ticket ID");
//       return;
//     }
//
//     try {
//       isLoading.value = true;
//       customLoader.show();
//
//       // Check and request permissions for Android
//       if (Platform.isAndroid) {
//         Map<Permission, PermissionStatus> statuses = await [
//           Permission.storage,
//           Permission.manageExternalStorage,
//         ].request();
//
//         if (statuses[Permission.storage] != PermissionStatus.granted ||
//             statuses[Permission.manageExternalStorage] !=
//                 PermissionStatus.granted) {
//           throw Exception(
//               "Storage permissions are required to download the ticket");
//         }
//       }
//       final pdfData = await Get.find<AuthenticationApiService>()
//           .downloadTicketDataByUsername(id: ticketId)
//           .catchError((error) {
//         throw Exception("Failed to download PDF: ${error.toString()}");
//       });
//
//       // Get the download directory path based on platform
//       String? downloadPath;
//       if (Platform.isAndroid) {
//         // Use Downloads directory for Android
//         downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
//           ExternalPath.DIRECTORY_DOWNLOADS,
//         );
//       } else {
//         final directory = await getApplicationDocumentsDirectory();
//         downloadPath = directory.path;
//       }
//
//       if (downloadPath == null) {
//         throw Exception("Could not access storage directory");
//       }
//
//       // Create a directory for your app's downloads if it doesn't exist
//       final appDir = Directory('$downloadPath/TMS_Tickets');
//       if (!await appDir.exists()) {
//         await appDir.create(recursive: true);
//       }
//
//       // Create file name with timestamp
//       final timestamp = DateTime
//           .now()
//           .millisecondsSinceEpoch;
//       final fileName = 'ticket_$ticketId\_$timestamp.pdf';
//       final filePath = '${appDir.path}/$fileName';
//
//       // Write the PDF data to a file with error handling
//       try {
//         final file = File(filePath);
//         await file.writeAsBytes(pdfData as List<int>);
//
//         customLoader.hide();
//         isLoading.value = false;
//         toast("Ticket downloaded to Downloads/TMS_Tickets/$fileName");
//         update();
//       } catch (e) {
//         throw Exception("Failed to save file: ${e.toString()}");
//       }
//     } catch (error) {
//       isLoading.value = false;
//       customLoader.hide();
//       toast("Download failed: ${error.toString()}");
//     }
//   }
// }


// import 'dart:io';
// import 'package:excel/excel.dart';
// import 'package:external_path/external_path.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:tms_sathi/constans/const_local_keys.dart';
// import 'package:tms_sathi/main.dart';
// import 'package:tms_sathi/response_models/ticket_history_response_model.dart';
// import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
// import '../../../../response_models/ticket_response_model.dart';
//
// class TicketListController extends GetxController {
//   // Excel Export Related
//   List<String> excelColoumn = [
//     "Ticket id",
//     "Task Name",
//     "Date",
//     "Time",
//     "Assign To",
//     "Is Rated",
//     "Rate",
//     "Is AMC",
//     "Customer Name",
//     "FSR Name",
//     "Instructions",
//     "Status",
//     "Start DateTime",
//     "End DateTime",
//     "Purpose",
//     "Sub-customer Name"
//   ];
//
//   // Date Range Related
//   Rx<DateTime?> startDate = Rx<DateTime?>(null);
//   Rx<DateTime?> endDate = Rx<DateTime?>(null);
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController endDateController = TextEditingController();
//
//   // Filter options
//   RxList<String> filterTypes = [
//     "Select By",
//     "Customer Name",
//     "Sub-Customer Name",
//     "Technician Name",
//     "Status",
//     "Region"
//   ].obs;
//
//   // Controllers and Variables
//   RxString selectedFilter = "Select By".obs;
//   RxList<TicketResult> ticketResult = <TicketResult>[].obs;
//   RxBool isLoading = false.obs;
//   RxString searchQuery = ''.obs;
//   Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
//   TextEditingController dateController = TextEditingController();
//   FocusNode focusNode = FocusNode();
//   bool isAmcSelected = false;
//   bool isRateSelected = false;
//   RxList<TicketHistoryResponseModel> ticketHistoryData = <TicketHistoryResponseModel>[].obs;
//
//   final taskNameController = TextEditingController();
//   final assignTo = TextEditingController();
//   final rateController = TextEditingController();
//   final purposeController = TextEditingController();
//   final customerNameController = TextEditingController();
//   final productNameController = TextEditingController();
//   final modelNoController = TextEditingController();
//   final fsrController = TextEditingController();
//   final servicesDetailsController = TextEditingController();
//   final instructionController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTicketsApiCall();
//   }
//
//   @override
//   void onClose() {
//     taskNameController.dispose();
//     rateController.dispose();
//     assignTo.dispose();
//     purposeController.dispose();
//     dateController.dispose();
//     customerNameController.dispose();
//     productNameController.dispose();
//     modelNoController.dispose();
//     fsrController.dispose();
//     servicesDetailsController.dispose();
//     instructionController.dispose();
//     startDateController.dispose();
//     endDateController.dispose();
//     super.onClose();
//   }
//
//   // Toggle Functions
//   void toggleAmc() {
//     isAmcSelected = true;
//     isRateSelected = false;
//     update();
//   }
//
//   void toggleRate() {
//     isAmcSelected = false;
//     isRateSelected = true;
//     update();
//   }
//
//   // API Calls
//   void fetchTicketsApiCall() async {
//     isLoading.value = true;
//     customLoader.show();
//     FocusManager.instance.primaryFocus?.unfocus();
//
//     try {
//       final response = await Get.find<AuthenticationApiService>()
//           .getticketDetailsApiCall();
//       if (response != null) {
//         ticketResult.assignAll(response.results);
//         applyFilters(); // Apply initial filters
//       }
//       List<String> ticketids = ticketResult.map((ids) => ids.id.toString())
//           .toList();
//       await storage.write(ticketId, ticketids);
//     } catch (error) {
//       toast('Error fetching ticket details: ${error.toString()}');
//     } finally {
//       customLoader.hide();
//       isLoading.value = false;
//     }
//   }
//
//   // Filter Functions
//   void applyFilters() {
//     if (ticketResult.isEmpty) return;
//
//     var filteredTickets = List<TicketResult>.from(ticketResult);
//
//     if (searchQuery.isNotEmpty) {
//       final query = searchQuery.value.toLowerCase();
//
//       filteredTickets = filteredTickets.where((ticket) {
//         switch (selectedFilter.value) {
//           case "Customer Name":
//             return ticket.customerDetails.customerName?.toLowerCase().contains(query) ?? false;
//           case "Sub-Customer Name":
//             return ticket.subCustomerDetails?.customerName?.toLowerCase().contains(query) ?? false;
//           case "Technician Name":
//             final techName = '${ticket.assignTo.firstName ?? ''} ${ticket.assignTo.lastName ?? ''}'.trim().toLowerCase();
//             return techName.contains(query);
//           case "Status":
//             return ticket.status.toLowerCase().contains(query);
//           case "Region":
//             return ticket.ticketAddress.country?.toLowerCase().contains(query) ?? false;
//           default:
//             return (ticket.customerDetails.customerName?.toLowerCase().contains(query) ?? false) ||
//                 (ticket.subCustomerDetails?.customerName?.toLowerCase().contains(query) ?? false) ||
//                 (ticket.status.toLowerCase().contains(query)) ||
//                 (ticket.ticketAddress.country?.toLowerCase().contains(query) ?? false) ||
//                 ('${ticket.assignTo.firstName ?? ''} ${ticket.assignTo.lastName ?? ''}'.trim().toLowerCase().contains(query));
//         }
//       }).toList();
//     }
//
//     ticketResult.value = filteredTickets;
//   }
//
//   // Date Selection Functions
//   Future<void> selectDateRange(BuildContext context, bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//
//     if (picked != null) {
//       if (isStartDate) {
//         startDate.value = picked;
//         startDateController.text = DateFormat('dd-MMM-yyyy').format(picked);
//       } else {
//         endDate.value = picked;
//         endDateController.text = DateFormat('dd-MMM-yyyy').format(picked);
//       }
//     }
//   }
//
//   void selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate.value ?? DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null && picked != selectedDate.value) {
//       selectedDate.value = picked;
//       dateController.text = DateFormat('dd-MMM-yyyy').format(picked);
//     }
//   }
//
//   // Excel Export Function
//   Future<void> exportToExcel() async {
//     try {
//       if (startDate.value == null || endDate.value == null) {
//         toast('Please select both start and end dates');
//         return;
//       }
//
//       isLoading.value = true;
//       customLoader.show();
//
//       // Request storage permission
//       final hasPermission = await requestPermissionHandler();
//       if (!hasPermission) {
//         toast('Please grant storage permission to export Excel file');
//         return;
//       }
//
//       // Filter tickets based on date range
//       final filteredTickets = ticketResult.where((ticket) {
//         final ticketDate = DateTime.parse(ticket.date);
//         return ticketDate.isAfter(startDate.value!) &&
//             ticketDate.isBefore(endDate.value!.add(Duration(days: 1)));
//       }).toList();
//
//       if (filteredTickets.isEmpty) {
//         toast('No tickets found in the selected date range');
//         return;
//       }
//
//       // Create Excel file
//       final excel = Excel.createExcel();
//       final Sheet sheet = excel['Tickets'];
//
//       // Add headers
//       for (var i = 0; i < excelColoumn.length; i++) {
//         final cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
//         cell.value = CellValue.fromString(excelColoumn[i]);
//         cell.cellStyle = CellStyle(
//           bold: true,
//           horizontalAlign: HorizontalAlign.Center,
//         );
//       }
//
//       // Add data
//       for (var i = 0; i < filteredTickets.length; i++) {
//         final ticket = filteredTickets[i];
//         final row = i + 1;
//
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
//           ..value = ticket.id;
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
//           ..value = ticket.taskName;
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row))
//           ..value = DateFormat('dd-MMM-yyyy').format(DateTime.parse(ticket.date));
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row))
//           ..value = DateFormat('HH:mm').format(DateTime.parse(ticket.date));
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
//           ..value = getFullName(ticket.assignTo);
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
//           ..value = ticket.isRated ? 'Yes' : 'No';
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row))
//           ..value = ticket.rate?.toString() ?? 'N/A';
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row))
//           ..value = ticket.isAmc ? 'Yes' : 'No';
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row))
//           ..value = ticket.customerDetails.customerName;
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row))
//           ..value = ticket.fsrName;
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row))
//           ..value = ticket.instructions;
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: row))
//             .value = ticket.status;
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: row))
//           ..value = formatDateTime(ticket.startDateTime);
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: row))
//           ..value = formatDateTime(ticket.endDateTime);
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: row))
//           ..value = ticket.purpose;
//         sheet.cell(CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: row))
//           ..value = ticket.subCustomerDetails?.customerName ?? 'N/A';
//       }
//
//       // Save file
//       final directory = Directory('/storage/emulated/0/Download');
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//
//       final fileName = 'tickets_${DateFormat('dd_MM_yyyy').format(startDate.value!)}_to_${DateFormat('dd_MM_yyyy').format(endDate.value!)}.xlsx';
//       final file = File('${directory.path}/$fileName');
//
//       await file.writeAsBytes(excel.encode()!);
//       toast('Excel file exported successfully to Downloads/$fileName');
//
//     } catch (error) {
//       toast('Error exporting Excel file: ${error.toString()}');
//     } finally {
//       isLoading.value = false;
//       customLoader.hide();
//     }
//   }
//
//   // Utility Functions
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
//   String formatDateTime(String? dateTime) {
//     if (dateTime == null || dateTime.isEmpty) return 'N/A';
//     return dateTime;
//   }
//
//   String getFullName(UserModel user) {
//     final firstName = user.firstName ?? '';
//     final lastName = user.lastName ?? '';
//     return '$firstName $lastName'.trim();
//   }
//
//   String getFormattedAddress(TicketAddress address) {
//     final components = [
//       address.city,
//       address.state,
//       address.country,
//       address.zipcode
//     ].where((component) => component != null && component.isNotEmpty);
//     return components.isEmpty ? 'N/A' : components.join(', ');
//   }
//
//   // Permission Handler
//   Future<bool> requestPermissionHandler() async {
//     if (Platform.isAndroid) {
//       final storageStatus = await Permission.storage.request();
//       if (storageStatus.isGranted) {
//         return true;
//       }
//       if (storageStatus.isPermanentlyDenied) {
//         await openAppSettings();
//         return false;
//       }
//       return false;
//     }
//     return true;
//   }
//
//   // Ticket Actions
//   Future<void> handleDeleteTicket(TicketResult ticket) async {
//     try {
//       final confirmed = await Get.dialog(
//         CupertinoAlertDialog(
//           title: Text('Confirm Delete'),
//           content: Text('Are you sure you want to delete this ticket?'),
//           actions: [
//             CupertinoDialogAction(
//               child: Text('Cancel'),
//               onPressed: () => Get.back(result: false),
//             ),
//             CupertinoDialogAction(
//               isDestructiveAction: true,
//               child: Text('Delete'),
//               onPressed: () => Get.back(result: true),
//             ),
//           ],
//         ),
//       );
//
//       if (confirmed == true) {
//         ticketResult.remove(ticket);
//         toast('Ticket deleted successfully');
//       }
//     } catch (error) {
//       toast('Error deleting ticket: ${error.toString()}');
//     }
//   }
//
//   Future<void> downloadTicketData(String? ticketId) async {
//     if (ticketId == null) {
//       toast('Invalid Ticket Id');
//       return;
//     }
//     isLoading.value = true;
//     customLoader.show();
//     FocusManager.instance.primaryFocus!.context;
//
//     final hasPermission = await requestPermissionHandler();
//     if (!hasPermission) {
//       isLoading.value = false;
//       customLoader.hide();
//       toast('Please grant storage permission from settings to download tickets');
//       return;
//     }
//
//     Get.find<AuthenticationApiService>().downloadTicketDataByUsername(id: ticketId).then((value) async {
//       Directory? directory;
//       if (Platform.isAndroid) {
//         directory = Directory('/storage/emulated/0/Download');
//       } else {
//         directory = await getApplicationDocumentsDirectory();
//       }
//
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       final fileName = 'ticket_${ticketId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
//       final file = File('${directory.path}/$fileName');
//       await file.writeAsBytes(value);
//       customLoader.hide();
//       toast("Ticket data downloaded to: ${file.path}");
//       update();
//     }).onError((error, stackError) {
//       isLoading.value = false;
//       customLoader.hide();
//       toast(error.toString());
//     });
//   }
//
//   void hitGetTicketHistoryApiCall(String id) {
//     isLoading.value = true;
//     customLoader.show();
//     FocusManager.instance.primaryFocus!.unfocus();
//     Get.find<AuthenticationApiService>().getTicketHistoryData(id: id).then((value) {
//       ticketHistoryData.addAll(value);
//       toast("Ticket History Fetched Successfully");
//       customLoader.hide();
//       update();
//     }).onError((error, stackError) {
//       customLoader.hide();
//       toast(error.toString());
//     });
//   }
//
//   Future<void> hitRefreshAllTicketData() async {
//     fetchTicketsApiCall();
//   }
// }