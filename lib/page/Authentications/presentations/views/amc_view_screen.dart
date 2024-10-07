import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/amc_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_amc_view_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../../widgets/views/add_amc_view_screen.dart';

class AMCViewScreen extends GetView<AMCScreenController> {
  // Ensure the controller is initialized
  @override
  final AMCScreenController controller = Get.put(AMCScreenController());

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
        child: GetBuilder<AMCScreenController>(builder: (controller) =>
            SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: appColor,
                  title: Text(
                    'AMC',
                    style: MontserratStyles.montserratBoldTextStyle(
                      color: blackColor,
                      size: 15,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.addAmcCallenderScreen);
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.createamcScreen);
                      },
                      icon: Icon(FeatherIcons.plus),
                    ).paddingSymmetric(horizontal: 20.0),
                  ],
                ),
                body: Column(
                  children: [
                    _buildTopBar(),
                    vGap(10),
                    _mainData(),
                    vGap(10),
                    _dataTableViewScreen(),
                  ],
                )
               /* controller.isLoading.value
                    ? Center(child: CircularProgressIndicator(),)
                    : Column(
                  children: [
                    _buildTopBar(),
                    vGap(10),
                    _mainData(),
                    vGap(10),
                    _dataTableViewScreen(),
                  ],
                ),*/
              ),
            ),)
    );
  }

  Widget _mainData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200, // Consider making this responsive
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _totalAmcWidget(),
            hGap(20),
            _totalUpcomingWidget(),
            hGap(20),
            _totalRenewalWidget(),
            hGap(20),
            _totalCompletedWidget(),

          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
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
          // controller.updateSearch(value); // Implement this method in your controller
        },
      ),
    );
  }

  Widget _totalAmcWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total AMC',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
            Text(
              '0',
              // controller.totalAmc.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalUpcomingWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.greenAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upcoming',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
            Text(
              '0',
              // controller.totalUpcoming.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalRenewalWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Renewal',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
            Text(
              '',
              // controller.totalRenewal.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalCompletedWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.redAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Completed',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
            Text(
              '0',
              // controller.totalCompleted.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
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
          Expanded(child: _buildSearchField()),
          hGap(10),
          ElevatedButton(
            onPressed: () => _showImportModelView(),
            style: _buttonStyle(),
            child: Text(
              'Import',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
          ),
          hGap(10),
          ElevatedButton(
            onPressed: () {
              // controller.exportData(); // Implement this method in your controller
            },
            child: Text(
              'Export',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
            style: _buttonStyle(),
          ),
          hGap(10),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: appColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black.withOpacity(0.5),
    );
  }

  void _showImportModelView() {
    Get.dialog(
      AlertDialog(
        title: Text('Import File'),
        content: SizedBox(
          height: Get.height * 0.2,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file, size: 60, color: appColor),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles();
                  if (result != null) {
                    String fileName = result.files.single.name;
                    // controller.importFile(result); // Handle the file in controller
                    Get.snackbar('File Selected', 'You selected: $fileName');
                    Get.back(); // Close the dialog
                  }
                },
                child: Text('Select File from Local'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: appColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _dataTableViewScreen() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() =>
          DataTable(columns: [
            DataColumn(label: Text('AMC ID/Name')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Customer Name')),
            DataColumn(label: Text('Services')),
            DataColumn(label: Text('Service Amount')),
            DataColumn(label: Text('Service Occurrence')),
            DataColumn(label: Text('Remaining Amount')),
            DataColumn(label: Text('Remainder')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text(' ')),
            DataColumn(label: Text(' ')),
            DataColumn(label: Text(' ')),
          ], rows: controller.amcData.map((amc) {
            return DataRow(cells: [
              DataCell(Text(amc.id.toString())),
              DataCell(Text(amc.activationDate ?? 'N/A')),
              DataCell(Text(amc.amcName ?? 'N/A')),
              DataCell(Text(amc.customer!.customerName ?? 'N/A')),
              DataCell(Text('${amc.serviceCompleted ?? 'N/A'}'+'${'/'}'+'${amc.createdBy ?? 'N/A'}')),
              DataCell(Text(amc.serviceAmount.toString())),
              DataCell(Text(amc.selectServiceOccurrence ?? 'N/A')),
              DataCell(Text(amc.remainingAmount.toString())),
              DataCell(Text(amc.remainder ?? 'N/A')),
              DataCell(Text(amc.status ?? 'N/A')),
              DataCell( _dropDownValueViews(controller)
                  /*IconButton(onPressed: () {_dropDownValueViews(controller);}, icon: Icon(Icons.more_vert))*/),
              DataCell(_viewDetailsButton(controller)),
              DataCell(_addTicketViewButton(controller)),
            ]);
          }).toList())),
    );
  }


  _viewDetailsButton(AMCScreenController controller) {
    return ElevatedButton(onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor,
          minimumSize: Size(130, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text("View Details",style: MontserratStyles.montserratBoldTextStyle(
    color: whiteColor,
    size: 13,)));
  }

  _addTicketViewButton(AMCScreenController controller) {
    return ElevatedButton(onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor,
          minimumSize: Size(130, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text("Add Ticket",style: MontserratStyles.montserratBoldTextStyle(
    color: whiteColor,
    size: 13,)));
  }
}

_dropDownValueViews(AMCScreenController controller){
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child:  PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (String result) {
          switch (result) {
            case 'Edit':
            // Handle edit action
              print('Edit selected');
              break;
            case 'Delete':
            // Handle delete action
              print('Delete selected');
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
           PopupMenuItem<String>(
            value: 'Edit',
            child: ListTile(
              leading: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.black),
              title: Text('Edit',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,)),
            ),
          ),
           PopupMenuItem<String>(
            value: 'Delete',
            child: ListTile(
              leading: Icon(Icons.delete, size: 20, color: Colors.red),
              title: Text('Delete',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,),
            ),
          ),
           ),
        ],
      ),
    ),
  );
}