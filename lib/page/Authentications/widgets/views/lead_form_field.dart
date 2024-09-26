import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/lead_form_field_controller.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../navigations/navigation.dart';
import '../../../../utilities/common_textFields.dart';

class LeadFormFieldScreen extends GetView<LeadFormFieldController>{

  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<LeadFormFieldController>(builder: (controller)=> Scaffold(
      appBar: AppBar(
        title: Text('Lead Form', style: MontserratStyles.montserratBoldTextStyle(size: 15, color:  Colors.black),),
        backgroundColor: appColor,
          actions: [
        IconButton(onPressed: (){
          // Get.toNamed(AppRoutes.leadFormFieldScreen);
        }, icon: Icon(FeatherIcons.plus, size: 20,))..paddingSymmetric(horizontal: 20.0)
      ],),
      body: _mainScreen(controller)
    )
    ));
  }
}
_mainScreen(LeadFormFieldController controller){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(children: [
      vGap(20),
      _customerSelectionContainer(),
      vGap(20),

    ],),
  );
}

_customerSelectionContainer(){
    return CustomTextField(
      hintText: "Select Customer".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Select Customer".tr,
      suffix: IconButton(onPressed: (){
        Get.toNamed(AppRoutes.principleCustomerScreen);
      }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
    );
}