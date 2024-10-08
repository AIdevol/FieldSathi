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
import '../controller/add_technician_list_controller.dart';

class AddTechnicianList extends GetView<AddTechnicianListController> {

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<AddTechnicianListController>(
        init: AddTechnicianListController(),
        builder: (controller) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, size: 25, color: Colors.black),
                onPressed: () => Get.back(),
              ),
              backgroundColor: appColor,
              middle: Text('Add Agent', style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.black),),
            ),
            child: _form(controller, context),
          );
        },
      ),
    );
  }

  Widget _form(AddTechnicianListController controller,BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            _buildFirstName(controller),
            vGap(20),
            _buildLastName(controller),
            vGap(20),
            _buildEmail(controller),
            vGap(20),
            _buildPhoneNumber(controller),
            vGap(20),
            _buildDobField(controller,context),
            vGap(40),
            _buildOptionButtons(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstName(AddTechnicianListController controller) {
    return CustomTextField(
      hintText: "First Name".tr,
      controller: controller.firstNameController,
      textInputType: TextInputType.text,
      focusNode: controller.firstFocusNode,
      onFieldSubmitted: (String? value) {
        FocusScope.of(Get.context!).requestFocus(controller.lastFocusNode);
      },
      labletext: "First Name".tr,
      prefix: Icon(Icons.person, color: Colors.black),
    );
  }

  Widget _buildLastName(AddTechnicianListController controller) {
    return CustomTextField(
      hintText: "Last Name".tr,
      controller: controller.lastNameController,
      textInputType: TextInputType.text,
      focusNode: controller.lastFocusNode,
      onFieldSubmitted: (String? value) {
        FocusScope.of(Get.context!).requestFocus(controller.emailFocusNode);
      },
      labletext: "Last Name".tr,
      prefix: Icon(Icons.person, color: Colors.black),
    );
  }

  Widget _buildEmail(AddTechnicianListController controller) {
    return CustomTextField(
      hintText: "Email".tr,
      controller: controller.emailController,
      textInputType: TextInputType.emailAddress,
      focusNode: controller.emailFocusNode,
      onFieldSubmitted: (String? value) {
        FocusScope.of(Get.context!).requestFocus(controller.phoneFocusNode);
      },
      labletext: "Email".tr,
      prefix: Icon(Icons.mail, color: Colors.black),
    );
  }

  Widget _buildPhoneNumber(AddTechnicianListController controller) {
    return CustomTextField(
      hintText: "Phone Number".tr,
      controller: controller.phoneController,
      textInputType: TextInputType.phone,
      focusNode: controller.phoneFocusNode,
      onFieldSubmitted: (String? value) {
        // You might want to handle this, e.g., move focus to next field or submit form
      },
      labletext: "Phone Number".tr,
      prefix: Icon(Icons.phone_android_rounded, color: Colors.black),
    );
  }

  Widget _buildDobField(AddTechnicianListController controller, BuildContext context) {
    return CustomTextField(
      hintText: "Date of Birth".tr,
      controller: controller.dobController,
      textInputType: TextInputType.datetime,
      labletext: "Date of Birth".tr,
      onTap: ()=> controller.selectDate(context),
      suffix: IconButton(
        onPressed: () {
      controller.selectDate(context);
        },
        icon: Icon(Icons.calendar_month, color: Colors.black),
      ),
    );
  }

  Widget _buildOptionButtons(AddTechnicianListController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            // Implement cancel functionality
            Get.back();
          },
          child: Text(
            'Cancel',
            style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),
          ),
          style: _buttonStyle(),
        ),
        hGap(20),
        ElevatedButton(
          onPressed: () {
            controller.hitAddTechnicianApiCall();
          },
          child: Text(
            'Submit',
            style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
          ),
          style: _buttonStyle(),
        )
      ],
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(appColor),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60, vertical: 15)),
      elevation: MaterialStateProperty.all(5),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
    );
  }
}
