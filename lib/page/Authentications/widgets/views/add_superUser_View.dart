import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_super_user_view_Controller.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class AddSuperuserView extends GetView<AddSuperUserViewController>{

  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<AddSuperUserViewController>(
        init: AddSuperUserViewController(),
        builder: (controller)=>Scaffold(
          appBar: AppBar(backgroundColor: appColor,
          title:  Text("Add Manager", style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),),
        body: _mainScrenScreenFormManagingControllingWidget(controller, context),)
    ));
  }
}

_mainScrenScreenFormManagingControllingWidget(AddSuperUserViewController controller, BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: ListView(
      // controller: ,
      children: [
        vGap(20),
        _employeIdField(controller, context),
        vGap(20),
        _joiningDateField(controller, context),
        vGap(20),
        _firstNameField(controller, context),
        vGap(20),
        _lastNameField(controller, context),
        vGap(20),
        _emailField(controller, context),
        vGap(20),
        _phoneNumberField(controller, context),
        vGap(40),
        _buildOptionButtons(controller, context),
        vGap(20),
      ]
    ),
  );
}

_employeIdField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    controller: controller.employeeIdController,
    hintText: 'Employee Id',
    labletext: 'Employee Id',
    prefix: Icon(Icons.perm_identity),
    validator: (value){
      if (value == null || value.isEmpty) {
        return 'Please select a Employee Id';
      };
      return null;
    },
  );
}

_joiningDateField(AddSuperUserViewController controller, BuildContext context) {
  return CustomTextField(
    controller: controller.joiningDateController,
    hintText: 'Joining date',
    labletext: 'Joining date',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select a joining date';
      }
      return null;
    },
    suffix: IconButton(
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          String formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";  /*YYYY-MM-D*/
          controller.joiningDateController.text = formattedDate;
        }
      },
      icon: Icon(Icons.calendar_month_outlined),
    ),
  );
}


_firstNameField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    controller: controller.firstNameController,
    hintText: 'First Name',
    labletext: 'First Name',
    // prefix: Icon(Icons.),
  );
}

_lastNameField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    controller: controller.lastNameController,
    hintText: 'Last Name',
    labletext: 'Last Name',
    // prefix: Icon(Icons.)

  );
}

_emailField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    controller: controller.emailController,
    hintText: 'Email',
    labletext: 'Email',
    prefix: Icon(Icons.email
    ),
  );
}

_phoneNumberField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    controller: controller.phoneController,
    hintText: 'Phone Number',
    labletext: 'Phone Number',
    textInputType: TextInputType.phone,
    prefix: Icon(Icons.phone
    ),
  );
}

_buildOptionButtons(AddSuperUserViewController controller, BuildContext context) {
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
          controller.hitPostAddSupperApiCallApiCall();
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
