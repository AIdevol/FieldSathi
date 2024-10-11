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
          title:  Text("Add SuperUser", style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),),
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
    hintText: 'Employee Id',
    labletext: 'Employee Id',
    prefix: Icon(Icons.perm_identity),
    // validator: ,
  );
}

_joiningDateField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    controller: controller.joiningDateController,
    hintText: 'Joining date',
    labletext: 'Joining date',
    validator: (value){
      if (value == null || value.isEmpty) {
       return 'Please select a joining date';
      };
      return null;
      },
    suffix: IconButton(
        onPressed: ()async{
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
            controller.joiningDateController.text = formattedDate;
          }
        }, icon: Icon(Icons.calendar_month_outlined
      ),
    ),
  );
}

_firstNameField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    hintText: 'First Name',
    labletext: 'First Name',
    // prefix: Icon(Icons.),
  );
}

_lastNameField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    hintText: 'Last Name',
    labletext: 'Last Name',
    // prefix: Icon(Icons.)

  );
}

_emailField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    hintText: 'Email',
    labletext: 'Email',
    prefix: Icon(Icons.email
    ),
  );
}

_phoneNumberField(AddSuperUserViewController controller, BuildContext context){
  return CustomTextField(
    hintText: 'Phone Number',
    labletext: 'Phone Number',
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
          // controller.hitAddTechnicianApiCall();
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
