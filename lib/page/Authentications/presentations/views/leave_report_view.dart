import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controllers/LeaveReportViewScreenController.dart';

class LeaveReportViewScreen extends GetView<LeaveReportViewScreenController>{

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<LeaveReportViewScreenController>(
          builder: (controller) =>
              Scaffold(
                appBar: AppBar(
                  backgroundColor: appColor,
                  title: Text(
                    'Leave Reports',
                    style: MontserratStyles.montserratBoldTextStyle(
                      color: blackColor,
                      size: 15,
                    ),
                  ),
                ),
                body: Column(
                  children: <Widget>[
                    _buildTopBar(context),
                    vGap(5),
                    _buildscearchView(context: context),
                    // vGap(),
                  ],
                ),
              ),
        ),
      ),
    );
  }
  Widget _buildTopBar( BuildContext context) {
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
          _buildsearchView(context: context ),
          hGap(20),
          _buildSelectValue(context: context),
          hGap(20),
          
         ]));
  }
  _buildsearchView({required BuildContext context}){
    return Container(
      color: appColor,
      height: Get.height*0.05,
      width: Get.width*0.4,);
  }

  _buildSelectValue({required BuildContext context}){
    return Container(
      color: appColor,
      height: Get.height*0.05,
      width: Get.width*0.4,
    );
  }

  _buildscearchView({required BuildContext context}) {
    return SizedBox(
      height: Get.height * 0.04,
      width: Get.width * 0.95, // Set a specific width
      child: ListView(
        scrollDirection: Axis.horizontal, // Allow horizontal scrolling
        children: [
          Container(
            width: Get.width * 0.4, // Set a specific width for each item
            child: ListTile(
              title: Text('Sr.No',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              ),),
            ),
          ),
          Container(
            width: Get.width * 0.4,
            child: ListTile(
              title: Text('Name',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              ),),
            ),
          ),
          Container(
            width: Get.width * 0.4,
            child: ListTile(
              title: Text('Phone No',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              ),),
            ),
          ),
          Container(
            width: Get.width * 0.4,
            child: ListTile(
              title: Text('Profile',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              ),),
            ),
          ),
          Container(
            width: Get.width * 0.4,
            child: ListTile(
              title: Text('Reason',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              ),),
            ),
          ),Container(
            width: Get.width * 0.4,
            child: ListTile(
              title: Text('From Date',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              ),),
            ),
          ),Container(
            width: Get.width * 0.4,
            child: ListTile(
              title: Text('To Date',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              ),),
            ),
          ),Container(
            width: Get.width * 0.4,
            child: ListTile(
              title: Text('Days',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              ),),
            ),
          ),Container(
            width: Get.width * 0.4,
            child: ListTile(
              title: Text('Status',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              ),),
            ),
          ),
        ],
      ),
    );
  }

}