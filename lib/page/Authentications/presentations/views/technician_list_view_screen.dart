import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/technician_list_view_screen_controller.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class TechnicianListViewScreen extends GetView<TechnicianListViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<TechnicianListViewScreenController>(
        builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            title: Text(
              "Technician Lists",
              style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),
            ),
            actions: [
              IconButton(onPressed: () => controller.refreshList(), icon: Icon(FontAwesomeIcons.refresh)),
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.addtechnicianListScreen);
                },
                icon: Icon(FontAwesomeIcons.plus),
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(controller),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => controller.refreshList(),
                    child: ListView.builder(
                      itemCount: controller.filteredTechnicians.length,
                      itemBuilder: (context, index) {
                        final technician = controller.filteredTechnicians[index];
                        return ListTile(
                          title: Text(technician.name),
                          subtitle: Text(technician.specialization),
                          trailing: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () => controller.showTechnicianOptions(technician),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(TechnicianListViewScreenController controller) {
    return Container(
      height: Get.height * 0.12,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _searchViewWidget(controller),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: _actionButton('Import', () => controller.importTechnicians()),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: _actionButton('Export', () => controller.exportTechnicians()),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
        ),
      ),
    );
  }

  Widget _searchViewWidget(TechnicianListViewScreenController controller) {
    return CustomTextField(
      hintText: "Search technicians...",
      prefix: Icon(Icons.search, color: Colors.grey),
      onTap: () => controller.searchTechnicians,
      controller: controller.searchController,
    );
  }



  Widget _buildLeavesDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder(
            horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
          ),
          columnSpacing: 20,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            return Colors.grey.shade100;
          }),
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Contact Number')),
            DataColumn(label: Text('Data of Joining')),
            DataColumn(label: Text('Check in Time')),
            DataColumn(label: Text('Check out Time')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Battery Status')),
            DataColumn(label: Text('GPS Status')),
          ],
          rows: controller.filteredLeaves.map((leave) {
            return DataRow(
              cells: [
                DataCell(Text('${leave.userId.firstName} ${leave.userId.lastName}')),
                DataCell(Text(leave.userId.phoneNumber)),
                DataCell(Text(leave.userId.role)),
                // DataCell(Text(controller.formatDate(leave.startDate))),
                // DataCell(Text(controller.formatDate(leave.endDate))),
                // DataCell(Text(controller.calculateDays(leave.startDate, leave.endDate).toString())),
                DataCell(Text(leave.reason)),
                DataCell(Text(leave.status)),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {} /*controller.showLeaveDetails(leave)*/,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
