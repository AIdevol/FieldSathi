import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/AgentsViewScreenController.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/agents_list_creation.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../../widgets/views/ticket_list_creation.dart';

class AgentsViewScreen extends GetView<AgentsViewScreenController>{
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(child: SafeArea(child: GetBuilder<AgentsViewScreenController>(builder: (context)=> Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          'Agents',
          style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AgentsListCreation());
            },
            icon: Icon(FeatherIcons.plus),
          ).paddingOnly(left: 20.0)
        ],
      ),
      body: Container(
        height: Get.height*0.07,
        width: Get.width,
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Grey color
              spreadRadius: 1,
              blurRadius: 5, // How blurry the shadow will be
              offset: Offset(0, 5), // Changes position of shadow (x-axis, y-axis)
            ),
          ],),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // _buildSelectedRegionwiseDataExtraction(),
            hGap(10),
            ElevatedButton(
              onPressed: () =>_showImportModelView(Get.context!),
              child: Text(''
                  'Import',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(appColor),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                elevation: WidgetStateProperty.all(5),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
              ),
            ),
            hGap(10),
            ElevatedButton(
              onPressed: () {},
              child: Text('Export',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(appColor), // Background color
                foregroundColor: WidgetStateProperty.all(Colors.white), // Text color
                padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)), // Padding
                elevation: WidgetStateProperty.all(5), // Shadow elevation
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
              ),
            ),
            hGap(10),
            // InkWell(onTap: (){},child: Container(height: 40,width: 120,color:appColor,),)

          ],),
      ),
    ),)));
  }
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