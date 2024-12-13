import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/customer_list_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class AddAmcViewController extends GetxController {
  RxBool isLoading = true.obs;
  List<Appointment> events = [];
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxList<CustomerData> customerListData = <CustomerData>[].obs;
  RxList<CustomerData> customerdefineData = <CustomerData>[].obs;

  // Observable values for amounts
  RxInt serviceAmount = 0.obs;
  RxInt receivedAmount = 0.obs;

  // Observable for selected time
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  final List<String> timeSlots = [
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00'
  ];

  // Display format for UI (12-hour format)
  List<String> get displayTimeSlots => timeSlots.map((timeSlot) {
    final parsedTime = DateFormat('HH:mm').parse(timeSlot);
    return DateFormat('hh:mm a').format(parsedTime);
  }).toList();

  final List<String> noOfServiceSelection = [
    "1",
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  final List<String> reminderList = [
    "Normal",
    "Extreme",
    "Both"
  ];

  final List<String> noOfServicesOccurances = [
    "Monthly",
    "Quarterly",
    "Yearly",
    "Half Month",
    "4 Months",
    "Weekly",
    "15 Days"
  ];

  // Controllers for text input
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
  late TextEditingController receivedAmountController;
  late TextEditingController customerNameController;
  late TextEditingController notesController;

  // Focus Nodes
  late FocusNode amcNameFocusNode;
  late FocusNode activationTimeFocusNode;
  late FocusNode datesFocusNode;
  late FocusNode noOfServiceFocusNode;
  late FocusNode reminderFocusNode;
  late FocusNode serviceOccurenceFocusNode;
  late FocusNode productNameFocusNode;
  late FocusNode productBrandFocusNode;
  late FocusNode serialModelFocusNode;
  late FocusNode serviceAmountFocusNode;
  late FocusNode receiveAmountFocusNode;
  late FocusNode customerNameFocusNode;
  late FocusNode notesFocusNode;

  RxInt selectedCustomerId = RxInt(0);

  @override
  void onInit() {
    super.onInit();

    // Initialize controllers
    amcNameController = TextEditingController();
    activationTimeController = TextEditingController();
    datesController = TextEditingController();
    noOfServiceController = TextEditingController();
    reminderController = TextEditingController();
    serviceOccurrenceController = TextEditingController();
    productNameController = TextEditingController();
    productBrandController = TextEditingController();
    serialModelNoController = TextEditingController();
    serviceAmountController = TextEditingController(text: '0');
    receivedAmountController = TextEditingController(text: '0');
    customerNameController = TextEditingController();
    notesController = TextEditingController();

    // Initialize focus nodes
    amcNameFocusNode = FocusNode();
    activationTimeFocusNode = FocusNode();
    datesFocusNode = FocusNode();
    noOfServiceFocusNode = FocusNode();
    reminderFocusNode = FocusNode();
    serviceOccurenceFocusNode = FocusNode();
    productNameFocusNode = FocusNode();
    productBrandFocusNode = FocusNode();
    serialModelFocusNode = FocusNode();
    serviceAmountFocusNode = FocusNode();
    receiveAmountFocusNode = FocusNode();
    customerNameFocusNode = FocusNode();
    notesFocusNode = FocusNode();
    hitGetCustomerListApiCall();
    fetchEvents();
  }

  void incrementServiceAmount() {
    serviceAmount.value++;
    serviceAmountController.text = serviceAmount.value.toString();
    update();
  }

  void decrementServiceAmount() {
    if (serviceAmount.value > 0) {
      serviceAmount.value--;
      serviceAmountController.text = serviceAmount.value.toString();
      update();
    }
  }

  void incrementReceivedAmount() {
    receivedAmount.value++;
    receivedAmountController.text = receivedAmount.value.toString();
    update();
  }

  void decrementReceivedAmount() {
    if (receivedAmount.value > 0) {
      receivedAmount.value--;
      receivedAmountController.text = receivedAmount.value.toString();
      update();
    }
  }

  // Method to show date picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
      datesController.text = DateFormat('yyyy-MM-dd').format(picked); // Correct format
      update();
    }
  }

  void hitGetCustomerListApiCall(){
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var parameterdata = {
      "role":"customer",
    };
    Get.find<AuthenticationApiService>().getCustomerListApiCall(parameters: parameterdata).then((value)async{
      customerListData.assignAll(value.results!);
      customerdefineData.assignAll(value.results!);
      List<String> customerIds = customerListData.map((agent) => agent.id.toString()).toList();
      await storage.write(customerId, customerIds.join(','));
      print('customer id : ${await storage.read(customerId)}');
      customLoader.hide();
      toast('Customer List Successfully Fetched');
      update();
    }).onError((error , stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitPostCreationAmcView(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    String formattedTime = _formatTimeFor24Hour(activationTimeController.text);
    var dataAmcCreation = {
      "amcName":amcNameController.text,
        "activationTime":activationTimeController.text,
        "activationDate":datesController.text,
        "no_of_service":noOfServiceController.text,
        "remainder":reminderController.text,
        "productBrand":productBrandController.text,
        "productName":productNameController.text,
        "serialModelNo":serialModelNoController.text,
        "underWarranty":true,
        "serviceAmount":serviceAmountController.text,
        "receivedAmount":receivedAmountController.text,
        "customer":selectedCustomerId.value,
        "select_service_occurence":serviceOccurrenceController.text,
        // "status":sta
        "note":notesController.text
    };
    Get.find<AuthenticationApiService>().postAmcDetailsApiCall(dataBody: dataAmcCreation).then((value){
      customLoader.hide();
      toast("Amc Added Succesffully");
      Get.offAllNamed(AppRoutes.amcScreen);
      update();
    }).onError((error, stackError){
      toast(error.toString());
      customLoader.hide();
      isLoading.value = false;
    });
  }

  // Method to show time picker dropdown
  void showTimePickerDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Time',style: MontserratStyles.montserratBoldTextStyle(size: 25, color: Colors.black),),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: timeSlots.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(timeSlots[index],style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.grey),),
                  onTap: () {
                    activationTimeController.text = timeSlots[index];
                    Navigator.pop(context);
                    update();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void noOfServicesDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Services',style: MontserratStyles.montserratBoldTextStyle(size: 25, color: Colors.black),),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: noOfServiceSelection.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(noOfServiceSelection[index],style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.grey),),
                  onTap: () {
                    noOfServiceController.text = noOfServiceSelection[index];
                    Navigator.pop(context);
                    update();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void reminderSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Reminder',style: MontserratStyles.montserratBoldTextStyle(size: 25, color: Colors.black),),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: reminderList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(reminderList[index], style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.grey),),
                  onTap: () {
                    reminderController.text = reminderList[index];
                    Navigator.pop(context);
                    update();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void servicesOccurances(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Reminder',style: MontserratStyles.montserratBoldTextStyle(size: 25, color: Colors.black),),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: noOfServicesOccurances.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(noOfServicesOccurances[index], style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.grey),),
                  onTap: () {
                    serviceOccurrenceController.text = noOfServicesOccurances[index];
                    Navigator.pop(context);
                    update();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void onClose() {
    // Dispose controllers
    amcNameController.dispose();
    activationTimeController.dispose();
    datesController.dispose();
    noOfServiceController.dispose();
    reminderController.dispose();
    serviceOccurrenceController.dispose();
    productNameController.dispose();
    productBrandController.dispose();
    serialModelNoController.dispose();
    receivedAmountController.dispose();
    customerNameController.dispose();
    notesController.dispose();

    // Dispose focus nodes
    amcNameFocusNode.dispose();
    activationTimeFocusNode.dispose();
    datesFocusNode.dispose();
    noOfServiceFocusNode.dispose();
    reminderFocusNode.dispose();
    serviceOccurenceFocusNode.dispose();
    productNameFocusNode.dispose();
    productBrandFocusNode.dispose();
    serialModelFocusNode.dispose();
    receiveAmountFocusNode.dispose();
    customerNameFocusNode.dispose();
    notesFocusNode.dispose();

    super.onClose();
  }

  void fetchEvents() {
    events = [
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 2)),
        subject: 'Sample AMC Event',
        notes: 'This is a sample event',
      ),
    ];
    update();
  }

  // Add new event
  void addEvent(Appointment newEvent) {
    events.add(newEvent);
    update();
  }
}
String _formatTimeFor24Hour(String timeString) {
  try {
    // If the time is already in 24-hour format
    if (timeString.contains(':') && !timeString.toLowerCase().contains('am') &&
        !timeString.toLowerCase().contains('pm')) {
      return timeString;
    }

    // Parse the time string and convert to 24-hour format
    final parsedTime = DateFormat('hh:mm a').parse(timeString);
    return DateFormat('HH:mm').format(parsedTime);
  } catch (e) {
    // Return a default time if parsing fails
    print('Error formatting time: $e');
    return '00:00';
  }
}