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

import '../../../../response_models/customer_list_response_model.dart';
import '../controller/add_amc_view_controller.dart';

class CreateAMCViewScreen extends GetView<AddAmcViewController> {
  const CreateAMCViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<AddAmcViewController>(
        init: AddAmcViewController(),
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
                        _mainContainerView(context,controller),
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

  Widget _mainContainerView( BuildContext context,AddAmcViewController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAMCName(context: context, controller: controller),
        vGap(20),
        _addTimeRange(context: context, controller: controller),
        vGap(20),
        _dobView(context: context , controller: controller),
        vGap(20),
        _buildNOofchoiceField(context:context, controller: controller),
        vGap(20),
        _buildselectedView(context: context, controller: controller),
        vGap(20),
        _buildServiceOccurances(context: context, controller: controller),
        vGap(20),
        _buildProductBrand(context: context, controller: controller),
        vGap(20),
        _buildProductName(context: context, controller: controller),
        vGap(20),
        _buildSerialNoModel(context: context, controller: controller),
        vGap(20),
        _buildServiceAccount(context: context, controller: controller),
        vGap(20),
        _buildRecoievedAccount(context: context, controller: controller),
        vGap(20),
        dropValueToShowCustomerName(context: context, controller: controller),
        vGap(20),
        _buildtextContainer(context: context, controller: controller),
        vGap(20),
        _buildOptionbutton(context: context, controller: controller)
        // _selectGroupViewform(context: context),
      ],
    );
  }

  Widget _buildAMCName({required BuildContext context,  required AddAmcViewController controller }) {
    return CustomTextField(
      controller: controller.amcNameController,
      hintText: "AMC Name".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "AMC Name".tr,
      prefix: Icon(Icons.add_task, color: Colors.black),
    );
  }
  // Widget _buildCustomerName({required BuildContext context,required AddAmcViewController controller }) {
  //   return CustomTextField(
  //     controller: controller.customerNameController,
  //     hintText: "Customer Name".tr,
  //     textInputType: TextInputType.text,
  //     onFieldSubmitted: (String? value) {},
  //     labletext: "Customer Name".tr,
  //     prefix: Icon(Icons.add_task, color: Colors.black),
  //   );
  // }

  Widget dropValueToShowCustomerName(
      {required BuildContext context, required AddAmcViewController controller}) {
    return Obx(() => DropdownButtonHideUnderline(
      child: DropdownMenu<CustomerData>(
        // leadingIcon: IconButton(
        //     onPressed: () {
        //       // _editWidgetOfPrincipalDialogValue(context, controller);
        //     },
        //     icon: Icon(Icons.add)
        // ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: appColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        width: MediaQuery.of(context).size.width - 40,
        initialSelection: null,
        requestFocusOnTap: true,
        label: Text('Customer Name'.tr,style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color:Colors.grey),),
        onSelected: (CustomerData? customerData) {
          if (customerData != null) {
            controller.customerNameController.text =
            "${customerData.firstName ?? ''} ${customerData.lastName ?? ''}";
            controller.selectedCustomerId.value = customerData.id ?? 0;
          }
        },
        dropdownMenuEntries: controller.customerdefineData
            .map<DropdownMenuEntry<CustomerData>>(
                (CustomerData customer) {
              return DropdownMenuEntry<CustomerData>(
                value: customer,
                label: "${customer.customerName ?? ''}" ?? 'Unknown Customer',
              );
            }).toList(),
      ),
    ));
  }


  Widget _buildProductBrand({required BuildContext context,required AddAmcViewController controller }) {
    return CustomTextField(
      controller: controller.productBrandController,
      hintText: "Product Brand".tr,
      textInputType: TextInputType.text,
      maxLines: 2,
      onFieldSubmitted: (String? value) {},
      labletext: "Product Brand".tr,
      // suffix: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down_outlined, color: Colors.black)),
    );
  }
  Widget _buildProductName({required BuildContext context,required AddAmcViewController controller }) {
    return CustomTextField(
      controller: controller.productNameController,
      hintText: "Product Name".tr,
      maxLines: 2,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Product Name".tr,
      // prefix: Icon(Icons.add_task, color: Colors.black),
    );
  }
  Widget _buildServiceAccount({required BuildContext context, required AddAmcViewController controller}) {
    return CustomTextField(
      hintText: "Service Amount".tr,
      controller: controller.serviceAmountController,
      textInputType: TextInputType.number,
      onFieldSubmitted: (String? value) {},
      labletext: "Service Amount".tr,
      readOnly: true,
      suffix: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => controller.incrementServiceAmount(),
              child: Icon(Icons.arrow_drop_up_outlined, color: Colors.black,size: 25,),
            ),
            GestureDetector(
              onTap: () => controller.decrementServiceAmount(),
              child: Icon(Icons.arrow_drop_down_outlined, color: Colors.black,size: 25,),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildRecoievedAccount({required BuildContext context, required AddAmcViewController controller}) {
    return CustomTextField(
      hintText: "Received Amount".tr,
      controller: controller.receivedAmountController,
      textInputType: TextInputType.number,
      onFieldSubmitted: (String? value) {},
      labletext: "Received Amount".tr,
      readOnly: true,
      suffix: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => controller.incrementReceivedAmount(),
              child: Icon(Icons.arrow_drop_up_outlined, color: Colors.black,size: 25,),
            ),
            GestureDetector(
              onTap: () => controller.decrementReceivedAmount(),
              child: Icon(Icons.arrow_drop_down_outlined, color: Colors.black,size: 25),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSerialNoModel({required BuildContext context,required AddAmcViewController controller }) {
    return CustomTextField(
      controller: controller.serialModelNoController,
      hintText: "Serial Model No".tr,
      maxLines: 2,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Serial Model No".tr,
      // prefix: Icon(Icons.add_task, color: Colors.black),
    );
  }
  Widget _addTimeRange({required BuildContext context,required AddAmcViewController controller }) {
    return CustomTextField(
      onTap: ()=>controller.showTimePickerDropdown(context),
      hintText: "Activation Time".tr,
      controller: controller.activationTimeController,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Activation Time".tr,
      prefix: Icon(Icons.access_time, color: Colors.black),
      suffix: IconButton(
        onPressed: () => controller.showTimePickerDropdown(context),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
      ),
      readOnly: true,
    );
  }

  Widget _buildOptionbutton({required BuildContext context, required AddAmcViewController controller}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildButton('Cancel',onPressed: ()=>Get.back()),
        hGap(10),
        _buildButton('Add', onPressed: ()=>controller.hitPostCreationAmcView()),
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
Widget _dobView({required BuildContext context, required AddAmcViewController controller}) {
  // final controller = Get.find<>();
  return CustomTextField(
    onTap: ()=>controller.selectDate(context),
    hintText: "dd-month-yyyy".tr,
    controller: controller.datesController,
    textInputType: TextInputType.datetime,
    focusNode: controller.datesFocusNode,
    onFieldSubmitted: (String? value) {},
    labletext: "Date".tr,
    prefix: IconButton(
      onPressed: () => controller.selectDate(context),
      icon: Icon(Icons.calendar_month, color: Colors.black),
    ),
    readOnly: true,
  );
}

Widget _buildNOofchoiceField({required BuildContext context,required AddAmcViewController controller }) {
  return CustomTextField(
    onTap: ()=>controller.noOfServicesDropdown(context),
    controller: controller.noOfServiceController,
    readOnly: true,
    hintText: 'No. of Service'.tr,
    labletext: 'No. of Service'.tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    prefix: IconButton(
      onPressed: () =>controller.noOfServicesDropdown(context),
      icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
    ),
  );
}
  Widget _buildselectedView({required BuildContext context,required AddAmcViewController controller }) {
    return CustomTextField(
      onTap: ()=> controller.reminderSelection(context),
      controller: controller.reminderController,
      readOnly: true,
      hintText: 'Reminder'.tr,
      labletext: 'Reminder'.tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      prefix: IconButton(
        onPressed: ()=>controller.reminderSelection(context),
        icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
      ),
    );
  }
  Widget _buildServiceOccurances({required BuildContext context,required AddAmcViewController controller}) {
    return CustomTextField(
      onTap: ()=> controller.servicesOccurances(context),
      controller: controller.serviceOccurrenceController,
      readOnly: true,
      hintText: 'Service Occurence'.tr,
      labletext: 'Service Occurence'.tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      prefix: IconButton(
        onPressed: () =>controller.servicesOccurances(context),
        icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
      ),
    );
  }

  Widget _buildtextContainer({required BuildContext context,required AddAmcViewController controller}) {
    return CustomTextField(
      controller: controller.notesController,
      hintText: 'Note *'.tr,
      labletext: 'Note'.tr,
      maxLines: 10,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value){},
    );/*Container(
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
    );*/
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