import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/AgentsViewScreenController.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controller/add_agents_controller.dart';

class AgentsListCreation extends GetView<AgentsListController> {

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(child: GetBuilder<AgentsListController>(
      init: AgentsListController(),
        builder: (controller)=>
        CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, size: 25, color: Colors.black,),
                onPressed: () {
                  Get.back();
                },),
              backgroundColor: appColor,
              middle: Text('Add Executive'),
            ),
            child: _form(controller, context)
        )));
  }
}
_form(AgentsListController controller, BuildContext context) {
  return Container(
    height: Get.height,
    width: Get.width,
    color: whiteColor,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(children: [
        _buildEmpId(controller: controller, context: context),
        vGap(20),
        _buildJoiningDate(controller: controller, context: context),
        vGap(20),
        _buildTaskName(controller: controller, context: context),
        vGap(20),
        _buildLastName(controller: controller,context: context),
        vGap(20),
        _addTechnician(controller: controller,context: context),
        vGap(20),
        _phoneNumber(controller: controller,context: context),
        vGap(40),
        _buildOptionbutton(controller: controller ,context: context),

      ],),
    ),

  );
}

_buildEmpId({required AgentsListController controller, required BuildContext context}){
  return CustomTextField(
    hintText: "Employee Id".tr,
    controller: controller.employeeIdController,
    textInputType: TextInputType.text,
    focusNode: controller.employeeIdFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Employee Id".tr,
    prefix: Icon(Icons.person, color: Colors.black,),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
  );

}
_buildJoiningDate({required AgentsListController controller, required BuildContext context}) {
  return CustomTextField(
    hintText: "Select Joining Date".tr,
    controller: controller.joiningDateController,
    textInputType: TextInputType.text,
    focusNode: controller.joiningDateFocusNode,
    labletext: "Joining Date".tr,
    onTap: (){
        _showDatePicker(context, controller);
        print("Gesture detection0");
    },
    suffix:  Icon(Icons.calendar_today, color: appColor),
    readOnly: true,
  );
}

void _showDatePicker(BuildContext context, AgentsListController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: appColor,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    controller.joiningDateController.text = formattedDate;
    controller.selectedDate = picked; // Store the date object
    controller.update();
  }
}

_buildTaskName({required AgentsListController controller, required BuildContext context}){
  return CustomTextField(
    hintText: "First Name".tr,
    controller: controller.firstNameController,
    textInputType: TextInputType.text,
    focusNode: controller.lastNameFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "First Name".tr,
    prefix: Icon(Icons.person, color: Colors.black,),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },

  );
}
_buildLastName({required AgentsListController controller,required BuildContext context}){
  return CustomTextField(
    hintText: "last Name".tr,
    controller: controller.lastNameController,
    textInputType: TextInputType.text,
    focusNode: controller.emailFocusNode,
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

_addTechnician({required AgentsListController controller,required BuildContext context}){
  return CustomTextField(
    hintText: "Email".tr,
    controller: controller.emailController,
    textInputType: TextInputType.emailAddress,
    focusNode: controller.phoneFocusNode,
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

_phoneNumber({required AgentsListController controller,required BuildContext context}){
  return CustomTextField(
    hintText: "Phone Number".tr,
    controller:controller.phoneController,
    textInputType: TextInputType.phone,
    focusNode: controller.firstNameFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Phone Number".tr,
    prefix: Container(  margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            topLeft: Radius.circular(30)),
        // color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),child: CountryCodePicker(
          flagWidth: 15.0,
          initialSelection: 'IN',
          boxDecoration: const BoxDecoration(color: Colors.transparent),
          showCountryOnly: true,
          onChanged: (value) {
            controller.phoneCountryCode.value = value.dialCode.toString();
            // controller.update();
          }),) ,
    inputFormatters:[
      LengthLimitingTextInputFormatter(10),
    ],
  );

}

_buildOptionbutton({required AgentsListController controller,required BuildContext context}){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton(
        onPressed: () => Get.back(),
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
        child: Text('Cancel',style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),),
      ),
      hGap(20),
      ElevatedButton(
        onPressed: () =>controller.hitPostAgentsDetailsApiCall(),
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
