import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/amc_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class AMCScreenController extends GetxController {
  int? selectedNumberOfService;
  final List<String> excelcoloumndata = [
    "AMC Name",
    "Activation Time",
    "Activation Date",
    "Remainder",
    "Product Brand",
    "Product Name",
    "Serial Model No",
    "Under Warranty",
    "Service Amount",
    "Received Amount",
    "Status",
    "Service Occurrence",
    "Service Name",
    "Customer Name",
    "No of Service",
    "Note",
    "Expiry Date"
  ];

  late TextEditingController amcNameController;
  late TextEditingController activationTimeController;
  late TextEditingController datesController;
  late TextEditingController noOfServiceController;
  late TextEditingController reminderController;
  late TextEditingController serviceOccurrenceController;
  late TextEditingController productNameController;
  late TextEditingController productBrandController;
  late TextEditingController serialModelNoController;
  late TextEditingController serviceAmountController;
  late TextEditingController recievedAmountController;
  late TextEditingController customerNameController;
  late TextEditingController notesController;

  late FocusNode amcNameFocusNode;
  late FocusNode activationTimeFocusNode;
  late FocusNode datesFocusNode;
  late FocusNode noOfServiceFocusNode;
  late FocusNode productBrandFocusNode;
  late FocusNode reminderFocusNode;
  late FocusNode serviceOccurenceFocusNode;
  late FocusNode productNameFocusNode;
  late FocusNode serialModelFocusNode;
  late FocusNode serviceAmountFocusNode;
  late FocusNode recieveAmountFocusNode;
  late FocusNode customerNameFocusNode;
  late FocusNode notesFocusNode;

  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  final int itemsPerPage = 10;

  FocusNode focusNode = FocusNode();
  RxBool isLoading = false.obs;
  TextEditingController dateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool isFocused = false.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxList<AmcResult> amcResultData = <AmcResult>[].obs;
  RxList<AmcResult> filteredAmcData = <AmcResult>[].obs;
  RxList<AmcResult> amcPaginationData =<AmcResult>[].obs;

  void initializeNumberOfService() {
    selectedNumberOfService = 1;
  }
  // Counters for different AMC states
  RxInt totalAmcCount = 0.obs;
  RxInt upcomingCount = 0.obs;
  RxInt renewalCount = 0.obs;
  RxInt completedCount = 0.obs;

  @override
  void onInit() {
    amcNameController = TextEditingController();
    activationTimeController = TextEditingController();
    serviceAmountController = TextEditingController();
    datesController = TextEditingController();
    noOfServiceController = TextEditingController();
    reminderController = TextEditingController();
    serviceOccurrenceController = TextEditingController();
    productNameController = TextEditingController();
    productBrandController = TextEditingController();
    serialModelNoController = TextEditingController();
    recievedAmountController = TextEditingController();
    customerNameController = TextEditingController();
    notesController = TextEditingController();

    amcNameFocusNode = FocusNode();
    activationTimeFocusNode = FocusNode();
    datesFocusNode = FocusNode();
    noOfServiceFocusNode = FocusNode();
    reminderFocusNode = FocusNode();
    serviceOccurenceFocusNode = FocusNode();
    productNameFocusNode = FocusNode();
    productBrandFocusNode = FocusNode();
    serialModelFocusNode = FocusNode();
    recieveAmountFocusNode = FocusNode();
    customerNameFocusNode = FocusNode();
    notesFocusNode = FocusNode();
    super.onInit();
    hitGetAmcDetailsApiCall();
    hitAmcCountApiCall();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    amcNameController.dispose();
    activationTimeController.dispose();
    datesController.dispose();
    noOfServiceController.dispose();
    reminderController.dispose();
    serviceOccurrenceController.dispose();
    productNameController.dispose();
    productBrandController.dispose();
    serialModelNoController.dispose();
    recievedAmountController.dispose();
    customerNameController.dispose();
    notesController.dispose();
    dateController.dispose();
    searchController.dispose();

    amcNameFocusNode.dispose();
    activationTimeFocusNode.dispose();
    datesFocusNode.dispose();
    noOfServiceFocusNode.dispose();
    reminderFocusNode.dispose();
    serviceOccurenceFocusNode.dispose();
    productNameFocusNode.dispose();
    productBrandFocusNode.dispose();
    serialModelFocusNode.dispose();
    recieveAmountFocusNode.dispose();
    customerNameFocusNode.dispose();
    notesFocusNode.dispose();

    focusNode.dispose();
    super.onClose();
  }

  void calculateTotalPages() {
    totalPages.value = (filteredAmcData.length / itemsPerPage).ceil();
    if (currentPage.value > totalPages.value) {
      currentPage.value = totalPages.value;
    }
    if (currentPage.value < 1) {
      currentPage.value = 1;
    }
  }

  void updatePaginatedTechnicians() {
    List<AmcResult> sourceList = filteredAmcData.isEmpty
        ? amcResultData
        : filteredAmcData;
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
    amcPaginationData.value = sourceList.sublist(
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

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredAmcData.assignAll(amcResultData);
    } else {
      filteredAmcData.assignAll(amcResultData.where((amc) =>
      amc.amcName?.toLowerCase().contains(query) == true ||
          amc.customer.customerName?.toLowerCase().contains(query) == true ||
          amc.id.toString().contains(query)
      ));
    }
    update();
  }

  void hitGetAmcDetailsApiCall() async {
    var amcParameter={
      "page_size":"all"
    };
    try {
      isLoading.value = true;
      customLoader.show();

      final amcData = await Get.find<AuthenticationApiService>().getAmcDetailsApiCall(parameter: amcParameter);
      totalAmcCount.value = amcData.count ?? 0;
      amcResultData.assignAll(amcData.results);
      amcPaginationData.assignAll(amcData.results);
      List<String> amcIds = amcResultData.map((amcLiveData)=>amcLiveData.id.toString()).toList();
      await storage.write(amcId, amcIds);
      print("amc id dekh le bhai= ${storage.read(amcId)}");
      filteredAmcData.assignAll(amcData.results);
      // _calculateAmcCounts();
      calculateTotalPages();
      toast("AMC successfully Fetched");
      update();
    } catch (error) {
      toast(error.toString());
    } finally {
      customLoader.hide();
      isLoading.value = false;
    }
  }

  // void _calculateAmcCounts() {
  //   if (amcResultData.isEmpty) return;
  //
  //   int upcoming = 0;
  //   int renewal = 0;
  //   int completed = 0;
  //
  //   for (var amc in amcResultData) {
  //     String status = amc.status?.toLowerCase() ?? '';
  //
  //     switch (status) {
  //       case 'upcoming':
  //         upcoming++;
  //         break;
  //       case 'renewal':
  //         renewal++;
  //         break;
  //       case 'completed':
  //         completed++;
  //         break;
  //     }
  //   }
  //
  //   upcomingCount.value = upcoming;
  //   renewalCount.value = renewal;
  //   completedCount.value = completed;
  // }

  Future<void> selectDate(BuildContext context) async {
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

  Future<void> deleteAMC(String amcId) async {
    try {
      customLoader.show();
      // Implement your delete API call here
      // await Get.find<AuthenticationApiService>().deleteAmcApiCall(amcId);
      hitGetAmcDetailsApiCall(); // Refresh data after deletion
      toast("AMC deleted successfully");
    } catch (error) {
      toast(error.toString());
    } finally {
      customLoader.hide();
    }
  }

  Future<void> exportData() async {
    try {
      customLoader.show();
      // Implement your export functionality here
      toast("Export started");
    } catch (error) {
      toast(error.toString());
    } finally {
      customLoader.hide();
    }
  }

void hitAmcCountApiCall(){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().getAmcCountsApiCall().then((value){
      totalAmcCount.value = value.total;
      upcomingCount.value = value.upcoming;
      renewalCount.value = value.renewal;
      completedCount.value = value.completed;
      toast("Amc Counts fetched successfully");
      update();
    }).onError((error,stackError){
      toast(error.toString());
      customLoader.hide();
      isLoading.value = false;
    });
}

Future<void>hitRefreshApiCalls()async{
  hitGetAmcDetailsApiCall();
  hitAmcCountApiCall();
}
}
