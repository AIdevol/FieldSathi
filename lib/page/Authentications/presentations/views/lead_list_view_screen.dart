import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/lead_list_view_controller.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class LeadListViewScreen extends GetView<LeadListViewController>{



  @override
  Widget build(BuildContext Context){
    return MyAnnotatedRegion(child: GetBuilder<LeadListViewController>(builder: (controller)=>
    Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Lead List', style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.black),),
        actions: [
          IconButton(onPressed: (){
            Get.toNamed(AppRoutes.leadFormFieldScreen);
          }, icon: Icon(FeatherIcons.plus, size: 20,))..paddingSymmetric(horizontal: 20.0)
        ],
      ),
      body: ListView(children: [
        _buildTopBar(controller),
        vGap(20),
        _mainDataAnalytics(controller)
      ],),
    ),
    ));
  }

  Widget _buildTopBar(LeadListViewController controller) {
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
      backgroundColor: WidgetStateProperty.all(appColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
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

_mainDataAnalytics(LeadListViewController controller){
  return Column(children: [
    _DormantViewContainer(controller),
    vGap(20),
    _In_DiscussionContainer(controller),
    vGap(20),
    _ConvertedDiscussion(controller),
    vGap(20),
    _InActiveContainer(controller),
    vGap(20),
    _CalledViewContainer(controller),
    vGap(20),
    _QouteViewContainer(controller),
  ],);
}

_DormantViewContainer(LeadListViewController controller){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(height: Get.height*0.25,width: Get.width*2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue.shade300),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Dormant', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
          vGap(20),
          Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),),
  );
}
_In_DiscussionContainer(LeadListViewController controller){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(height: Get.height*0.25,width: Get.width*2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.red.shade200),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('In-Discussion', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
          vGap(20),
          Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),),
  );
}
_ConvertedDiscussion(LeadListViewController controller){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(height: Get.height*0.25,width: Get.width*2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: lightgreens),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Converted', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
          vGap(20),
          Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),),
  );
}
_InActiveContainer(LeadListViewController controller){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(height: Get.height*0.25,width: Get.width*2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: lighthardGreen),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Assigned', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
          vGap(20),
          Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),),
  );
}
_CalledViewContainer(LeadListViewController controller){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(height: Get.height*0.25,width: Get.width*2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: lightcream),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Called', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
          vGap(20),
          Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),),
  );
}
_QouteViewContainer(LeadListViewController controller){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(height: Get.height*0.25,width: Get.width*2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: lightBlue),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Quote', style: MontserratStyles.montserratBoldTextStyle(size: 18),),
          vGap(20),
          Text("0",style: MontserratStyles.montserratBoldTextStyle(size: 18),)],),),),
  );
}









