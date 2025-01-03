import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/fsr_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/enum.dart';

class FsrViewController extends GetxController {

  late TextEditingController firstNameController ;
  final List<TextEditingController> categoryNameControllers = [TextEditingController()];
  final List<List<TextEditingController>> categoryCheckpointControllers = [[TextEditingController()]];
  late FocusNode firstNameFocusNode ;
  late TextEditingController searchController ;
  final TextEditingController checkPointStatusCheckingController = TextEditingController();
  final FocusNode checkPointStatusCheckingFocusNode = FocusNode();
  final RxString searchQuery = ''.obs;
  // Data holders
  final RxList<Result> allFsr = <Result>[].obs;
  final RxList<Result> filteredFsr = <Result>[].obs;
  final RxList<Category> categoryData = <Category>[].obs;
  final RxList<Checkpoint>checkPointData = <Checkpoint>[].obs;
  final RxList<CheckAndUpdateCheckingPointForFsrResponseModel>checkPointsDetails=<CheckAndUpdateCheckingPointForFsrResponseModel>[].obs;
  final RxBool isLoading = false.obs;
  StatusType selectedType = StatusType.dropdown;
  RxList<String> statusItems =<String>[].obs;
  final RxList<String> mockResponse =<String>[].obs;

  TextEditingController _statusController = TextEditingController();

  // Pagination related variables
  final RxInt currentPage = 0.obs;
  final RxInt totalPages = 0.obs;
  final RxInt totalCount = 0.obs;

  void changePage(int page) {
    if (page > 0 && page <= _calculateTotalPages()) {
      currentPage.value = page;
      update();
    }
  }

  // Calculate total pages based on filtered data
  int _calculateTotalPages() {
    const pageSize = 10;
    return (filteredFsr.length / pageSize).ceil();
  }



  @override
  void onInit() {
    firstNameController = TextEditingController();
    searchController= TextEditingController();
    firstNameFocusNode = FocusNode();
    super.onInit();
    searchController.addListener(_onSearchChanged);
    currentPage.value = 1; // Start on first page
    hitGetFsrDetailsApiCall();
  }

  @override
  void dispose() {
    _statusController.dispose();
    super.dispose();
  }

  void updateSearch(String query) {
    searchQuery.value = query.trim();
    _filterFsr();
    currentPage.value = 1; // Reset to first page on search
    update(); // Ensure UI updates
  }

  void _filterFsr() {
    if (searchQuery.isEmpty) {
      filteredFsr.assignAll(allFsr);
    } else {
      final query = searchQuery.toLowerCase();
      filteredFsr.assignAll(allFsr.where((fsr) => _matchesFsrCriteria(fsr, query)));
    }
    totalPages.value = _calculateTotalPages();
    update();
  }

  bool _matchesFsrCriteria(Result fsr, String query) {
    // Check FSR name
    if (fsr.fsrName?.toLowerCase().contains(query) ?? false) {
      return true;
    }


    if (fsr.categories?.any((category) =>
    // Category name
    (category.name?.toLowerCase().contains(query) ?? false) ||
        // Checkpoints within category
        (category.checkpoints?.any((checkpoint) =>
        checkpoint.checkpointName?.toLowerCase().contains(query) ?? false
        ) ?? false)
    ) ?? false) {
      return true;
    }

    return false;
  }

  List<Result> getPaginatedData() {
    const itemsPerPage = 10;
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    if (filteredFsr.isEmpty) return [];
    if (startIndex >= filteredFsr.length) return [];

    return filteredFsr.sublist(
        startIndex,
        endIndex > filteredFsr.length ? filteredFsr.length : endIndex
    );
  }


  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _filterFsr();
    currentPage.value = 1;
    update();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    for (var controller in categoryNameControllers) {
      controller.dispose();
    }
    for (var checkpointList in categoryCheckpointControllers) {
      for (var controller in checkpointList) {
        controller.dispose();
      }
    }
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    checkPointStatusCheckingController.dispose();
    checkPointStatusCheckingFocusNode.dispose();
    super.onClose();
  }
  void addNewCategoryField() {
    categoryNameControllers.add(TextEditingController());
    categoryCheckpointControllers.add([TextEditingController()]);
    update();
  }

  void removeCategoryField(int index) {
    if (index < categoryNameControllers.length) {
      categoryNameControllers[index].dispose();
      for (var controller in categoryCheckpointControllers[index]) {
        controller.dispose();
      }
      categoryNameControllers.removeAt(index);
      categoryCheckpointControllers.removeAt(index);
      update();
    }
  }

  void _onSearchChanged() {
    updateSearch(searchController.text);
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
    FocusManager.instance.primaryFocus!.unfocus();
    var queryfsr = {
      "page_size": "all"
    };
    try {
      final response = await Get.find<AuthenticationApiService>().getfsrDetailsApiCall(parameter: queryfsr);
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

  void hitputMehtodforUpdationInFserDetails({
    required String id,
  required String fsrname,
  required String categories_name,
  required String catId}){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    var fsrResponses = {
      "id": id,
      "fsrName": fsrname,
      "categories": [
      {
        "id": catId,
        "name": categories_name,
        "checkpoints": [],
      },
      ]
    };
    Get.find<AuthenticationApiService>().putfsrDetailsApiCall(dataBody: fsrResponses,id: id).then((value){
      toast("FSR Updated Successfully");
      customLoader.hide();
      update();
    }).onError((error,stackError){
      toast(error.toString());
      customLoader.hide();
    });
  }

  void GetFsrCheckingPointDetailsApiCall({required String fsr_id,required String Category_id}){
    isLoading.value=true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var checkingpointparameter = {
      "fsr_id":fsr_id,
      "category_id":Category_id
    };
    Get.find<AuthenticationApiService>().getFsrCheckingPointDetailsApiCall(parameter: checkingpointparameter).then((value){
      checkPointsDetails.assignAll(value);
      print("ajfjadf: ${value}");
      toast('CheckPoint data Fetched Successfully');
      customLoader.hide();
      update();
    }).onError((error,stackError){
      toast(error.toString());
      customLoader.hide();
    });
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

  void hitUpdateCheckPointStatuses({
    required String fsrId,
    required String categoryId,
    required String checkpointName,
    required List<String> checkpointStatuses,
    required String displayType,
  }) {
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();

    var requestData = {
      "fsr_id": fsrId,
      "category_id": categoryId,
      "checkpoints": [
        {"checkpoint_name": checkpointName,
          "checkpointStatuses":checkpointStatuses,
          "displayType": displayType},
      ]
    };
    Get.find<AuthenticationApiService>()
        .UpdatecheckPointStatusApiCall(dataBody: requestData)
        .then((response) {
      toast(response.message.toString());
      Get.back();
      hitGetFsrDetailsApiCall();
      customLoader.hide();// Refresh the data
      update();
    }).onError((error, stackTrace) {
      toast(error.toString());
    }).whenComplete(() {
      isLoading.value = false;
      customLoader.hide();
    });
  }


  void deleteFSrDetails({required String fsrid}){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().deletefsrDetailsApiCall(id: fsrid).then((value){
      toast(value.message.toString());
      customLoader.hide();
      update();
    }).onError((error,stackError){
      toast(error.toString());
      customLoader.hide();
    });
  }
  // Future<void> updateCheckpointStatuses(
  //     String fsrId,
  //     String categoryId,
  //     Map<String, String> checkpointStatuses,
  //     ) async {
  //   try {
  //     isLoading.value = true;
  //     final response = await _fsrService.updateCheckpointStatuses(
  //       fsrId: fsrId,
  //       categoryId: categoryId,
  //       checkpointStatuses: checkpointStatuses,
  //     );
  //
  //     if (response != null && response.success == true) {
  //       toast('Checkpoint statuses updated successfully');
  //       await hitGetFsrDetailsApiCall(); // Refresh the list
  //     } else {
  //       toast('Failed to update checkpoint statuses');
  //     }
  //   } catch (e) {
  //     print('Error updating checkpoint statuses: $e');
  //     toast('Failed to update checkpoint statuses');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}


