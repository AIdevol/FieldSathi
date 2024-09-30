import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/services_Categories_controller.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../utilities/google_fonts_textStyles.dart';

class ServicesViewScreen extends GetView<ServiceCategoriesController>{

  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<ServiceCategoriesController>(builder: (controller)=>Scaffold(
      appBar: AppBar(
        title: Text("Service Categories", style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),
        backgroundColor: appColor,
        actions: [IconButton(onPressed: (){}, icon: Icon(FeatherIcons.search))],
      ),
      body: _buildTopBar(controller),
    )));
  }
  Widget _buildTopBar(ServiceCategoriesController controller) {
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
      child: Expanded(
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
