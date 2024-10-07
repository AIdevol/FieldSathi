import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceRequestScreenController extends GetxController{

  // final Rx<String> selectedType = categoryTypes[0].obs;
  //
  // static get categoryTypes => null;
  final isSearching = false.obs;
  final searchController = TextEditingController();
  final searchResults = <String>[].obs;

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
      searchResults.clear();
    }
  }

  void performSearch(String query) {
    // Implement your search logic here
    // This is a placeholder implementation
    searchResults.value = [
      'Result 1 for $query',
      'Result 2 for $query',
      'Result 3 for $query',
    ];
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}