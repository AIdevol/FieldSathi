import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/service_request_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class ServiceRequestViewScreen extends GetView<ServiceRequestScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<ServiceRequestScreenController>(
          builder: (controller) =>
              Scaffold(
                appBar: AppBar(
                  backgroundColor: appColor,
                  title: Text(
                    'Material Requests',
                    style: MontserratStyles.montserratBoldTextStyle(
                        color: blackColor, size: 18),
                  ),
                  actions: [
                    // IconButton(
                    //   icon: Obx(() =>
                    //       Icon(
                    //           controller.isSearching.value ? Icons.close : Icons
                    //               .search)),
                    //   onPressed: () {
                    //     controller.toggleSearch();
                    //   },
                    // ),
                    IconButton(
                      icon: Icon(
                        Icons.download, size: 24, color: Colors.black,),
                      onPressed: () => downloadFilterData(controller)
                    ),
                  ],
                ),
                body: _mainScreen(controller, context),
              ),
        ),
      ),
    );
  }
}

Widget _mainScreen(ServiceRequestScreenController controller, BuildContext context) {
  return ListView(
    children: [
      _viewTopBar(controller, context),
      vGap(20),
      _mainDataTable(context, controller),
    ],
  );
}

Widget _viewTopBar(ServiceRequestScreenController controller, BuildContext context) {
  return Container(
    height: Get.height * 0.07,
    width: Get.width,
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: _buildSearchField(controller)),
        hGap(10),
        Expanded(child: _buildSelectStatusField(controller)),
        hGap(10),
      ],
    ),
  );
}

Widget _buildSearchField(ServiceRequestScreenController controller) {
  return Container(
    height: Get.height * 0.05,
    margin: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        width: 1,
        color: Colors.grey,
      ),
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(FeatherIcons.search, color: Colors.grey),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
      ),
      style: MontserratStyles.montserratSemiBoldTextStyle(
        color: Colors.black,
      ),
      onChanged: (value) {
        controller.updateSearch(value); // Update search functionality
      },
    ),
  );
}

Widget _buildSelectStatusField(ServiceRequestScreenController controller) {
  return Container(
    height: Get.height * 0.05,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        width: 1,
        color: Colors.grey,
      ),
    ),
    child: GestureDetector(
      onTap: () {
        // Open the dropdown when the TextField is tapped
        showModalBottomSheet(
          context: Get.context!,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              child: ListView.builder(
                itemCount: controller.selecteValue.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.selecteValue[index]),
                    onTap: () {
                      // Update the selected value in the controller
                      controller.dropDownValue.value = controller.selecteValue[index];
                      // Close the bottom sheet after selection
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            );
          },
        );
      },
      child: Obx(() {
        return InkWell(
          onTap: (){_dropDownValue(controller);},
          child: TextField(
            readOnly: true, // Disable manual text input
            decoration: InputDecoration(
              hintText: "--Please Select Status--",
              hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
                color: Colors.grey,
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 24,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: Colors.black,
            ),
            controller: TextEditingController(
              text: controller.dropDownValue.value, // Show the selected status
            ),
          ),
        );
      }),
    ),
  );
}


Widget _dropDownValue(ServiceRequestScreenController controller) {
  return Obx(() {
    return DropdownButton<String>(
      value: controller.dropDownValue.value, // Current selected value
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: controller.selecteValue.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        controller.dropDownValue.value = newValue!;
      },
    );
  });
}

Widget _mainDataTable(BuildContext context, ServiceRequestScreenController controller) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx((){
        return DataTable(
          border: TableBorder(
            horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
          ),
          columnSpacing: 20,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            return Colors.grey.shade100;
          }),
          columns: const [
            DataColumn(label: Center(child: Text('S No.'))),
            DataColumn(label: Center(child: Text('Ticket Id'))),
            DataColumn(label: Center(child: Text('Task Name'))),
            DataColumn(label: Center(child: Text('Customer Name'))),
            DataColumn(label: Center(child: Text('Sub Customer Name'))),
            DataColumn(label: Center(child: Text('Technician Name'))),
            DataColumn(label: Center(child: Text('Address'))),
            DataColumn(label: Center(child: Text('Materials Required'))),
            DataColumn(label: Center(child: Text('Status'))),
            DataColumn(label: Center(child: Text('Courier CNO.'))),
            DataColumn(label: Center(child: Text('Dockt No'))),
            DataColumn(label: Center(child: Text('Hub Address'))),
            DataColumn(label: Center(child: Text('Dispatched Location'))),
            DataColumn(label: Center(child: Text('Remark'))),
            DataColumn(label: Center(child: Text('  '))),
          ],
          rows: controller.servicesRequestsData.asMap().entries.map((entry) {
            final index = entry.key;
            final request = entry.value;

            return DataRow(cells: [
              DataCell(Center(child: Text("${index + 1}"))),
              DataCell(_ticketBoxIcons(request.ticket.id.toString())/*request.ticket.id.toString()*/),
              DataCell(Center(child: Text( request.ticket.taskName.toString()))),
              DataCell(Center(child: Text("${request.ticket.customerDetails.customerName.toString()}"))),
              DataCell(Center(child: Text("${request.ticket.subCustomerDetails.firstName.toString()}${request.ticket.subCustomerDetails.lastName.toString()}".isNotEmpty ? "${request.ticket.subCustomerDetails.firstName.toString()}${request.ticket.subCustomerDetails.lastName.toString()}":'NA'))),
              DataCell(Center(child: Text("${request.ticket.assignTo.firstName.toString()}${request.ticket.assignTo.lastName.toString()}"))),
              DataCell(Center(child: Text("${request.ticket.ticketAddress.city.toString()},${request.ticket.ticketAddress.state.toString()},${request.ticket.ticketAddress.country.toString()}"))),
              DataCell(Text(request.materialRequired.toString().isNotEmpty ? request.materialRequired.toString() : "No Materials")),
              DataCell(Center(child: Text(request.status.toString()))),
              DataCell(Center(child: Text(request.courierContactNumber.toString()))),
              DataCell(Center(child: Text(request.docktNo.toString()))),
              DataCell(Center(child: Text(request.hubAddress.toString()))),
              DataCell(Center(child: _remarkViewsWidget(controller, request.whereToDispatched.toString()),)/*Text(request.dispatchedRemark.toString())*/),
              DataCell(Center(child: Text(request.dispatchedRemark.toString()))),
              DataCell(Center(child: _addTicketViewButton(controller,request.status.toString()),)),
            ]);
          }).toList(),
        );
      })
    ),
  );
}
Widget _ticketBoxIcons(String? ticketId) {
  return Center(
    child:
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: normalBlue,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.blue.shade300,
              width: 1,
            ),
          ),
          child: Text(
            "${ticketId}".isNotEmpty == true ? ticketId! : 'NA',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
    );
}

_remarkViewsWidget(ServiceRequestScreenController controller, String? remark){
  if (remark != null && remark.isNotEmpty){
    return Text(remark);
  }else{
    Text("None");
  }
}

_addTicketViewButton(ServiceRequestScreenController controller, String? status) {
  return  ElevatedButton(onPressed: () =>updateFilterStatusData(controller, status),
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        minimumSize: Size(130, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Update Status",style: MontserratStyles.montserratBoldTextStyle(
        color: whiteColor,
        size: 13,)));
}

void updateFilterStatusData(ServiceRequestScreenController controller, String? status){
  Get.dialog(
    Dialog(child: _statusSelectUpdateWidget(controller, status),)
  );
}

Widget _statusSelectUpdateWidget(ServiceRequestScreenController controller, String? status) {
  return Container(
    height: Get.height * 0.35,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Update Status",
              style: MontserratStyles.montserratBoldTextStyle(
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 18.0),
          // Text("Status", style: MontserratStyles.montserratBoldTextStyle(
          //   color: blackColor,
          //   size: 15,
          // ),),
          // const SizedBox(height: 10.0),
          TextField(
            readOnly: true,
            controller: controller.statusController,
            decoration: InputDecoration(
              labelText: "Select Status",
              hintText: "Select Status",
              suffixIcon:
            //     DropdownButton(
            //         value: controller.selectedValue.value,
            //         items:  controller.selecteValue.map((String value) {
            //   return DropdownMenuItem<dynamic>(
            //     value: value,
            //     child: Text(value),
            //   );
            // }).toList(), onChanged: (String? newValue) {  },
              IconButton(
                icon: Icon(Icons.arrow_drop_down, color: darkBlue3),
                onPressed: () {
                  controller.selectedValue.value;
                },
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text(
                  "Cancel",
                  style: MontserratStyles.montserratBoldTextStyle(
                    color: whiteColor,
                    size: 13,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor,
                  minimumSize: const Size(130, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Update",
                  style: MontserratStyles.montserratBoldTextStyle(
                    color: whiteColor,
                    size: 13,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor,
                  minimumSize: const Size(130, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
// Widget _statusSelectUpdateWidget(ServiceRequestScreenController controller, String? status) {
//   return Container(
//     height: Get.height * 0.35,
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Text(
//               "Update Status",
//               style: MontserratStyles.montserratBoldTextStyle(
//                 color: Colors.black,
//                 size: 20,
//               ),
//             ),
//           ),
//           const SizedBox(height: 18.0),
//           DropdownButtonFormField<String>(
//             value: controller.dropDownValue.value,
//             items: controller.selecteValue.map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               controller.dropDownValue.value = newValue!;
//               // Show the appropriate widget based on the selected status
//               if (newValue == "Submitted") {
//                 // Show the "Approved Remark" widget
//                 Get.dialog(
//                   Dialog(
//                     child: _approvedStatusWidget(controller),
//                   ),
//                 );
//               } else if (newValue == "Dispatched") {
//                 // Show the "Dispatched" widget
//                 Get.dialog(
//                   Dialog(
//                     child: _dispatchedStatusWidget(controller),
//                   ),
//                 );
//               } else if (newValue == "Approved") {
//                 // Show the "Approved" widget
//                 Get.dialog(
//                   Dialog(
//                     child: _approvedStatusWidget(controller),
//                   ),
//                 );
//               }
//             },
//             decoration: InputDecoration(
//               labelText: "Select Status",
//               hintText: "Select Status",
//             ),
//           ),
//           const SizedBox(height: 24.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: MontserratStyles.montserratBoldTextStyle(
//                     color: whiteColor,
//                     size: 13,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: appColor,
//                   minimumSize: const Size(130, 40),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Implement the update status logic here
//                   String selectedStatus = controller.dropDownValue.value;
//                   if (selectedStatus == "Submitted") {
//                     // Update the status to "Approved"
//                     // controller.updateStatusToApproved();
//                   } else if (selectedStatus == "Dispatched") {
//                     // Update the status to "Dispatched"
//                     // controller.updateStatusToDispatched();
//                   } else if (selectedStatus == "Approved") {
//                     // Update the status to "Approved"
//                     // controller.updateStatusToApproved();
//                   }
//                   Get.back();
//                 },
//                 child: Text(
//                   "Update",
//                   style: MontserratStyles.montserratBoldTextStyle(
//                     color: whiteColor,
//                     size: 13,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: appColor,
//                   minimumSize: const Size(130, 40),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// Widget _approvedStatusWidget(ServiceRequestScreenController controller) {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Approved Remark",
//           style: MontserratStyles.montserratBoldTextStyle(
//             color: Colors.black,
//             size: 16,
//           ),
//         ),
//         const SizedBox(height: 10.0),
//         TextField(
//           controller: controller.approvedController,
//           decoration: InputDecoration(
//             hintText: "Enter approved remark",
//             border: OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 24.0),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: Text(
//                 "Cancel",
//                 style: MontserratStyles.montserratBoldTextStyle(
//                   color: whiteColor,
//                   size: 13,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: appColor,
//                 minimumSize: const Size(130, 40),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement the "Approve" logic here
//                 // controller.updateStatusToApproved();
//                 Get.back();
//               },
//               child: Text(
//                 "Approve",
//                 style: MontserratStyles.montserratBoldTextStyle(
//                   color: whiteColor,
//                   size: 13,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: appColor,
//                 minimumSize: const Size(130, 40),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _dispatchedStatusWidget(ServiceRequestScreenController controller) {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Dispatched Details",
//           style: MontserratStyles.montserratBoldTextStyle(
//             color: Colors.black,
//             size: 16,
//           ),
//         ),
//         const SizedBox(height: 10.0),
//         TextField(
//           controller: controller.courierContactNumberController,
//           decoration: InputDecoration(
//             hintText: "Enter courier contact number",
//             border: OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 20.0),
//         TextField(
//           controller: controller.docktNoController,
//           decoration: InputDecoration(
//             hintText: "Enter docket number",
//             border: OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 20.0),
//         TextField(
//           controller: controller.hubAddressController,
//           decoration: InputDecoration(
//             hintText: "Enter hub address",
//             border: OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 20.0),
//         TextField(
//           controller: controller.whereToDispatchedController,
//           decoration: InputDecoration(
//             hintText: "Enter where to dispatched",
//             border: OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 20.0),
//         TextField(
//           controller: controller.remarkController,
//           decoration: InputDecoration(
//             hintText: "Enter remark",
//             border: OutlineInputBorder(),
//           ),
//         ),
//         const SizedBox(height: 24.0),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: Text(
//                 "Cancel",
//                 style: MontserratStyles.montserratBoldTextStyle(
//                   color: whiteColor,
//                   size: 13,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: appColor,
//                 minimumSize: const Size(130, 40),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement the "Dispatch" logic here
//                 // controller.updateStatusToDispatched();
//                 Get.back();
//               },
//               child: Text(
//                 "Dispatch",
//                 style: MontserratStyles.montserratBoldTextStyle(
//                   color: whiteColor,
//                   size: 13,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: appColor,
//                 minimumSize: const Size(130, 40),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

void downloadFilterData(ServiceRequestScreenController controller) {
  Get.dialog(
    Dialog(
      child: DateRangeDialog(),
    ),
  );
}

class DateRangeDialog extends StatefulWidget {
  @override
  _DateRangeDialogState createState() => _DateRangeDialogState();
}

class _DateRangeDialogState extends State<DateRangeDialog> {
  DateTime? startDate;
  DateTime? endDate;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Text("Select Date Range", style: MontserratStyles.montserratSemiBoldTextStyle(size: 18, color: Colors.black),),
          SizedBox(height: 16),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              // labelText: "Start Date",
              hintText: startDate != null ? dateFormat.format(startDate!) : "Select Start Date",
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today, color: appColor,),
                onPressed: () => _selectDate(context, true),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("To", style: MontserratStyles.montserratSemiBoldTextStyle(size: 16, color: Colors.black),),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              // labelText: "End Date",
              hintText: endDate != null ? dateFormat.format(endDate!) : "Select End Date",
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today, color: appColor,),
                onPressed: () => _selectDate(context, false),
              ),
            ),
          ),
          SizedBox(height: 24),
        ElevatedButton(onPressed: () {
          if (startDate != null && endDate != null) {
            Get.back();
          } else {
            toast("Please select both start and end dates.");
          }
        },
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
              minimumSize: Size(130, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text("Confirm",style: MontserratStyles.montserratBoldTextStyle(
              color: whiteColor,
              size: 13,)))
        ],
      ),
    );
  }
}


// Widget _approvedStatusWidget(ServiceRequestScreenController controller){
//   return TextField(
//     controller: controller.approvedController,
//     decoration: InputDecoration(
//       labelText: "Approved Remark",
//       hintText: "Approved Remark",
//       // suffixIcon: IconButton(
//       //   icon: Icon(Icons.arrow_drop_down, color: darkBlue3),
//       //   onPressed: () {
//       //     // controller.hitUpdateStatusApiCall(status);
//       //   },
//       // ),
//     ),
//   );
// }
//
// Widget _dispatchedStatusWidget(ServiceRequestScreenController controller){
//   return ListView(
//     children: [
//       TextField(
//         controller: controller.courierContactNumberController,
//         decoration: InputDecoration(
//           labelText: "Courier Contact Number",
//           hintText: "Courier Contact Number",
//         ),
//       ),
//       vGap(20),
//       TextField(
//       controller: controller.docktNoController,
//       decoration: InputDecoration(
//         labelText: "Dockt No",
//         hintText: "Dockt No",
//         // suffixIcon: IconButton(
//         //   icon: Icon(Icons.arrow_drop_down, color: darkBlue3),
//         //   onPressed: () {
//         //     // controller.hitUpdateStatusApiCall(status);
//         //   },
//         // ),
//       ),
//     ),
//       vGap(20),
//       TextField(
//         controller: controller.hubAddressController,
//         decoration: InputDecoration(
//           labelText: "Hub Address",
//           hintText: "Hub Address",
//         ),
//       ),
//       vGap(20),
//       TextField(
//         controller: controller.whereToDispatchedController,
//         decoration: InputDecoration(
//           labelText: "Where to Dispatched",
//           hintText: "Where to Dispatched",
//         ),
//       ),
//       vGap(20),
//       TextField(
//         controller: controller.remarkController,
//         decoration: InputDecoration(
//           labelText: "Remark",
//           hintText: "Remark",
//         ),
//       ),
//
//     ]
//   );
// }
