import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/amc_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_amc_view_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../../widgets/views/add_amc_view_screen.dart';

class AMCViewScreen extends GetView<AMCScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<AMCScreenController>(
          builder: (controller) => Scaffold(
            appBar: AppBar(
              backgroundColor: appColor,
              title: Text(
                'AMC',
                style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
              ),
              actions: [IconButton(onPressed: () {
                Get.toNamed(AppRoutes.calenderViewScreen);
              }, icon: Icon(Icons.calendar_month)),
                IconButton(onPressed: (){
                 Get.toNamed(AppRoutes.createamcScreen);
                }, icon: Icon(FeatherIcons.plus)).paddingSymmetric(horizontal: 20.0)],
            ),
            body: Column(
              // scrollDirection: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTopBar(controller),
                vGap(10),
                _mainData(context: context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _mainData({required BuildContext context}){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(children: [
          _totalAmcWidget(context),
          vGap(20),
          _totalUpcomingWidget(context),
          vGap(20),
          _totalRenewalWidget(context),
          vGap(20),
          _totalCompletedWidget(context)
        ],),
      ),
    );
  }

  Widget _totalAmcWidget( BuildContext context){
    return Container(height: Get.height*0.2,width: Get.width*0.2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueAccent),
    child: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text('Total AMC', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
    vGap(20),
    Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),);

  }
  Widget _totalUpcomingWidget( BuildContext context){
    return Container(height: Get.height*0.2,width: Get.width*0.02,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.greenAccent),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Upcoming', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
          vGap(20),
          Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),);
  }
  Widget _totalRenewalWidget( BuildContext context){
    return Container(height: Get.height*0.2,width: Get.width*0.2,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Renewal', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
          vGap(20),
          Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),);
  }
  Widget _totalCompletedWidget(BuildContext context){
    return Container(height: Get.height*0.2,width: Get.width*0.2,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.redAccent),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Completed', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
          vGap(20),
          Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),);
  }

  Widget _buildTopBar(AMCScreenController controller) {
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
          // _buildSelectedRegionwiseDataExtraction(controller),
          hGap(10),
          ElevatedButton(
            onPressed: () => _showImportModelView(Get.context!),
            style: _buttonStyle(),
            child: Text(
              'Import',
              style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
            ),
          ),
          hGap(10),
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
      backgroundColor: MaterialStateProperty.all(appColor),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      elevation: MaterialStateProperty.all(5),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
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