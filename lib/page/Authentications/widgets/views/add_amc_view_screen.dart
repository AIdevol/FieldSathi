import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_amc_view_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/principal_customer_view.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';

class CreateAMCViewScreen extends GetView<CreateAMCViewScreenController> {
  const CreateAMCViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<CreateAMCViewScreenController>(
        init: CreateAMCViewScreenController(),
        builder: (controller) {
          return Scaffold(
            body: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: appColor,
                middle: const Text('Add AMC'),
                leading: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Get.back(),
                  child: const Icon(CupertinoIcons.back, color: Colors.black),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _mainContainerView(context: context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _mainContainerView({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAMCName(context: context),
        vGap(20),
        _addTimeRange(context: context),
        vGap(20),
        _dobView(context: context),
        vGap(20),
        _buildNOofchoiceField(context:context),
        vGap(20),
        _buildselectedView(context: context),
        vGap(20),
        _buildServiceOccurances(context: context),
        vGap(20),
        _buildProductBrand(context: context),
        vGap(20),
        _buildProductName(context: context),
        vGap(20),
        _buildSerialNoModel(context: context),
        vGap(20),
        _buildServiceAccount(context: context),
        vGap(20),
        _buildRecoievedAccount(context: context),
        vGap(20),
        _buildCustomerName(context: context),
        vGap(20),
        _buildtextContainer(context: context),
        vGap(20),
        _buildOptionbutton(context: context)
        // _selectGroupViewform(context: context),
      ],
    );
  }

  Widget _buildAMCName({required BuildContext context}) {
    return CustomTextField(
      hintText: "AMC Name".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "AMC Name".tr,
      prefix: Icon(Icons.add_task, color: Colors.black),
    );
  }
  Widget _buildCustomerName({required BuildContext context}) {
    return CustomTextField(
      hintText: "Customer Name".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Customer Name".tr,
      prefix: Icon(Icons.add_task, color: Colors.black),
    );
  }
  Widget _buildProductBrand({required BuildContext context}) {
    return CustomTextField(
      hintText: "Product Brand".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Product Brand".tr,
      suffix: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_up_outlined, color: Colors.black)),
    );
  }
  Widget _buildProductName({required BuildContext context}) {
    return CustomTextField(
      hintText: "Product Name".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Product Name".tr,
      prefix: Icon(Icons.add_task, color: Colors.black),
    );
  }
  Widget _buildServiceAccount({required BuildContext context}) {
    return CustomTextField(
      hintText: "Service Amount".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Service Amount".tr,
      suffix: Column(children: [
        // logic for increment no and decrement no
        IconButton(onPressed: (){}, icon:  Icon(Icons.arrow_drop_up_outlined, color: Colors.black)),
        IconButton(onPressed: (){}, icon:  Icon(Icons.arrow_drop_down_outlined, color: Colors.black)),
      ],),
    );
  }
  Widget _buildRecoievedAccount({required BuildContext context}) {
    return CustomTextField(
      hintText: "Received Amount".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Received Amount".tr,
      suffix: Column(children: [
        // logic for increment no and decrement no
        IconButton(onPressed: (){}, icon:  Icon(Icons.arrow_drop_up_outlined, color: Colors.black)),
        IconButton(onPressed: (){}, icon:  Icon(Icons.arrow_drop_down_outlined, color: Colors.black)),
      ],),
    );
  }
  Widget _buildSerialNoModel({required BuildContext context}) {
    return CustomTextField(
      hintText: "Serial Model No".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Serial Model No".tr,
      prefix: Icon(Icons.add_task, color: Colors.black),
    );
  }
  Widget _addTimeRange({required BuildContext context}) {
    return CustomTextField(
      hintText: "Activation Time".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Activation Time".tr,
      prefix: Icon(Icons.add_task, color: Colors.black),
      suffix: IconButton(
        onPressed: () {},
        icon: Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildOptionbutton({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildButton('Cancel',onPressed: ()=>Get.back()),
        hGap(10),
        _buildButton('Add', onPressed: (){}),
        hGap(10),
        // _buildRateTextField(),
      ],
    );
  }

  Widget _buildButton(String text,{required onPressed}) {
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
Widget _dobView({required BuildContext context}) {
  final controller = Get.find<CreateAMCViewScreenController>();
  return CustomTextField(
    hintText: "dd-month-yyyy".tr,
    controller: controller.dateController,
    textInputType: TextInputType.datetime,
    focusNode: controller.focusNode,
    onFieldSubmitted: (String? value) {},
    labletext: "Date".tr,
    prefix: IconButton(
      onPressed: () => controller.selectDate(context),
      icon: Icon(Icons.calendar_month, color: Colors.black),
    ),
  );
}

Widget _buildNOofchoiceField({required BuildContext context}) {
  return CustomTextField(
    hintText: 'No. of Service'.tr,
    labletext: 'No. of Service'.tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    prefix: IconButton(
      onPressed: () {},
      icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
    ),
  );
}
  Widget _buildselectedView({required BuildContext context}) {
    return CustomTextField(
      hintText: 'Reminder'.tr,
      labletext: 'Reminder'.tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      prefix: IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
      ),
    );
  }
  Widget _buildServiceOccurances({required BuildContext context}) {
    return CustomTextField(
      hintText: 'Reminder'.tr,
      labletext: 'Reminder'.tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      prefix: IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
      ),
    );
  }

  Widget _buildtextContainer({required BuildContext context}) {
    return Container(
      height: Get.height * 0.16,
      width: Get.width * 0.40,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Note *',
          ),
        ),
      ),
    );
  }


  //
  // Widget _selectGroupViewform({required BuildContext context}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _buildSectionTitle('Customer Details'),
  //       _buildListCustomerDetails(context: context),
  //       vGap(20),
  //       _buildSectionTitle('FSR Details'),
  //       _buildDropdownField('FSR Details'),
  //       vGap(20),
  //       _buildSectionTitle('Services Details'),
  //       _buildDropdownField('Services Details'),
  //       vGap(20),
  //       _buildSectionTitle('Instructions'),
  //       _buildInstructionsField(),
  //       vGap(20),
  //       _buildButtonView(context: context),
  //     ],
  //   );
  // }
  //
  // Widget _buildSectionTitle(String title) {
  //   return Text(
  //     title,
  //     style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
  //   );
  // }
  //
  // Widget _buildDropdownField(String hintText) {
  //   return CustomTextField(
  //     hintText: hintText.tr,
  //     textInputType: TextInputType.text,
  //     onFieldSubmitted: (String? value) {},
  //     prefix: IconButton(
  //       onPressed: () {},
  //       icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
  //     ),
  //   );
  // }
  //

  // Widget _buildInstructionsField() {
  //   return Container(
  //     height: Get.height * 0.16,
  //     width: Get.width * 0.40,
  //     decoration: BoxDecoration(
  //       color: whiteColor,
  //       borderRadius: BorderRadius.circular(25),
  //       border: Border.all(width: 1, color: Colors.grey),
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       child: TextField(
  //         style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           hintText: 'Instructions *',
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildListCustomerDetails({required BuildContext context}) {
  //   return Column(
  //     children: [
  //       vGap(20),
  //       CustomTextField(
  //         hintText: "Customer Details".tr,
  //         textInputType: TextInputType.text,
  //         onFieldSubmitted: (String? value) {},
  //         labletext: "customer name".tr,
  //         prefix: IconButton(
  //           onPressed: () => _buildBottomsheet(context: context),
  //           icon: Icon(Icons.add, color: Colors.black),
  //         ),
  //       ),
  //       CustomTextField(
  //         hintText: "product name".tr,
  //         textInputType: TextInputType.text,
  //         onFieldSubmitted: (String? value) {},
  //         labletext: "product name".tr,
  //         prefix: IconButton(
  //           onPressed: () {},
  //           icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
  //         ),
  //       ),
  //       CustomTextField(
  //         hintText: "model no".tr,
  //         textInputType: TextInputType.text,
  //         onFieldSubmitted: (String? value) {},
  //         labletext: "model no".tr,
  //         prefix: IconButton(
  //           onPressed: () {},
  //           icon: Icon(Icons.add, color: Colors.black),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildButtonView({required BuildContext context}) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       _buildActionButton('Cancel', () {}),
  //       hGap(20),
  //       _buildActionButton('Add Ticket', () {}),
  //     ],
  //   );
  // }
  //
  // Widget _buildActionButton(String text, VoidCallback onPressed) {
  //   return ElevatedButton(
  //     onPressed: onPressed,
  //     child: Text(
  //       text,
  //       style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       foregroundColor: Colors.white, backgroundColor: appColor,
  //       shadowColor: Colors.black,
  //       elevation: 5,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  //     ),
  //   );
  // }
  //
  void _buildBottomsheet({required BuildContext context}) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PrincipalCustomerView();
      },
    );
  }
}