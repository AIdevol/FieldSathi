
import 'dart:io';

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
import 'package:tms_sathi/response_models/ticket_history_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import '../../../../response_models/ticket_response_model.dart';

class TicketListController extends GetxController {
  // Filter options
  RxList<String> filterTypes = [
    "Select By",
    "Customer Name",
    "Sub-Customer Name",
    "Technician Name",
    "Status",
    "Region"
  ].obs;

  RxString selectedFilter = "Select By".obs;
  RxList<TicketResult> ticketResult = <TicketResult>[].obs;
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  TextEditingController dateController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isAmcSelected = false;
  bool isRateSelected = false;
  RxList<TicketHistoryResponseModel> ticketHistoryData = <TicketHistoryResponseModel>[].obs;

  final  taskNameController = TextEditingController();
  final assignTo = TextEditingController();
  final rateController = TextEditingController();
  final purposeController = TextEditingController();
  // final datesController = TextEditingController();
  final customerNameController = TextEditingController();
  final productNameController = TextEditingController();
  final modelNoController = TextEditingController();
  final fsrController = TextEditingController();
  final servicesDetailsController = TextEditingController();
  final instructionController = TextEditingController();
  // RxList<TicketHistory> ticketResulData = <TicketHistory>[].obs;

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
  }
@override
void onClose(){
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
  void fetchTicketsApiCall() async {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final response = await Get.find<AuthenticationApiService>()
          .getticketDetailsApiCall();
      if (response != null) {
        ticketResult.assignAll(response.results);
        applyFilters(); // Apply initial filters
      }
      List<String> ticketids = ticketResult.map((ids) => ids.id.toString())
          .toList();
      await storage.write(ticketId, ticketids);
    } catch (error) {
      toast('Error fetching ticket details: ${error.toString()}');
    } finally {
      customLoader.hide();
      isLoading.value = false;
    }
  }

  void applyFilters() {
    if (ticketResult.isEmpty) return;

    var filteredTickets = List<TicketResult>.from(ticketResult);

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();

      filteredTickets = filteredTickets.where((ticket) {
        switch (selectedFilter.value) {
          case "Customer Name":
            return ticket.customerDetails.customerName?.toLowerCase().contains(
                query) ??
                false;
          case "Sub-Customer Name":
            return ticket.subCustomerDetails?.customerName?.toLowerCase()
                .contains(query) ?? false;
          case "Technician Name":
            final techName = '${ticket.assignTo.firstName ?? ''} ${ticket
                .assignTo.lastName ?? ''}'.trim().toLowerCase();
            return techName.contains(query);
          case "Status":
            return ticket.status.toLowerCase().contains(query);
          case "Region":
            return ticket.ticketAddress.country?.toLowerCase().contains(
                query) ?? false;
          default:
          // Search across all fields when no specific filter is selected
            return (ticket.customerDetails.customerName?.toLowerCase().contains(
                query) ?? false) ||
                (ticket.subCustomerDetails?.customerName?.toLowerCase()
                    .contains(query) ?? false) ||
                (ticket.status.toLowerCase().contains(query)) ||
                (ticket.ticketAddress.country?.toLowerCase().contains(query) ??
                    false) ||
                ('${ticket.assignTo.firstName ?? ''} ${ticket.assignTo
                    .lastName ?? ''}'.trim().toLowerCase().contains(query));
        }
      }).toList();
    }

    ticketResult.value = filteredTickets;
  }

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


  String getFullName(UserModel user) {
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';
    return '$firstName $lastName'.trim();
  }


  String getFormattedAddress(TicketAddress address) {
    final components = [
      address.city,
      address.state,
      address.country,
      address.zipcode
    ].where((component) => component != null && component.isNotEmpty);

    return components.isEmpty ? 'N/A' : components.join(', ');
  }

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

  Future<void> downloadTicketData(String? ticketId) async {
    if (ticketId == null){
      toast('Invalid Ticket Id');
      return;
    }
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    final hasPermission = await requestPermissionHandler();
    if (!hasPermission) {
      isLoading.value = false;
      customLoader.hide();
      toast('Please grant storage permission from settings to download tickets');
      return;
    }
    Get.find<AuthenticationApiService>().downloadTicketDataByUsername(id: ticketId).then((value)async{
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final fileName = 'ticket_${ticketId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(value);
      customLoader.hide();
      toast("Ticket data downloaded to: ${file.path}");
      update();
    }).onError((error, stackError){
      isLoading.value = false;
      customLoader.hide();
      toast(error.toString());
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

void hitGetTicketHistoryApiCall(String id){
    isLoading.value = true;
    customLoader.show();
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
}