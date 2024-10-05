import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/ticket_list_creation_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/principal_customer_view.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';

class TicketListCreation extends GetView<TicketListCreationController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyAnnotatedRegion(child: GetBuilder<TicketListCreationController>(
        init: TicketListCreationController(),
        builder: (controller)=>CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 25, color: Colors.black,),
              onPressed: () {
                Get.back();
              },),
            backgroundColor: appColor,
            middle: Text('Add Ticket'),
          ),
          child: _form(context)
      ),))
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
          _addTechnician(context: context),
          vGap(20),
          _buildOptionbutton(context: context),
          vGap(20),
          _buildtextContainer(context: context),
          vGap(20),
          _dobView(context: context),
          vGap(20),
          _selectGroupViewform(context: context)

        ],),
      ),

    );
}

_buildTaskName({required BuildContext context}){
  return CustomTextField(
    hintText: "Task Name".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.emailAddress,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Task Name".tr,
    prefix: Icon(Icons.add_task, color: Colors.black,),
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
    hintText: "Assign To".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.emailAddress,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Assign To".tr,
    prefix: Icon(Icons.add_task, color: Colors.black,),
    suffix: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.black,),),
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
        child: Text('AMC',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(appColor),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
        ),
      ),
      hGap(10),
      ElevatedButton(
        onPressed: () {},
        child: Text('Rate',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(appColor), // Background color
          foregroundColor: WidgetStateProperty.all(Colors.white), // Text color
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)), // Padding
          elevation: WidgetStateProperty.all(5), // Shadow elevation
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
          ),
          shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
        ),
      ),
      hGap(10),
      Container(
        height: Get.height*0.06,
        width: Get.width*0.30,
        decoration: BoxDecoration(color: whiteColor,borderRadius: BorderRadius.circular(25),
            border: Border.all(
                width:1,
                color: Colors.grey
              // _isFocused ? Colors.blue : Colors.black,

            )),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Rate *',
            ),
          ),
        ),
      )

      // InkWell(onTap: (){},child: Container(height: 40,width: 120,color:appColor,),)
    ],);
  //   GetBuilder<TicketListController>(builder: (context){
  //   return
  // });
 }

 _buildtextContainer({required BuildContext context}){
  return  Container(
    height: Get.height*0.16,
    width: Get.width*0.40,
    decoration: BoxDecoration(color: whiteColor,borderRadius: BorderRadius.circular(25),
        border: Border.all(
            width:1,
            color: Colors.grey
          // _isFocused ? Colors.blue : Colors.black,

        )),
    child:  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
        maxLines: 10,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Purpose *',
        ),
      ),
    ),
  );
 }

Widget _dobView({required BuildContext context}) {
  final controller = Get.put(TicketListCreationController());
  return CustomTextField(
    hintText: "dd-month-yyyy".tr,
    controller: controller.dateController,
    textInputType: TextInputType.datetime,
    focusNode: controller.focusNode,
    onFieldSubmitted: (String? value) {
      // Handle field submission if needed
    },
    labletext: "Date".tr,
    prefix: IconButton(
      onPressed: () => controller.selectDate(context),
      icon: Icon(Icons.calendar_month, color: Colors.black),
    ),
  );
}

Widget _selectGroupViewform({required BuildContext context}){
  return SizedBox(
    height: Get.height,
    width: Get.width,
    child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        Text('Customer Details',    style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
        _buildListCustomerDetails(context: context),
        vGap(20),
        Text('FSR Details',    style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
        CustomTextField(
      hintText: "FSR Details".tr,
      // controller: controller.dateController,
      textInputType: TextInputType.datetime,
      // focusNode: controller.focusNode,
      onFieldSubmitted: (String? value) {
        // Handle field submission if needed
      },
      // labletext: "Date".tr,
      prefix: IconButton(
        onPressed: (){} /*=> controller.selectDate(context)*/,
        icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30,),
      ),
    ),
        vGap(20),
        Text('Services Details',    style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
        CustomTextField(
      hintText: "Services Details".tr,
      // controller: controller.dateController,
      textInputType: TextInputType.datetime,
      // focusNode: controller.focusNode,
      onFieldSubmitted: (String? value) {
        // Handle field submission if needed
      },
      // labletext: "Date".tr,
      prefix: IconButton(
        onPressed: (){} /*=> controller.selectDate(context)*/,
        icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30,),
      ),
    ),
        vGap(20),
        Text('Instructions',    style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
    Container(
      height: Get.height*0.16,
      width: Get.width*0.40,
      decoration: BoxDecoration(color: whiteColor,borderRadius: BorderRadius.circular(25),
          border: Border.all(
              width:1,
              color: Colors.grey
            // _isFocused ? Colors.blue : Colors.black,

          )),
      child:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
          maxLines: 10,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Instructions *',
          ),
        ),
      ),
    ),
        vGap(20),
        _buildButtonView(context:  context)
      ],),
  );
}

Widget _buildListCustomerDetails({required BuildContext context}){
  return Column(children: [
    vGap(20),
    CustomTextField(
      hintText: "Customer Details".tr,
      // controller: controller.dateController,
      textInputType: TextInputType.datetime,
      // focusNode: controller.focusNode,
      onFieldSubmitted: (String? value) {
        // Handle field submission if needed
      },
      labletext: "customer name".tr,
      prefix: IconButton(
        onPressed: () => _buildBottomsheet(context:  context),
        icon: Icon(Icons.add, color: Colors.black),
      ),
    ),
    CustomTextField(
      hintText: "product name".tr,
      // controller: controller.dateController,
      textInputType: TextInputType.datetime,
      // focusNode: controller.focusNode,
      onFieldSubmitted: (String? value) {
        // Handle field submission if needed
      },
      labletext: "product name".tr,
      prefix: IconButton(
        onPressed: () {}/*=> controller.selectDate(context)*/,
        icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30,),
      ),
    ),
    CustomTextField(
      hintText: "model no".tr,
      // controller: controller.dateController,
      textInputType: TextInputType.datetime,
      // focusNode: controller.focusNode,
      onFieldSubmitted: (String? value) {
        // Handle field submission if needed
      },
      labletext: "model no".tr,
      prefix: IconButton(
        onPressed: () {}/*=> controller.selectDate(context)*/,
        icon: Icon(Icons.add, color: Colors.black),
      ),
    )
  ],);
}


Widget _buildButtonView({required BuildContext context}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    // crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      ElevatedButton(onPressed: (){}, child: Text('Cancel',style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),style: ElevatedButton.styleFrom(
  backgroundColor: appColor,
  foregroundColor: Colors.white,           // Text and icon color
  shadowColor: Colors.black,         // Shadow color
  elevation: 5,                      // Elevation of the button
  shape: RoundedRectangleBorder(     // Rounded corners
  borderRadius: BorderRadius.circular(12),
  ),
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),)),
      hGap(20),
      ElevatedButton(onPressed: (){}, child: Text("Add Ticket", style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
  style: ElevatedButton.styleFrom(
    backgroundColor: appColor,
          foregroundColor: Colors.white,           // Text and icon color
          shadowColor: Colors.black,         // Shadow color
          elevation: 5,                      // Elevation of the button
          shape: RoundedRectangleBorder(     // Rounded corners
            borderRadius: BorderRadius.circular(12),
          ),
  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),))
    ],
  );
}

_buildBottomsheet({required BuildContext context}){
  return showBottomSheet(context: context, builder: (BuildContext context){
    return PrincipalCustomerView();
  });
}