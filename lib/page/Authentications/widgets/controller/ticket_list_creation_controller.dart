import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TicketListController extends GetxController {
  FocusNode focusNode = FocusNode();
  RxBool isFocused = false.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  TextEditingController dateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
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
}
