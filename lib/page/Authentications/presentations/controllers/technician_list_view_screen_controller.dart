import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TechnicianListViewScreenController extends GetxController{
  final searchController = TextEditingController();
  List<Technician> allTechnicians = [];
  List<Technician> filteredTechnicians = [];

  get filteredLeaves => null;

  @override
  void onInit() {
    super.onInit();
    fetchTechnicians();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void fetchTechnicians() {
    // TODO: Implement API call to fetch technicians
    // For now, we'll use dummy data
    allTechnicians = [
    ];
    filteredTechnicians = allTechnicians;
    update();
  }

  void searchTechnicians(String query) {
    if (query.isEmpty) {
      filteredTechnicians = allTechnicians;
    } else {
      filteredTechnicians = allTechnicians
          .where((technician) =>
      technician.name.toLowerCase().contains(query.toLowerCase()) ||
          technician.specialization.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void refreshList() {
    fetchTechnicians();
  }

  void importTechnicians() {
    // TODO: Implement import functionality
  }

  void exportTechnicians() {
    // TODO: Implement export functionality
  }

  void showTechnicianOptions(Technician technician) {
    // TODO: Implement options menu for each technician
  }
}

class Technician {
  final String name;
  final String specialization;

  Technician({required this.name, required this.specialization});
}