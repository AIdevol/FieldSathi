import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/fsr_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class FsrViewController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController checkPointStatusCheckingController = TextEditingController();
  final FocusNode checkPointStatusCheckingFocusNode = FocusNode();
  final RxString searchQuery = ''.obs;
  // Data holders
  final RxList<Result> allFsr = <Result>[].obs;
  final RxList<Result> filteredFsr = <Result>[].obs;
  final RxList<Category> categoryData = <Category>[].obs;
  final RxList<Checkpoint>checkPointData = <Checkpoint>[].obs;
  final RxBool isLoading = false.obs;

  // Pagination related variables
  final RxInt currentPage = 0.obs;
  final RxInt totalPages = 0.obs;
  final RxInt totalCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
    hitGetFsrDetailsApiCall();
  }

  // @override
  // void dispose(){
  //   for (var controller in checkPointStatusCheckingController){
  //     c
  //   }
  //   super.dispose();
  // }
  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    checkPointStatusCheckingController.dispose();
    checkPointStatusCheckingFocusNode.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    updateSearch(searchController.text);
  }

  void updateSearch(String query) {
    searchQuery.value = query;
    _filterFsr();
  }

  void _filterFsr() {
    if (searchQuery.isEmpty) {
      filteredFsr.assignAll(allFsr);
    } else {
      filteredFsr.assignAll(allFsr.where((fsr) =>
      fsr.fsrName?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false ||
          _searchInCategories(fsr.categories ?? [], searchQuery.toLowerCase())
      ));
    }
    update();
  }

  bool _searchInCategories(List<Category> categories, String query) {
    return categories.any((category) =>
    category.name?.toLowerCase().contains(query) ?? false ||
        _searchInCheckpoints(category.checkpoints ?? [], query)
    );
  }

  bool _searchInCheckpoints(List<Checkpoint> checkpoints, String query) {
    return checkpoints.any((checkpoint) =>
    checkpoint.checkpointName?.toLowerCase().contains(query) ?? false
    );
  }

  Future<void> hitGetFsrDetailsApiCall() async {
    isLoading.value = true;
    customLoader.show();

    try {
      final response = await Get.find<AuthenticationApiService>().getfsrDetailsApiCall();

      if (response != null) {
        // Update pagination info
        totalCount.value = response.count ?? 0;
        totalPages.value = response.totalPages ?? 0;
        currentPage.value = response.currentPage ?? 0;

        // Update FSR data
        if (response.results != null) {
          allFsr.assignAll(response.results!);
          filteredFsr.assignAll(response.results!);
        }

        toast('FSR data fetched successfully');
      }
    } catch (error) {
      toast('Error fetching FSR data: ${error.toString()}');
    } finally {
      isLoading.value = false;
      customLoader.hide();
      update();
    }
  }

  Future<void> hitPostCheckingStatusApiCall() async {
    if (checkPointStatusCheckingController.text.isEmpty) {
      toast('Please enter checkpoint status');
      return;
    }
    customLoader.show();
    try {
      final checkPointData = {
        "status_name": checkPointStatusCheckingController.text
      };
      await Get.find<AuthenticationApiService>()
          .postcheckPointStatusDetailsApiCall(dataBody: checkPointData);
      toast('Checkpoint status updated successfully');
      checkPointStatusCheckingController.clear();
      await hitGetFsrDetailsApiCall();
    } catch (error) {
      toast('Error updating checkpoint status: ${error.toString()}');
    } finally {
      customLoader.hide();
      update();
    }
  }

  // Helper method to get formatted category names for a FSR
  String getCategoryNames(Result fsr) {
    return fsr.categories
        ?.map((category) => category.name)
        .where((name) => name != null && name.isNotEmpty)
        .join(', ') ?? '';
  }

  // Helper method to get checkpoint names for a category
  String getCheckpointNames(Category category) {
    return category.checkpoints
        ?.map((checkpoint) => checkpoint.checkpointName)
        .where((name) => name != null && name.isNotEmpty)
        .join(', ') ?? '';
  }
}