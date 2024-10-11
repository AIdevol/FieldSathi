import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/lead_list_view_controller.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class LeadListViewScreen extends GetView<LeadListViewController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<LeadListViewController>(
        builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            title: Text(
              'Lead List',
              style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.leadFormFieldScreen);
                },
                icon: Icon(FeatherIcons.plus, size: 24, color: Colors.black),
              ).paddingSymmetric(horizontal: 20.0)
            ],
          ),
          body: Column(
            children: [
              _buildTopBar(controller),
              Expanded(
                child: _mainDataAnalytics(controller, context),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(LeadListViewController controller) {
    return Container(
      height: Get.height * 0.08,
      width: Get.width,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: _buildSearchField(controller)),
          _buildButton('Import', () => _showImportModelView(Get.context!)),
          hGap(10),
          _buildButton('Export', () {}),
          hGap(10),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: whiteColor,
        backgroundColor: appColor,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
      child: Text(
        text,
        style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 14),
      ),
    );
  }

  Widget _mainDataAnalytics(LeadListViewController controller, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          vGap(20),
          _buildHorizontalScrollableContainers(controller),
          vGap(20),
           _dataTableViewScreen(controller: controller,context: context),
        ],
      ),
    );
  }

  Widget _buildHorizontalScrollableContainers(LeadListViewController controller) {
    return Container(
      height: Get.height * 0.2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        children: [
          _buildAnalyticsContainer('Inactive', '0', Colors.blue.shade300),
          _buildAnalyticsContainer('In-Discussion', '0', Colors.red.shade200),
          _buildAnalyticsContainer('Quote Sent', '0', lightBlue),
          _buildAnalyticsContainer('Service Taken', '0', lighthardGreen),
          // vGap(10),
          _buildAnalyticsContainer('Not Interested', '0', lightcream),
          // vGap(10),

        ],
      ),
    );
  }

  Widget _buildSearchField(LeadListViewController controller) {
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
          // Implement search functionality
        },
      ),
    );
  }
  
  Widget _buildAnalyticsContainer(String title, String value, Color color) {
    return Container(
      height: Get.height * 0.15,
      width: Get.width * 0.4,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: MontserratStyles.montserratBoldTextStyle(size: 16, color: Colors.white),
          ),
          vGap(10),
          Text(
            value,
            style: MontserratStyles.montserratBoldTextStyle(size: 24, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

_dataTableViewScreen({required LeadListViewController controller, required BuildContext context}){
  return Obx((){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columns: [
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Source')),
        DataColumn(label: Text('Since')),
        DataColumn(label: Text('Mobile No.')),
        DataColumn(label: Text('Address')),
        DataColumn(label: Text('Next Update')),
        DataColumn(label: Text('Lead Status')),
        DataColumn(label: Text('Actions')),
        DataColumn(label: Text('')),
      ], rows: controller.leadListData.map((leadData)=>
           DataRow(cells: [
        DataCell(Text("${leadData.firstName.toString()+ leadData.lastName.toString()}")),
        DataCell(Text(leadData.source.toString())),
        DataCell(Text("")),
        DataCell(Text(leadData.mobile.toString())),
        DataCell(Text(leadData.address.toString())),
        DataCell(Text(leadData.nextInteraction.toString())),
        DataCell(Text(leadData.status.toString())),
        DataCell(_rowIconButtonData(controller)),
        DataCell(IconButton(onPressed: (){},icon: Icon(Icons.more_vert),))
      ])).toList(),
      ),
    );
  });
}

void _showImportModelView(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('Import File', style: MontserratStyles.montserratBoldTextStyle(size: 20)),
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
                    Get.back();
                    Get.snackbar('File Selected', 'You selected: $fileName',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: appColor,
                        colorText: Colors.white);
                  }
                },
                child: Text('Select File', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: appColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

_rowIconButtonData(LeadListViewController controller,){
  return Row(children: [
    GestureDetector(onTap: (){print('whatsappp tapped');},child: Image.asset(whatsappIcon, fit: BoxFit.cover,height: 25, width: 25,),),
    GestureDetector(onTap: (){print('edit tapped');},child: Icon(Icons.edit),),
    GestureDetector(onTap: (){print("delete tapped");},child: Icon(Icons.delete, color: Colors.red,),)
  ],);
}