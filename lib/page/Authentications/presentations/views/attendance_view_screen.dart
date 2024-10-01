import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/attendance_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class AttendanceScreen extends GetView<AttendanceScreenController>{

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(child: SafeArea(child: GetBuilder<AttendanceScreenController>(builder: (context)=> Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Today's Attendance", style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),),
      ),
      body: _mainScreenWidget(controller),
    ))));
  }

  _mainScreenWidget(AttendanceScreenController controller){
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: [
        _rowViewWidget(controller),
      vGap(30),
      _presentViewScreenWidget(controller),
        vGap(30),
        _absentViewScreenWidget(controller),
        vGap(30),
        _idleVieScreenWidget(controller)
    ],);
  }
}

_presentViewScreenWidget(AttendanceScreenController controller){
  return Container(
      height: Get.height * 0.2,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
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
    child: Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Center(
        child: Column(children: [
          Text("0", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
          vGap(20),
          Text("Present", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
        ],),
      ),
    ),
  );
}

_absentViewScreenWidget(AttendanceScreenController controller){
  return Container(
    height: Get.height * 0.2,
    width: Get.width,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
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
    child: Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Center(
        child: Column(children: [
          Text("0", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
          vGap(20),
          Text("Absent", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
        ],),
      ),
    ),
  );
}

_idleVieScreenWidget(AttendanceScreenController controller){
  return Container(
    height: Get.height * 0.2,
    width: Get.width,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
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
    child: Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Center(
        child: Column(children: [
          Text("0", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
          vGap(20),
          Text("Idle", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
        ],),
      ),
    ),
  );
}

Widget _rowViewWidget(AttendanceScreenController controller) {
  return Row(
    children: [
      Expanded(
        flex: 4,
        child: CustomTextField(
          hintText: "Search technicians...",
          prefix: Icon(Icons.search, color: Colors.grey),
          // onTap: () => controller.searchTechnicians,
          // controller: controller.searchController,
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            // Add your "View All" functionality here
          },
          child: Text(
            "View All",
            style: MontserratStyles.montserratSemiBoldTextStyle(size: 13, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}