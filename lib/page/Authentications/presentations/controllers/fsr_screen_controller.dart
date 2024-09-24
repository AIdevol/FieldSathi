import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FsrViewcontroller extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxList<Ticket> filteredTickets = <Ticket>[].obs;

  List<Ticket> allTickets = [
    Ticket(Name: "Devesh", Categories: 'John Doe'),
    Ticket(Name: "Ayush", Categories: 'Malaika Arora'),
    // Add more sample data as needed
  ];

  @override
  void onInit() {
    super.onInit();
    filteredTickets.assignAll(allTickets);
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
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
      filteredTickets.assignAll(allTickets);
    } else {
      filteredTickets.assignAll(allTickets.where((ticket) =>
          ticket.Categories.toLowerCase().contains(searchQuery.toLowerCase())));
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
}

class Ticket {
  final String Name;
  final String Categories;

  Ticket({
    required this.Name,
    required this.Categories,
  });
}