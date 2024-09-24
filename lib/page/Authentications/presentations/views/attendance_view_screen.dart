import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/attendance_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class AttendanceScreen extends GetView<AttendanceScreenController>{

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(child: SafeArea(child: GetBuilder<AttendanceScreenController>(builder: (context)=> Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Attendance', style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),),
      ),
    ))));
  }
}