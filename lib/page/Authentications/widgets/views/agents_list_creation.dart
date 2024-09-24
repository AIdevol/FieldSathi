import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/AgentsViewScreenController.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';

class AgentsListCreation extends GetView<AgentsViewScreenController> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 25, color: Colors.black,),
            onPressed: () {
              Get.back();
            },),
          backgroundColor: appColor,
          middle: Text('Add Agent'),
        ),
        child: _form(context)
    );
  }
}
_form(BuildContext context) {
  return Container(
    height: Get.height,
    width: Get.width,
    color: whiteColor,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(children: [
        _buildTaskName(context: context),
        vGap(20),
        _buildLastName(context: context),
        vGap(20),
        _addTechnician(context: context),
        vGap(20),
        _phoneNumber(context: context),
        vGap(40),
        _buildOptionbutton(context: context),

      ],),
    ),

  );
}

_buildTaskName({required BuildContext context}){
  return CustomTextField(
    hintText: "First Name".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.text,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "First Name".tr,
    prefix: Icon(Icons.person, color: Colors.black,),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}
_buildLastName({required BuildContext context}){
  return CustomTextField(
    hintText: "last Name".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.text,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "last Name".tr,
    prefix: Icon(Icons.person, color: Colors.black,),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}

_addTechnician({required BuildContext context}){
  return CustomTextField(
    hintText: "Email".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.emailAddress,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Email".tr,
    prefix: Icon(Icons.mail, color: Colors.black,),
    // suffix: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.black,),),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}

_phoneNumber({required BuildContext context}){
  return CustomTextField(
    hintText: "Phone Number".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.phone,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Phone Number".tr,
    prefix: Icon(Icons.phone_android_rounded, color: Colors.black,),
    // suffix: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.black,),),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}

_buildOptionbutton({required BuildContext context}){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton(
        onPressed: () {},
        child: Text('Cancel',style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(appColor),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 60, vertical: 15)),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
        ),
      ),
      hGap(20),
      ElevatedButton(
        onPressed: () {},
        child: Text('Okay',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(appColor),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 60, vertical: 15)),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
        ),
      )
  ]
  );
}
