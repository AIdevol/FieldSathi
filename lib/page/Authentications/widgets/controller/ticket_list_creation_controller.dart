import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class TicketListCreationController extends GetxController {
  late TextEditingController taskNameController;
  late TextEditingController assignToController;
  late TextEditingController purposeController;
  late TextEditingController dateController;
  late TextEditingController customerNameController;
  late TextEditingController productNameController;
  late TextEditingController modelNoController;
  late TextEditingController fsrDetailsController;
  late TextEditingController serviceDetailsController;
  late TextEditingController instructionController;

  late FocusNode taskNameFocusNode;
  late FocusNode assignToFocusNode;
  late FocusNode purposeFocusNode;
  late FocusNode dateFocusNode;
  late FocusNode customerNameFocusNode;
  late FocusNode productNameFocusNode;
  late FocusNode modelNoFocusNode;
  late FocusNode fsrDetailsFocusNode;
  late FocusNode serviceDetailsFocusNode;
  late FocusNode instructionFocusNode;

  FocusNode focusNode = FocusNode();
  RxBool isFocused = false.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  bool isAmcSelected = false;
  bool isRateSelected = false;

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
    taskNameController = TextEditingController();
    assignToController = TextEditingController();
    purposeController = TextEditingController();
    dateController = TextEditingController();
    customerNameController = TextEditingController();
    productNameController =TextEditingController();
    modelNoController = TextEditingController();
    fsrDetailsController = TextEditingController();
    serviceDetailsController = TextEditingController();
    instructionController = TextEditingController();

    taskNameFocusNode = FocusNode();
    assignToFocusNode = FocusNode();
    purposeFocusNode = FocusNode();
    dateFocusNode = FocusNode();
    customerNameFocusNode = FocusNode();
    productNameFocusNode = FocusNode();
    modelNoFocusNode = FocusNode();
    fsrDetailsFocusNode = FocusNode();
    serviceDetailsFocusNode = FocusNode();
    instructionFocusNode = FocusNode();
    super.onInit();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    taskNameController.dispose();
    assignToController.dispose();
    purposeController.dispose();
    dateController.dispose();
    customerNameController.dispose();
    productNameController.dispose();
    modelNoController.dispose();
    fsrDetailsController.dispose();
    serviceDetailsController.dispose();
    instructionController.dispose();

    taskNameFocusNode.dispose();
    assignToFocusNode.dispose();
    purposeFocusNode.dispose();
    dateFocusNode.dispose();
    customerNameFocusNode.dispose();
    productNameFocusNode.dispose();
    modelNoFocusNode.dispose();
    fsrDetailsFocusNode.dispose();
    serviceDetailsFocusNode.dispose();
    instructionFocusNode.dispose();
    focusNode.dispose();
    dateController.dispose();
    super.dispose();
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

  void hitAddTicketApiCall(){
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var ticketData = {
     ""
    };
    Get.find<AuthenticationApiService>().postTicketDetailsApiCall().then((value){
      customLoader.hide();
      toast("Ticket have been added");
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }
}