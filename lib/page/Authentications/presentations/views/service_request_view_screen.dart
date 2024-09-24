import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/service_request_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class ServiceRequestViewScreen extends GetView<ServiceRequestScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(child: SafeArea(child: GetBuilder<ServiceRequestScreenController>(builder: (context)=> Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Service Request', style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),),
      ),
    ))));
  }
}