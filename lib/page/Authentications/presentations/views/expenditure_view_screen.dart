import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/expenditure_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class ExpenditureScreen extends GetView<ExpenditureScreenController>{
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(child: SafeArea(child: GetBuilder<ExpenditureScreenController>(builder: (context)=> Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Expenditure', style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),),
      ),
    ))));
  }
}