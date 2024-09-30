import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/super_view_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class SuperViewScreen extends GetView<SuperViewScreenController>{
  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<SuperViewScreenController>(builder: (controller)=>Scaffold(
      appBar: AppBar(
        title: Text("Super User", style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),
        backgroundColor: appColor,
        actions: [IconButton(onPressed: (){}, icon: Icon(FeatherIcons.search)),
          IconButton(onPressed: (){}, icon: Icon(FeatherIcons.plus))],
      ),
      body: Column(
        children: [
          _buildTopBar(controller),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? Center(child: Container())
                : _mainData(controller)),
          ),
        ],
      ),
    )));
  }
  Widget _buildTopBar(SuperViewScreenController controller) {
    return Container(
      height: Get.height * 0.09,
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
          // _buildSearchBar(controller),
          hGap(10),
          ElevatedButton(
            onPressed: () => _showImportModelView(Get.context!),
            style: _buttonStyle(),
            child: Text(
              'Import',
              style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
            ),
          ),
          hGap(30),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Export',
              style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
            ),
            style: _buttonStyle(),
          ),
          hGap(10),
        ],
      ),
    );
  }
  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(appColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
      elevation: WidgetStateProperty.all(5),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)),
    );
  }
}

Widget _mainData(SuperViewScreenController controller){
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child:  DataTable(columns: const[
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Email')),
      DataColumn(label: Text('Contact Number')),
      DataColumn(label: Text('Status')),
      // DataColumn(label: Text('To Date')),
      // DataColumn(label: Text('Days')),
      // DataColumn(label: Text('Reason')),
      // DataColumn(label: Text('Status')),
      // DataColumn(label: Text('Actions')),
    ], rows: controller.filteredData.map((superData){
        return DataRow(cells: [
          DataCell(Text("kadlfjasf")),
          DataCell(Text("adfadsf")),
          DataCell(Text("dfadsf")),
          DataCell(Text("adsfasdf"))
        ],
        );
    }).toList()
    ),
  );
  //   return SingleChildScrollView(
  //   scrollDirection: Axis.horizontal,
  //   child: DataTable(
  //     columns:const [
  //       DataColumn(label: Text('Name')),
  //       DataColumn(label: Text('Phone')),
  //       DataColumn(label: Text('Profile')),
  //       DataColumn(label: Text('From Date')),
  //       DataColumn(label: Text('To Date')),
  //       DataColumn(label: Text('Days')),
  //       DataColumn(label: Text('Reason')),
  //       DataColumn(label: Text('Status')),
  //       DataColumn(label: Text('Actions')),
  //     ],
  //     rows: controller.filteredLeaves.map((leave) {
  //       return DataRow(
  //         cells: [
  //           DataCell(Text('${leave.userId.firstName} ${leave.userId.lastName}')),
  //           DataCell(Text(leave.userId.phoneNumber)),
  //           DataCell(Text(leave.userId.role)),
  //           // DataCell(Text(controller.formatDate(leave.startDate))),
  //           // DataCell(Text(controller.formatDate(leave.endDate))),
  //           // DataCell(Text(controller.calculateDays(leave.startDate, leave.endDate).toString())),
  //           DataCell(Text(leave.reason)),
  //           DataCell(Text(leave.status)),
  //           DataCell(
  //             IconButton(
  //               icon: Icon(Icons.info),
  //               onPressed: () =>/* controller.showLeaveDetails(leave)*/,
  //             ),
  //           ),
  //         ],
  //       );
  //     }).toList(),
  //   ),
  // );
}

void _showImportModelView(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Import File'),
        content: Container(
          height: Get.height * 0.2,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file, size: 60, color: appColor),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    String fileName = result.files.single.name;
                    Get.snackbar('File Selected', 'You selected: $fileName');
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Select File from Local'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: appColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
