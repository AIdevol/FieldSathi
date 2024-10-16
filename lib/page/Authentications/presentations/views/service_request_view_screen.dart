import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
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
                    'Service Request',
                    style: MontserratStyles.montserratBoldTextStyle(
                        color: blackColor, size: 18),
                  ),
                  actions: [
                    IconButton(
                      icon: Obx(() =>
                          Icon(
                              controller.isSearching.value ? Icons.close : Icons
                                  .search)),
                      onPressed: () {
                        controller.toggleSearch();
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.download, size: 24, color: Colors.black,),
                      onPressed: () {
                        controller.hitdownloadExpenseServiceExcelSheetApiCall();
                      },
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
        return TextField(
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
        // Update the selected value in the controller
        controller.dropDownValue.value = newValue!;
      },
    );
  });
}

Widget _mainDataTable(BuildContext context, ServiceRequestScreenController controller) {
  int count = 0;
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
            DataColumn(label: Text('S No.')),
            DataColumn(label: Text('Ticket Id/Task Name')),
            DataColumn(label: Text('Customer Name')),
            DataColumn(label: Text('Sub Customer Name')),
            DataColumn(label: Text('Technician Name')),
            DataColumn(label: Text('Address')),
            DataColumn(label: Text('Materials Required')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Courier CNO.')),
            DataColumn(label: Text('Dockt No')),
            DataColumn(label: Text('Hub Address')),
            DataColumn(label: Text('Dispatched Location')),
            DataColumn(label: Text('Remark')),
            DataColumn(label: Text('Actions')),
          ],
          rows: controller.servicesRequestsData.map((request) {

            return DataRow(cells: [
              DataCell(Text("${count + 1}")),
              DataCell(Text(request.ticket.id.toString())),
              DataCell(Text(request.ticket.custName.toString())),
              DataCell(Text('${request.ticket.subCustomerDetails.firstName.toString()} ${request.ticket.subCustomerDetails.firstName.toString()}')),
              DataCell(Text(request.ticket.technicianName.toString())),
              DataCell(Text(request.ticket.ticketAddress.toString())),
              DataCell(Text(request.materialRequired.toString())),
              DataCell(Text(request.status)),
              DataCell(Text(request.courierContactNumber.toString())),
              DataCell(Text(request.docktNo.toString())),
              DataCell(Text(request.hubAddress.toString())),
              DataCell(Text(request.dispatchedRemark.toString())),
              DataCell(Text(' ')),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // controller.editRequest(request); // Implement edit functionality
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // controller.deleteRequest(); // Implement delete functionality
                    },
                  ),
                ],
              )),
            ]);
          }).toList(),
        );
      })
    ),
  );
}
