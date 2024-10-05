import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/LeaveReportViewScreenController.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../presentations/controllers/leave_update_screen_controller.dart';

class  LeaveUpdateScreen extends GetView<LeaveUpdateScreenController>{

  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<LeaveUpdateScreenController>(
      init: LeaveUpdateScreenController(),
        builder: (controller)=>Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Edit Assigned Leaves", style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          vGap(30),
          _sickLeaveSelectionWidget(),
          vGap(20),
          _casualLeaveSelection(),
          vGap(20),
          _probationPeriodSelectionViewWidget(),
          vGap(20),
          _buttonViewSelection(),
        ],),
      ),
    )));
  }


_sickLeaveSelectionWidget(){
    return CustomTextField(
      controller: controller.sickLeaveController,
      hintText: 'Sick Leave',
      labletext: 'Sick Leave',
      suffix: Column(
        children: [
          GestureDetector(
            onTap: (){
              controller.increaseSickLeaves();
              print('button tapped 1');
              },
              child: Icon(Icons.arrow_drop_up, size: 25,)),
          GestureDetector(
            onTap: (){
              controller.decreaseSickLeaves();
              print('button tapped 2');
              },
            child: Icon(Icons.arrow_drop_down, size: 25,),)],),
    );
}

  _casualLeaveSelection(){
    return CustomTextField(
      controller: controller.casualLeaveController,
      hintText: 'Casual Leave',
      labletext: 'Casual Leave',
      suffix: Column(
        children: [
          GestureDetector(
              onTap: (){
                controller.increaseCasualLeaves();
                print('button tapped 1');
                },
              child: Icon(Icons.arrow_drop_up, size: 25,)),
          GestureDetector(
            onTap: (){
              controller.decreaseCasualLeaves();
              print('button tapped 2');},
            child: Icon(Icons.arrow_drop_down, size: 25,),)],),
    );
  }

  _probationPeriodSelectionViewWidget(){
    return CustomTextField(
      controller: controller.probationPeriodController,
      hintText: 'Probation Period (In Months)',
      labletext: 'Probation Period (In Months)',
      suffix: Column(
        children: [
          GestureDetector(
              onTap: (){
                controller.increaseProbationPeriod();
                print('button tapped 1');
                },
              child: Icon(Icons.arrow_drop_up, size: 25,)),
          GestureDetector(
            onTap: (){
              controller.decreaseCasualLeaves();
              print('button tapped 2');
              },
            child: Icon(Icons.arrow_drop_down, size: 25,),)],),
    );
  }


  _buttonViewSelection(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: appColor),
          onPressed: (){
          controller.hitPutAssignedLeavesApiCall();
          },
          child: Text("Update Leave",
            style: MontserratStyles.montserratSemiBoldTextStyle(size: 13, color: Colors.black),)
      )..paddingAll(18.0),
    );
  }
}