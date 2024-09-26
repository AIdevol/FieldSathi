// File: ticket_list_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../widgets/views/ticket_model_data.dart';

class TicketListController extends GetxController {
  static const String API_ENDPOINT = 'https://your-api-endpoint.com/tickets';

  RxList<String> filterTypes = [
    "Select By",
    "Customer Name",
    "Sub-Customer Name",
    "Technician Name",
    "Status",
    "Region"
  ].obs;

  RxString selectedFilter = "Select By".obs;
  RxList<Ticket> tickets = <Ticket>[].obs;
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(API_ENDPOINT));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        tickets.value = jsonData.map((json) => Ticket.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tickets');
      }
    } catch (e) {
      print('Error fetching tickets: $e');
      Get.snackbar('Error', 'Failed to load tickets. Please try again.');
    } finally {
      isLoading.value = false;
    }
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

  void applyFilters() {
    List<Ticket> filteredTickets = tickets;

    if (searchQuery.isNotEmpty) {
      filteredTickets = filteredTickets.where((ticket) {
        return ticket.customerName.toLowerCase().contains(searchQuery.toLowerCase()) ||
            ticket.subCustomerName.toLowerCase().contains(searchQuery.toLowerCase()) ||
            ticket.technicianName.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedFilter.value != "Select By") {
      filteredTickets = filteredTickets.where((ticket) {
        switch (selectedFilter.value) {
          case "Customer Name":
            return ticket.customerName.toLowerCase().contains(searchQuery.toLowerCase());
          case "Sub-Customer Name":
            return ticket.subCustomerName.toLowerCase().contains(searchQuery.toLowerCase());
          case "Technician Name":
            return ticket.technicianName.toLowerCase().contains(searchQuery.toLowerCase());
          case "Status":
            return ticket.status.toLowerCase() == searchQuery.toLowerCase();
          case "Region":
            return ticket.region.toLowerCase() == searchQuery.toLowerCase();
          default:
            return true;
        }
      }).toList();
    }

    tickets.value = filteredTickets;
  }

  Future<void> addTicket(Ticket newTicket) async {
    try {
      final response = await http.post(
        Uri.parse(API_ENDPOINT),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newTicket.toJson()),
      );
      if (response.statusCode == 201) {
        await fetchTickets();
        Get.snackbar('Success', 'Ticket added successfully');
      } else {
        throw Exception('Failed to add ticket');
      }
    } catch (e) {
      print('Error adding ticket: $e');
      Get.snackbar('Error', 'Failed to add ticket. Please try again.');
    }
  }

  Future<void> updateTicket(Ticket updatedTicket) async {
    try {
      final response = await http.put(
        Uri.parse('$API_ENDPOINT/${updatedTicket.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedTicket.toJson()),
      );
      if (response.statusCode == 200) {
        await fetchTickets();
        Get.snackbar('Success', 'Ticket updated successfully');
      } else {
        throw Exception('Failed to update ticket');
      }
    } catch (e) {
      print('Error updating ticket: $e');
      Get.snackbar('Error', 'Failed to update ticket. Please try again.');
    }
  }

  Future<void> deleteTicket(int id) async {
    try {
      final response = await http.delete(Uri.parse('$API_ENDPOINT/$id'));
      if (response.statusCode == 204) {
        tickets.removeWhere((ticket) => ticket.id == id);
        Get.snackbar('Success', 'Ticket deleted successfully');
      } else {
        throw Exception('Failed to delete ticket');
      }
    } catch (e) {
      print('Error deleting ticket: $e');
      Get.snackbar('Error', 'Failed to delete ticket. Please try again.');
    }
  }
}