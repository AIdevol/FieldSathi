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


  FocusNode focusNode = FocusNode();
  RxBool isLoading = false.obs;
  TextEditingController dateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool isFocused = false.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxList<AmcResult> amcResultData = <AmcResult>[].obs;
  RxList<AmcResult> filteredAmcData = <AmcResult>[].obs;

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
    try {
      isLoading.value = true;
      customLoader.show();
      final amcData = await Get.find<AuthenticationApiService>().getAmcDetailsApiCall();
      totalAmcCount.value = amcData.count ?? 0;
      amcResultData.assignAll(amcData.results);
      List<String> amcIds = amcResultData.map((amcLiveData)=>amcLiveData.id.toString()).toList();
      await storage.write(amcId, amcIds);
      print("amc id dekh le bhai= ${storage.read(amcId)}");
      filteredAmcData.assignAll(amcData.results);
      _calculateAmcCounts();
      toast("AMC successfully Fetched");
      update();
    } catch (error) {
      toast(error.toString());
    } finally {
      customLoader.hide();
      isLoading.value = false;
    }
  }

  void _calculateAmcCounts() {
    if (amcResultData.isEmpty) return;

    int upcoming = 0;
    int renewal = 0;
    int completed = 0;

    for (var amc in amcResultData) {
      String status = amc.status?.toLowerCase() ?? '';

      switch (status) {
        case 'upcoming':
          upcoming++;
          break;
        case 'renewal':
          renewal++;
          break;
        case 'completed':
          completed++;
          break;
      }
    }

    upcomingCount.value = upcoming;
    renewalCount.value = renewal;
    completedCount.value = completed;
  }

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



}
