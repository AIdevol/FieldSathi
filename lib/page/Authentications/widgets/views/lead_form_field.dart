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
    return MyAnnotatedRegion(child: GetBuilder<LeadFormFieldController>(
      init: LeadFormFieldController(),
        builder: (controller)=> Scaffold(
      appBar: AppBar(
        title: Text('Lead Form', style: MontserratStyles.montserratBoldTextStyle(size: 15, color:  Colors.black),),
        backgroundColor: appColor,
       /*   actions: [
        IconButton(onPressed: (){
          // Get.toNamed(AppRoutes.leadFormFieldScreen);
        }, icon: Icon(FeatherIcons.plus, size: 20,))..paddingSymmetric(horizontal: 20.0)
      ]*/),
      body: _mainScreen(controller,context)
    )
    ));
  }
}
_mainScreen(LeadFormFieldController controller, BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: ListView(children: [
      Text("Basics Informations",style: MontserratStyles.montserratBoldTextStyle(size: 20, color: Colors.black),),
      vGap(20),
      _customerCompanyContainer(controller),
      vGap(20),
      _customerFirstNameContainer(controller),
      vGap(20),
      _customerLastNameContainer(controller),
      vGap(20),
      Text("Contact Details",style: MontserratStyles.montserratBoldTextStyle(size: 20, color: Colors.black),),
      vGap(20),
      _customerEmailContainer(controller),
      vGap(20),
      _customerPhoneContainer(controller),
      vGap(20),
      _customerAddressContainer(controller),
      vGap(20),
      _customerCountryContainer(controller),
      vGap(20),
      _customerStateContainer(controller),
      vGap(20),
      _customerCityContainer(controller),
      vGap(20),
      _customerAdditionalContainer(controller),
      vGap(20),
      _customerSourceContainer(controller),
      vGap(20),
      _customButtonViewWidget(controller: controller,context: context),
      vGap(20),
    ],),
  );
}

_customerCompanyContainer(LeadFormFieldController controller){
    return CustomTextField(
      controller: controller.companyController,
      hintText: "Enter Company Name".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Enter Company Name".tr,
      // suffix: IconButton(onPressed: (){
      //   Get.toNamed(AppRoutes.principleCustomerScreen);
      // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
    );
}
_customerFirstNameContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.firstNameController,
    hintText: "First Name".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "First Name".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}

_customerLastNameContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.lastNameController,
    hintText: "Last Name".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Last Name".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}
_customerEmailContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.emailController,
    hintText: "Email".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Email".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}

_customerPhoneContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.phoneController,
    hintText: "Mobile No.".tr,
    textInputType: TextInputType.phone,
    onFieldSubmitted: (String? value) {},
    labletext: "Mobile No.".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}
_customerAddressContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.addressController,
    hintText: "Address".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Address".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}
_customerCountryContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.countryController,
    hintText: "Country".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Country".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}
_customerStateContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.stateController,
    hintText: "State".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "State".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}
_customerCityContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.cityController,
    hintText: "City".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "City".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}

_customerAdditionalContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.additionalNotesController,
    hintText: "Additional Notes".tr,
    maxLines: 10,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Additional".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}

_customerSourceContainer(LeadFormFieldController controller){
  return CustomTextField(
    controller: controller.sourceController,
    hintText: "Source".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Source".tr,
    // suffix: IconButton(onPressed: (){
    //   Get.toNamed(AppRoutes.principleCustomerScreen);
    // }, icon: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
  );
}

Widget _customButtonViewWidget({required LeadFormFieldController controller,required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      _buildButton('Cancel',onPressed: ()=>Get.back(), controller: controller),
      hGap(10),
      _buildButton('Add', onPressed: (){}/*controller.hitPostLeadlistApiCall()*/, controller:  controller),
      hGap(10),
      // _buildRateTextField(),
    ],
  );
}

Widget _buildButton(String text,{required LeadFormFieldController controller,required onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
    ),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: appColor,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black.withOpacity(0.5),
    ),
  );
}