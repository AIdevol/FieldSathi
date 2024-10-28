import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddAmcViewController extends GetxController {
  // List of AMC events
  List<Appointment> events = [];
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Observable values for amounts
  RxInt serviceAmount = 0.obs;
  RxInt receivedAmount = 0.obs;

  // Observable for selected time
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  // Predefined time slots
  final List<String> timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM'
  ];
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
              primary: Colors.blue, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Calendar text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
      datesController.text = DateFormat('dd-MMM-yyyy').format(picked);
      update();
    }
  }

  // Method to show time picker dropdown
  void showTimePickerDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Time'),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: timeSlots.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(timeSlots[index]),
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
          title: Text('Select Time'),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: noOfServiceSelection.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(noOfServiceSelection[index]),
                  onTap: () {
                    activationTimeController.text = noOfServiceSelection[index];
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