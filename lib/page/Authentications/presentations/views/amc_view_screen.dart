import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/amc_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_amc_view_screen_controller.dart';
import 'package:tms_sathi/response_models/amc_response_model.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../../widgets/views/add_amc_view_screen.dart';

class AMCViewScreen extends GetView<AMCScreenController> {
  // Ensure the controller is initialized
  @override
  final AMCScreenController controller = Get.put(AMCScreenController());
  final amcIds = storage.read(amcId);
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
        child: GetBuilder<AMCScreenController>(builder: (controller) =>
            SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: appColor,
                  title: Text(
                    'AMC',
                    style: MontserratStyles.montserratBoldTextStyle(
                      color: blackColor,
                      size: 15,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.addAmcCallenderScreen);
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.createamcScreen);
                      },
                      icon: Icon(FeatherIcons.plus),
                    ).paddingSymmetric(horizontal: 20.0),
                  ],
                ),
                body: Column(
                  children: [
                    _buildTopBar(),
                    vGap(10),
                    _mainData(),
                    vGap(10),
                    _dataTableViewScreen(amcIds),
                  ],
                )
               /* controller.isLoading.value
                    ? Center(child: CircularProgressIndicator(),)
                    : Column(
                  children: [
                    _buildTopBar(),
                    vGap(10),
                    _mainData(),
                    vGap(10),
                    _dataTableViewScreen(),
                  ],
                ),*/
              ),
            ),)
    );
  }

  Widget _mainData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200, // Consider making this responsive
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _totalAmcWidget(controller),
            hGap(20),
            _totalUpcomingWidget(),
            hGap(20),
            _totalRenewalWidget(),
            hGap(20),
            _totalCompletedWidget(),

          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: Get.height * 0.05,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(FeatherIcons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        style: MontserratStyles.montserratSemiBoldTextStyle(
          color: Colors.black,
        ),
        onChanged: (value) {
          // controller.updateSearch(value); // Implement this method in your controller
        },
      ),
    );
  }

  Widget _totalAmcWidget(AMCScreenController controller) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total AMC",
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
            Text(
              '${controller.totalAmcCount.value ?? '0'}',
              // controller.totalAmc.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 25),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalUpcomingWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.greenAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upcoming',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
            Text(
              '${controller.upcomingCount.value??'0'}',
              // controller.totalUpcoming.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 25),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalRenewalWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Renewal',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
            Text(
              '${controller.renewalCount.value??'0'}',
              // controller.totalRenewal.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 25),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalCompletedWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.redAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Completed',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
            Text(
              '${controller.completedCount.value??'0'}',
              // controller.totalCompleted.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 25),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: Get.height * 0.07,
      width: Get.width,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: _buildSearchField()),
          hGap(10),
          ElevatedButton(
            onPressed: () => _showImportModelView(),
            style: _buttonStyle(),
            child: Text(
              'Import',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
          ),
          hGap(10),
          ElevatedButton(
            onPressed: () {
              // controller.exportData(); // Implement this method in your controller
            },
            child: Text(
              'Export',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
            style: _buttonStyle(),
          ),
          hGap(10),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: appColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black.withOpacity(0.5),
    );
  }

  void _showImportModelView() {
    Get.dialog(
      AlertDialog(
        title: Text('Import File'),
        content: SizedBox(
          height: Get.height * 0.2,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file, size: 60, color: appColor),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles();
                  if (result != null) {
                    String fileName = result.files.single.name;
                    // controller.importFile(result); // Handle the file in controller
                    Get.snackbar('File Selected', 'You selected: $fileName');
                    Get.back(); // Close the dialog
                  }
                },
                child: Text('Select File from Local'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: appColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _dataTableViewScreen(amcIds) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() =>
          DataTable(columns: [
            DataColumn(label: Text('AMC ID/Name')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Customer Name')),
            DataColumn(label: Text('Services')),
            DataColumn(label: Text('Service Amount')),
            DataColumn(label: Text('Service Occurrence')),
            DataColumn(label: Text('Recieved Amount')),
            DataColumn(label: Text('Remainder')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text(' ')),
            DataColumn(label: Text(' ')),
            DataColumn(label: Text(' ')),
          ], rows: controller.amcResultData.map((amc) {
            return DataRow(cells: [
              DataCell(_ticketBoxIcons(amc.id.toString(), amc.productName.toString())/*Text(amc.id.toString())*/),
              DataCell(Text(amc.customer.customerName.toString()?? 'N/A')),
              DataCell(Text(amc.amcName ?? 'N/A')),
              DataCell(Text(amc.customer.customerName ?? 'N/A')),
              DataCell(Text('${amc.serviceCompleted ?? 'N/A'}'+'${'/'}'+'${amc.createdBy ?? 'N/A'}')),
              DataCell(Text(amc.serviceAmount.toString())),
              DataCell(Text(amc.selectServiceOccurence ?? 'N/A')),
              DataCell(Text(amc.receivedAmount.toString())),
              DataCell(Text(amc.remainder ?? 'N/A')),
              DataCell(Text(amc.status ?? 'N/A')),
              DataCell( _dropDownValueViews(controller,amc)
                  /*IconButton(onPressed: () {_dropDownValueViews(controller);}, icon: Icon(Icons.more_vert))*/),
              DataCell(_viewDetailsButton(controller, amc)),
              DataCell(_addTicketViewButton(controller)),
            ]);
          }).toList())),
    );
  }


  _viewDetailsButton(AMCScreenController controller, AmcResult amcData) {
    return ElevatedButton(onPressed: () {
      _detailsViewsWidget(controller, amcData);
    },
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor,
          minimumSize: Size(130, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text("View Details",style: MontserratStyles.montserratBoldTextStyle(
    color: whiteColor,
    size: 13,)));
  }

  _addTicketViewButton(AMCScreenController controller) {
    return ElevatedButton(onPressed: () {
      Get.toNamed(AppRoutes.ticketListCreationScreen);
    },
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor,
          minimumSize: Size(130, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text("Add Ticket",style: MontserratStyles.montserratBoldTextStyle(
    color: whiteColor,
    size: 13,)));
  }
}

_dropDownValueViews(AMCScreenController controller, AmcResult amcData){
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child:  PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (String result) {
          switch (result) {
            case 'Edit':
            // Handle edit action
              print('Edit selected');
              break;
            case 'Delete':
            // Handle delete action
              print('Delete selected');
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
           PopupMenuItem<String>(
             onTap: (){_amcDetailsEditWidget(context,controller,amcData);},
            value: 'Edit',
            child: ListTile(
              leading: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.black),
              title: Text('Edit',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,)),
            ),
          ),
           PopupMenuItem<String>(
            value: 'Delete',
            child: ListTile(
              leading: Icon(Icons.delete, size: 20, color: Colors.red),
              title: Text('Delete',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,),
            ),
          ),
           ),
        ],
      ),
    ),
  );
}

Widget _ticketBoxIcons(String ticketId,String text) {
  return Center(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal:8, vertical: 4),
          decoration: BoxDecoration(
            color: normalBlue,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.blue.shade300,
              width: 1,
            ),
          ),
          child: Text(
            '$ticketId',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        Text(text,style: MontserratStyles.montserratSemiBoldTextStyle(size: 12, color: Colors.black),)
      ],
    ),
  );
}

_amcDetailsEditWidget(BuildContext context, AMCScreenController controller, AmcResult amcData){
  controller.amcNameController.text = amcData.amcName ?? '';
  controller.activationTimeController.text = amcData.activationTime ?? '';
  controller.datesController.text = amcData.activationDate ?? '';
  controller.noOfServiceController.text = amcData.noOfService?.toString() ?? '';
  controller.reminderController.text = amcData.remainder ?? '';
  controller.serviceOccurrenceController.text = amcData.selectServiceOccurence ?? '';
  controller.productNameController.text = amcData.productName ?? '';
  controller.productBrandController.text = amcData.productBrand ?? '';
  controller.serialModelNoController.text = amcData.serialModelNo ?? '';
  controller.serviceAmountController.text = amcData.serviceAmount?.toString() ?? '';
  controller.recievedAmountController.text = amcData.receivedAmount?.toString() ?? '';
  controller.customerNameController.text = amcData.customer.customerName ?? '';
  controller.notesController.text = amcData.note ?? '';
   Get.dialog(
      Dialog(
        insetAnimationDuration: Duration(milliseconds: 3),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: _form(context ,controller, amcId),
        ),
      )
  ).toString();
}
_form(BuildContext context, AMCScreenController controller, String amcId){
     return Container(
       height: Get.height,
       width: Get.width,
       color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(children: [
          vGap(20),
          _updateTextName(context),
          Divider(color: Colors.black,thickness: 2,),
          vGap(20),
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
        ],
        ),
      ),
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
    // suffix: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_up_outlined, color: Colors.black)),
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
    suffix: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(children: [
        // logic for increment no and decrement no
        GestureDetector(onTap:(){},child:Icon(Icons.arrow_drop_up_outlined, color: Colors.black),),
        GestureDetector(onTap:(){},child:Icon(Icons.arrow_drop_down_outlined, color: Colors.black),)
        // IconButton(onPressed: (){}, icon:  Icon(Icons.arrow_drop_up_outlined, color: Colors.black)),
        // IconButton(onPressed: (){}, icon:  Icon(Icons.arrow_drop_down_outlined, color: Colors.black)),
      ],),
    ),
  );
}
Widget _buildRecoievedAccount({required BuildContext context}) {
  return CustomTextField(
    hintText: "Received Amount".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Received Amount".tr,
    suffix: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(children: [
        // logic for increment no and decrement no
        GestureDetector(onTap:(){},child:Icon(Icons.arrow_drop_up_outlined, color: Colors.black),),
        GestureDetector(onTap:(){},child:Icon(Icons.arrow_drop_down_outlined, color: Colors.black),)
      ],),
    ),
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
  final controller = Get.find<AMCScreenController>();
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
    hintText: 'Service Occurrence'.tr,
    labletext: 'Service Occurrence'.tr,
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

_updateTextName(BuildContext context){
  return Text('Edit Amc details', style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),);
}



_detailsViewsWidget(AMCScreenController controller, AmcResult amcData) {
  return Get.dialog(
    Dialog(
      child: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "AMC Report Details",
                    style: MontserratStyles.montserratBoldTextStyle(
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Implement download functionality
                    },
                    label: Text(''),
                    icon: Icon(
                      Icons.download,
                      color: appColor,
                    ),
                  )
                ],
              ),
              Divider(height: 20),
              vGap(20),
              Text(
                "Customer Details",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                "Customer Name: ${amcData.customer.customerName ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Customer Number: ${amcData.customer.phoneNumber ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Customer Email: ${amcData.customer.email ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Landmark: ${amcData.customer.landmarkPaci ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Address: ${amcData.customer.primaryAddress ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Divider(height: 20),
              vGap(20),
              Text(
                "Product Details",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                "Product Brand: ${amcData.productBrand ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Product Name: ${amcData.productName ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Serial Number: ${amcData.serialModelNo ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Service Amount: ${amcData.serviceAmount?.toString() ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Remaining Amount: ${amcData.remainder ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Divider(height: 20),
              vGap(20),
              Text(
                "AMC Details",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                "AMC Name: ${amcData.amcName ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Activation Date: ${amcData.activationDate ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Expiry Date: ${amcData.expiry ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "No. of Services: ${amcData.noOfService?.toString() ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Reminder: ${amcData.remainder ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Service Occurrence: ${amcData.selectServiceOccurence ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Service Completed: ${amcData.serviceCompleted ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Status: ${amcData.status ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Divider(height: 20),
              vGap(20),
              Text(
                "Note:\n\n${amcData.note ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              vGap(40),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(backgroundColor: appColor),
                child: Text(
                  "Cancel",
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}