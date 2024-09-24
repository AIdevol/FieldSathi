import 'package:get/get.dart';

import '../views/ticket_list_screen.dart';

class TicketListViewScreenController extends GetxController {

  List<String> filterType = [
    "Select By",
    "Task Name",
    "Customer Name",
    "Sub-Customer Name",
    "Technician Name",
    "Status",
    "Region"
  ].obs;

  RxString dropDownValue = "Select By".obs;

  List<Ticket> tickets = [
    Ticket(
      id: 1,
      Cutstomer_Name: 'John Doe',
      Subcutstomer_Name: 'ABC Corp',
      Technician_Name: 'Jane Smith',
      Start_Datetime: '2023-09-20 09:00',
      End_DateTime: '2023-09-20 11:00',
      Time: '2 hours',
      Address: '123 Main St',
      Region: 'North',
      Purpose: 'Maintenance',
      Ticket_Date: '2023-09-19',
      Aging: '1 day',
      status: 'Open',
    ),
     Ticket(
    id: 2,
    Cutstomer_Name: 'Malaika Arora',
    Subcutstomer_Name: 'ABC Corp',
    Technician_Name: 'Jane Smith',
    Start_Datetime: '2023-09-20 09:00',
    End_DateTime: '2023-09-20 11:00',
    Time: '2 hours',
    Address: '123 Main St',
    Region: 'North',
    Purpose: 'Maintenance',
    Ticket_Date: '2023-09-19',
    Aging: '1 day',
    status: 'Open',
    ),
    // Add more sample data as needed
  ];

  void updateDropDownValue(String? newValue) {
    if (newValue != null) {
      dropDownValue.value = newValue;
    }
  }

// You can add more methods here as needed, such as:
// void fetchTickets() async {
//   // Fetch tickets from an API or database
//   // Update the tickets list
//   update();
// }

// void filterTickets(String filterCriteria) {
//   // Implement filtering logic based on the selected criteria
//   // Update the tickets list
//   update();
// }
}
