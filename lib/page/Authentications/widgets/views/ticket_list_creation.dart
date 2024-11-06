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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketListCreation extends GetView<TicketListCreationController> {
  const TicketListCreation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyAnnotatedRegion(
        child: GetBuilder<TicketListCreationController>(
          init: TicketListCreationController(),
          builder: (controller) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, size: 25, color: Colors.black),
                onPressed: () => Get.back(),
              ),
              backgroundColor: appColor,
              middle: const Text('Add Ticket'),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBasicDetails(context),
                      _buildCustomerSection(context),
                      _buildFSRSection(context),
                      _buildServiceSection(context),
                      _buildInstructionsSection(context),
                      const SizedBox(height: 20),
                      _buildButtonView(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTaskName(context: context),
        const SizedBox(height: 20),
        _addTechnician(context: context),
        const SizedBox(height: 20),
        _buildOptionbutton(context: context),
        const SizedBox(height: 20),
        _buildtextContainer(context: context),
        const SizedBox(height: 20),
        _dobView(context: context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCustomerSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Details',
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
        ),
        const SizedBox(height: 10),
        _buildCustomerFields(context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCustomerFields(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: "Customer Details".tr,
          textInputType: TextInputType.text,
          labletext: "customer name".tr,
          prefix: IconButton(
            onPressed: () => _buildBottomsheet(context: context),
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: "product name".tr,
          textInputType: TextInputType.text,
          labletext: "product name".tr,
          prefix: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
          ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: "model no".tr,
          textInputType: TextInputType.text,
          labletext: "model no".tr,
          prefix: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildFSRSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FSR Details',
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: "FSR Details".tr,
          textInputType: TextInputType.text,
          prefix: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildServiceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services Details',
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
          hintText: "Services Details".tr,
          textInputType: TextInputType.text,
          prefix: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInstructionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: Get.height * 0.16,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              style: MontserratStyles.montserratBoldTextStyle(
                color: Colors.black,
                size: 13,
              ),
              maxLines: 10,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Instructions *',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskName({required BuildContext context}) {
    return CustomTextField(
      hintText: "Task Name".tr,
      textInputType: TextInputType.text,
      labletext: "Task Name".tr,
      prefix: const Icon(Icons.add_task, color: Colors.black),
    );
  }

  Widget _addTechnician({required BuildContext context}) {
    return CustomTextField(
      hintText: "Assign To".tr,
      textInputType: TextInputType.text,
      labletext: "Assign To".tr,
      prefix: const Icon(Icons.add_task, color: Colors.black),
      suffix: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  // Now let's update the button section in the main widget
  Widget _buildOptionbutton({required BuildContext context}) {
    return GetBuilder<TicketListCreationController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // AMC Button
          ElevatedButton(
            onPressed: () => controller.toggleAmc(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                controller.isAmcSelected ? appColor : Colors.white,
              ),
              foregroundColor: MaterialStateProperty.all(
                controller.isAmcSelected ? Colors.white : Colors.black,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: controller.isAmcSelected ? appColor : Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
            ),
            child: Text(
              'AMC',
              style: MontserratStyles.montserratBoldTextStyle(
                color: controller.isAmcSelected ? whiteColor : Colors.black,
                size: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Rate Button
          ElevatedButton(
            onPressed: () => controller.toggleRate(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                controller.isRateSelected ? appColor : Colors.white,
              ),
              foregroundColor: MaterialStateProperty.all(
                controller.isRateSelected ? Colors.white : Colors.black,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: controller.isRateSelected ? appColor : Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
            ),
            child: Text(
              'Rate',
              style: MontserratStyles.montserratBoldTextStyle(
                color: controller.isRateSelected ? whiteColor : Colors.black,
                size: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Rate Input Box - Only show when Rate is selected
          if (controller.isRateSelected)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: Get.height * 0.06,
              width: Get.width * 0.30,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Rate *',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStyledButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(appColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
        elevation: MaterialStateProperty.all(5),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: MontserratStyles.montserratBoldTextStyle(
          color: whiteColor,
          size: 13,
        ),
      ),
    );
  }

  Widget _buildtextContainer({required BuildContext context}) {
    return Container(
      height: Get.height * 0.16,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
          maxLines: 10,
          decoration: const InputDecoration(
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
      labletext: "Date".tr,
      prefix: IconButton(
        onPressed: () => controller.selectDate(context),
        icon: const Icon(Icons.calendar_month, color: Colors.black),
      ),
    );
  }

  Widget _buildButtonView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: _buttonStyle(),
          child: Text(
            'Cancel',
            style: MontserratStyles.montserratBoldTextStyle(
              color: Colors.black,
              size: 13,
            ),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {},
          style: _buttonStyle(),
          child: Text(
            "Add Ticket",
            style: MontserratStyles.montserratBoldTextStyle(
              color: Colors.black,
              size: 13,
            ),
          ),
        ),
      ],
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: appColor,
      foregroundColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );
  }

  void _buildBottomsheet({required BuildContext context}) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return  PrincipalCustomerView();
      },
    );
  }
}