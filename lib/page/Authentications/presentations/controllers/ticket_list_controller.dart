import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';
import 'dart:convert';
import '../../../../response_models/ticket_response_model.dart';
import '../../widgets/views/ticket_model_data.dart';

class TicketListController extends GetxController {

  RxList<String> filterTypes = [
    "Select By",
    "Customer Name",
    "Sub-Customer Name",
    "Technician Name",
    "Status",
    "Region"
  ].obs;

  RxString selectedFilter = "Select By".obs;
  RxList<TicketResponseModel> ticketData = <TicketResponseModel>[].obs;
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTicketsApiCall();
  }

  void fetchTicketsApiCall() async {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      final tickets = await Get.find<AuthenticationApiService>().getticketDetailsApiCall();
      ticketData.assignAll(tickets);
      applyFilters();
    } catch (error) {
      toast(error.toString());
    } finally {
      customLoader.hide();
      isLoading.value = false;
    }
  }

  void applyFilters() {
    List<TicketResponseModel> filteredTickets = List.from(ticketData);

    if (searchQuery.isNotEmpty) {
      filteredTickets = filteredTickets.where((ticket) {
        final query = searchQuery.toLowerCase();
        return (ticket.customerDetails?.name?.toLowerCase().contains(query) ?? false) ||
            (ticket.subCustomerDetails?.subCustomerName?.toLowerCase().contains(query) ?? false) ||
            ((ticket.assignTo?.firstName?.toLowerCase().contains(query) ?? false) ||
                (ticket.assignTo?.lastName?.toLowerCase().contains(query) ?? false));
      }).toList();
    }

    if (selectedFilter.value != "Select By") {
      filteredTickets = filteredTickets.where((ticket) {
        switch (selectedFilter.value) {
          case "Customer Name":
            return ticket.customerDetails?.name?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
          case "Sub-Customer Name":
            return ticket.subCustomerDetails?.subCustomerName?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
          case "Technician Name":
            final technicianName = '${ticket.assignTo?.firstName ?? ''} ${ticket.assignTo?.lastName ?? ''}'.trim().toLowerCase();
            return technicianName.contains(searchQuery.toLowerCase());
          case "Status":
            return ticket.status?.toLowerCase() == searchQuery.toLowerCase();
          case "Region":
            return ticket.ticketAddress?.country?.toLowerCase() == searchQuery.toLowerCase();
          default:
            return true;
        }
      }).toList();
    }

    ticketData.value = filteredTickets;
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
// void toggleTicketSelection(TicketResponseModel ticket, bool isSelected) {
//   final index = ticketData.indexWhere((t) => t.id == ticket.id);
//   if (index != -1) {
//     ticketData[index] = ticket.customerDetails! as TicketResponseModel;
//     ticketData.refresh();
//   }
// }
}







//   void toggleTicketSelection(TicketResponseModel ticket, bool isSelected) {
//     final index = tickets.indexWhere((t) => t.id == ticket.id);
//     if (index != -1) {
//       tickets[index] = ticket.copyWith(isSelected: isSelected);
//       tickets.refresh();
//     }
//   }
// }

// extension TicketResponseModelExtension on TicketResponseModel {
//   TicketResponseModel copyWith({bool? isSelected}) {
//     return TicketResponseModel(
//       // ... copy all existing properties ...
//       isSelected: isSelected ?? this.isSelected,
//     );
//   }
// }
//   void applyFilters() {
//     List<TicketResponseModel> filteredTickets = List.from(ticketData);
//
//     if (searchQuery.isNotEmpty) {
//       filteredTickets = filteredTickets.where((ticket) {
//         final query = searchQuery.toLowerCase();
//         return (ticket.customerDetails?.name?.toLowerCase().contains(query) ??
//             false) ||
//             (ticket.subCustomerDetails?.subCustomerName?.toLowerCase().contains(
//                 query) ?? false) ||
//             ((ticket.assignTo?.firstName?.toLowerCase().contains(query) ??
//                 false) ||
//                 (ticket.assignTo?.lastName?.toLowerCase().contains(query) ??
//                     false));
//       }).toList();
//     }
//
//     if (selectedFilter.value != "Select By") {
//       filteredTickets = filteredTickets.where((ticket) {
//         switch (selectedFilter.value) {
//           case "Customer Name":
//             return ticket.customerDetails?.name?.toLowerCase().contains(
//                 searchQuery.toLowerCase()) ?? false;
//           case "Sub-Customer Name":
//             return ticket.subCustomerDetails?.subCustomerName?.toLowerCase()
//                 .contains(searchQuery.toLowerCase()) ?? false;
//           case "Technician Name":
//             final technicianName = '${ticket.assignTo?.firstName ?? ''} ${ticket
//                 .assignTo?.lastName ?? ''}'.trim().toLowerCase();
//             return technicianName.contains(searchQuery.toLowerCase());
//           case "Status":
//             return ticket.status?.toLowerCase() == searchQuery.toLowerCase();
//           case "Region":
//             return ticket.ticketAddress?.country?.toLowerCase() ==
//                 searchQuery.toLowerCase();
//           default:
//             return true;
//         }
//       }).toList();
//     }
//
//     ticketData.value = filteredTickets;
//   }


// Future<void> addTicket(Ticket newTicket) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(API_ENDPOINT),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(newTicket.toJson()),
  //     );
  //     if (response.statusCode == 201) {
  //       await fetchTickets();
  //       Get.snackbar('Success', 'Ticket added successfully');
  //     } else {
  //       throw Exception('Failed to add ticket');
  //     }
  //   } catch (e) {
  //     print('Error adding ticket: $e');
  //     Get.snackbar('Error', 'Failed to add ticket. Please try again.');
  //   }
  // }

  // Future<void> updateTicket(Ticket updatedTicket) async {
  //   try {
  //     final response = await http.put(
  //       Uri.parse('$API_ENDPOINT/${updatedTicket.id}'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(updatedTicket.toJson()),
  //     );
  //     if (response.statusCode == 200) {
  //       await fetchTickets();
  //       Get.snackbar('Success', 'Ticket updated successfully');
  //     } else {
  //       throw Exception('Failed to update ticket');
  //     }
  //   } catch (e) {
  //     print('Error updating ticket: $e');
  //     Get.snackbar('Error', 'Failed to update ticket. Please try again.');
  //   }
  // }

  // Future<void> deleteTicket(int id) async {
  //   try {
  //     final response = await http.delete(Uri.parse('$API_ENDPOINT/$id'));
  //     if (response.statusCode == 204) {
  //       tickets.removeWhere((ticket) => ticket.id == id);
  //       Get.snackbar('Success', 'Ticket deleted successfully');
  //     } else {
  //       throw Exception('Failed to delete ticket');
  //     }
  //   } catch (e) {
  //     print('Error deleting ticket: $e');
  //     Get.snackbar('Error', 'Failed to delete ticket. Please try again.');
  //   }
  // }


// import 'package:get/get.dart';
// import '../../../../response_models/ticket_response_model.dart';
// import '../../../../services/APIs/auth_services/auth_api_services.dart';
// import '../../../../services/APIs/network_except.dart';
// import '../../widgets/views/ticket_model_data.dart';
//
// class TicketListController extends GetxController {
//   final AuthenticationApiService _authApiService = Get.find<AuthenticationApiService>();
//
//   RxList<String> filterTypes = [
//     "Select By",
//     "Customer Name",
//     "Sub-Customer Name",
//     "Technician Name",
//     "Status",
//     "Region"
//   ].obs;
//
//   RxString selectedFilter = "Select By".obs;
//   RxList<TicketResponseModel> tickets = <TicketResponseModel>[].obs;
//   RxBool isLoading = false.obs;
//   RxString searchQuery = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTickets();
//   }
//
//   Future<void> fetchTickets() async {
//     isLoading.value = true;
//     try {
//       final response = await _authApiService.getticketDetailsApiCall();
//       tickets.value = [response]; // Assuming the API returns a single TicketResponseModel
//       applyFilters(); // Apply initial filters
//     } catch (e) {
//       if (e is NetworkExceptions) {
//         Get.snackbar('Error', e.toString());
//       } else {
//         Get.snackbar('Error', 'An unexpected error occurred');
//       }
//     } finally {
//       isLoading.value = false;
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
//     List<TicketResponseModel> filteredTickets = List.from(tickets);
//
//     if (searchQuery.isNotEmpty) {
//       filteredTickets = filteredTickets.where((ticket) {
//         final query = searchQuery.toLowerCase();
//         return ticket.customerDetails.customerName.toLowerCase().contains(query) ||
//             ticket.subCustomerDetails.customerName.toLowerCase().contains(query) ||
//             ticket.assignTo.firstName.toLowerCase().contains(query) ||
//             ticket.assignTo.lastName.toLowerCase().contains(query);
//       }).toList();
//     }
//
//     if (selectedFilter.value != "Select By") {
//       filteredTickets = filteredTickets.where((ticket) {
//         switch (selectedFilter.value) {
//           case "Customer Name":
//             return ticket.customerDetails.customerName.toLowerCase().contains(searchQuery.toLowerCase());
//           case "Sub-Customer Name":
//             return ticket.subCustomerDetails.customerName.toLowerCase().contains(searchQuery.toLowerCase());
//           case "Technician Name":
//             return '${ticket.assignTo.firstName} ${ticket.assignTo.lastName}'.toLowerCase().contains(searchQuery.toLowerCase());
//           case "Status":
//             return ticket.status.toLowerCase() == searchQuery.toLowerCase();
//           case "Region":
//             return ticket.ticketAddress.region?.toLowerCase() == searchQuery.toLowerCase();
//           default:
//             return true;
//         }
//       }).toList();
//     }
//
//     tickets.value = filteredTickets;
//   }
// }
