import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/expenditure_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class ExpenditureScreen extends GetView<ExpenditureScreenController>{
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
        child: SafeArea(child: GetBuilder<ExpenditureScreenController>(init: ExpenditureScreenController(),builder: (context)=> Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Expenditure', style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),),
      ),
      body: _mainScreenWidget(controller),
    ))));
  }

  Widget _mainScreenWidget(ExpenditureScreenController controller){
     return  Padding(
       padding: const EdgeInsets.all(12.0),
       child: Column(children: [
         _searchBarscaffoldViewWidget(controller)
       ],),
     );
  }
}
_searchBarscaffoldViewWidget(ExpenditureScreenController controller){
    return Container(
      height: Get.height * 0.2,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
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

    );
}