import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/amc_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_amc_view_screen_controller.dart';
import 'package:tms_sathi/response_models/amc_response_model.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/const_local_keys.dart';
import '../../../../constans/string_const.dart';
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
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: CupertinoColors.white,
              bottomNavigationBar: _buildPaginationControls(controller),
              appBar: AppBar(
                leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
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
              body: RefreshIndicator(
                onRefresh: ()=>controller.hitRefreshApiCalls(),
                child: ListView(
                  children: [
                    _buildTopBar(context, controller),
                    vGap(10),
                    _mainData(controller),
                    vGap(10),
                    _dataTableViewScreen(context,controller,amcIds),
                  ],
                ),
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
            ),)
    );
  }

  Widget _mainData(AMCScreenController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150, // Consider making this responsive
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
        controller: controller.searchController,
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
        onChanged: (_) {
          controller.onSearchChanged();
        },
      ),
    );
  }

  Widget _totalAmcWidget(AMCScreenController controller) {
    return Container(
      height: 100,
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
      height: 100,
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
      height: 100,
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
      height: 100,
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

  Widget _buildTopBar(BuildContext context, AMCScreenController controller) {
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
            onPressed: () => _showImportModelView(context, controller),
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
              _downLoadExportModelView(context, controller);// Implement this method in your controller
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

  void _showImportModelView(BuildContext context,AMCScreenController controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: Get.height * 0.8,
                maxWidth: Get.width * 0.8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with close button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Import File',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          splashRadius: 20,
                        ),
                      ],
                    ),
                  ),

                  // Scrollable content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Rules section at the top
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.info_outline, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Import Rules',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                      height: 1.5,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: 'Required Fields:\n',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: '• Customer\'s Name\n'),
                                      TextSpan(text: '• AMC Name\n'),
                                      // TextSpan(
                                      //   text: 'Optional Fields:\n',
                                      //   style: TextStyle(fontWeight: FontWeight.bold),
                                      // ),
                                      // TextSpan(text: '• Landmark'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Additional information or instructions can go here
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.lightbulb_outline, color: Colors.blue),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Upload your file in CSV or Excel format. Make sure all required fields are properly filled.',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // Fixed bottom section with upload button
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border(
                        top: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 48,
                          color: appColor,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                String fileName = result.files.single.name;
                                Get.snackbar(
                                  'Success',
                                  'Selected file: $fileName',
                                  backgroundColor: Colors.green[100],
                                  colorText: Colors.green[800],
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.all(16),
                                );
                                Navigator.of(context).pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.folder_open, color: Colors.white),
                                SizedBox(width: 12),
                                Text(
                                  'Choose File to Import',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
  _buildEmptyState() {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            nullVisualImage,
            width: 300,
            height: 300,
          ),
          Text(
            'No services found',
            style: MontserratStyles.montserratNormalTextStyle(
              // size: 18,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }
  _dataTableViewScreen(BuildContext context,AMCScreenController controller, amcIds) {
    if(controller.amcPaginationData.isEmpty){
      return _buildEmptyState();
    }
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() =>
            DataTable(columns: [
              DataColumn(label: Text('AMC ID/Name')),
              DataColumn(label: Text('Date')),
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
            ], rows: controller.amcPaginationData.map((amc) {
              return DataRow(
                onSelectChanged: (selected){
                  if(selected != null){
                    showAmcHistoryData(context, controller,amc);
                  }
                },
                  cells: [
                DataCell(_ticketBoxIcons(amc.id.toString(), amc.amcName.toString())/*Text(amc.id.toString())*/),
                DataCell(Text(amc.activationDate.toString()?? 'N/A')),
                DataCell(Text(amc.customer?.customerName ?? 'N/A')),
                DataCell(Text('${amc.serviceCompleted ?? 'N/A'}'+'${'/'}'+'${amc.noOfService??""}')),
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
      ),
    );
  }
  Widget _buildPaginationControls(AMCScreenController controller) {
    return Obx(() {
      final totalPages = controller.totalPages.value;
      final currentPage = controller.currentPage.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: currentPage > 1
                ? () => controller.changePage(currentPage - 1)
                : null,
          ),
          Text(
            'Page $currentPage of $totalPages',
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: currentPage < totalPages
                ? () => controller.changePage(currentPage + 1)
                : null,
          ),
        ],
      );
    });
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
        color: CupertinoColors.white,
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
             onTap: ()=>controller.hitAmcDeleteApiCall(amcData.id.toString()),
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
  WidgetsBinding.instance.addPostFrameCallback((_){
    controller.amcNameController.text = amcData.amcName ?? '';
    controller.activationTimeController.text = amcData.activationTime.toString() ?? '';
    controller.datesController.text = amcData.activationDate.toString() ?? '';
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
  });

   Get.dialog(
      Dialog(
        insetAnimationDuration: Duration(milliseconds: 3),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: _form(context ,controller, amcData.id.toString()),
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
          _buildAMCName(context, controller),
          vGap(20),
          _addTimeRange(context, controller),
          vGap(20),
          _dobView(context, controller),
          vGap(20),
          buildNumberOfChoiceField(context, controller),
          vGap(20),
          _buildselectedView(context, controller),
          vGap(20),
          _buildServiceOccurances(context, controller),
          vGap(20),
          _buildProductBrand(context, controller),
          vGap(20),
          _buildProductName(context, controller),
          vGap(20),
          _buildSerialNoModel(context, controller),
          vGap(20),
          _buildServiceAccount(context, controller),
          vGap(20),
          _buildRecoievedAccount(context, controller),
          vGap(20),
          _buildCustomerName(context, controller),
          vGap(20),
          _buildtextContainer(context, controller),
          vGap(20),
          _buildOptionbutton(context, controller, amcId)
        ],
        ),
      ),
     );
}
Widget _buildAMCName(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    controller: controller.amcNameController,
    hintText: "AMC Name".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "AMC Name".tr,
    prefix: Icon(Icons.add_task, color: Colors.black),
  );
}
Widget _buildCustomerName(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    controller: controller.customerNameController,
    hintText: "Customer Name".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Customer Name".tr,
    prefix: Icon(Icons.add_task, color: Colors.black),
  );
}
Widget _buildProductBrand(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    controller: controller.productBrandController,
    hintText: "Product Brand".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Product Brand".tr,
    // suffix: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_up_outlined, color: Colors.black)),
  );
}
Widget _buildProductName(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    controller: controller.productNameController,
    hintText: "Product Name".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Product Name".tr,
    prefix: Icon(Icons.add_task, color: Colors.black),
  );
}
Widget _buildServiceAccount(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    controller: controller.serviceAmountController,
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
Widget _buildRecoievedAccount(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    controller: controller.recievedAmountController,
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
Widget _buildSerialNoModel(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    controller: controller.serialModelNoController,
    hintText: "Serial Model No".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Serial Model No".tr,
    prefix: Icon(Icons.add_task, color: Colors.black),
  );
}
Widget _addTimeRange(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    controller: controller.activationTimeController,
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

Widget _buildOptionbutton(BuildContext context,AMCScreenController controller, amcId) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildButton('Cancel',onPressed: ()=>Get.back()),
      hGap(10),
      _buildButton('Update', onPressed: (){controller.hitUpdateApiCall(amcId);}),
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
Widget _dobView(BuildContext context,AMCScreenController controller) {
  final controller = Get.find<AMCScreenController>();
  return CustomTextField(
    onTap: ()=>controller.selectDate(context),
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

Widget buildNumberOfChoiceField(BuildContext context, AMCScreenController controller) {
  return DropdownButtonFormField<int>(
    focusColor: CupertinoColors.white,
    value: controller.selectedNumberOfService,
    decoration: InputDecoration(
      hintText: 'No. of Service'.tr,
      labelText: 'No. of Service'.tr,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30)
      ),
    ),
    items: List.generate(12, (index) => index + 1)
        .map((number) => DropdownMenuItem(
      value: number,
      child: Text(number.toString()),
    ))
        .toList(),
    onChanged: (value) {
      if (value != null) {
        controller.selectedNumberOfService = value;
        controller.noOfServiceController.text = value.toString();
      }
    },
    validator: (value) {
      if (value == null) {
        return 'Please select number of services'.tr;
      }
      return null;
    },
  );
}

Widget _buildselectedView(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    controller: controller.reminderController,
    hintText: 'Reminder'.tr,
    labletext: 'Reminder'.tr,
    textInputType: TextInputType.text,
    onTap: () {
      FocusScope.of(context).unfocus();
      showReminderDropdown(context,controller);
    } , // Avoid keyboard popping up
      suffix:Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30)
  );
}

Widget _buildServiceOccurances(BuildContext context,AMCScreenController controller) {
  return CustomTextField(
    onTap: (){
      FocusScope.of(context).unfocus();
      showServiceOccurancesDropdown(context,controller);
    },
    controller: controller.serviceOccurrenceController,
    hintText: 'Service Occurrence'.tr,
    labletext: 'Service Occurrence'.tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    suffix: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30)
  );
}

Widget _buildtextContainer(BuildContext context,AMCScreenController controller) {
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
        controller: controller.notesController,
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
                "Customer Number: ${amcData.customer?.phoneNumber ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Customer Email: ${amcData.customer!.email ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Landmark: ${amcData.customer!.landmarkPaci ?? 'N/A'}",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                "Address: ${amcData.customer!.primaryAddress ?? 'N/A'}",
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

void _downLoadExportModelView(BuildContext context, AMCScreenController controller) {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  Future<DateTime?> _selectDate(BuildContext context, {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
    );
    return picked;
  }

  void _handleStartDateSelection() async {
    final picked = await _selectDate(
      context,
      initialDate: startDate ?? DateTime.now(),
      lastDate: endDate ?? DateTime.now(),
    );
    if (picked != null) {
      startDate = picked;
      startDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  void _handleEndDateSelection() async {
    final picked = await _selectDate(
      context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      endDate = picked;
      endDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.8,
            maxWidth: Get.width * 0.8,
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Download AMC Report",
                style: MontserratStyles.montserratBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              divider(color: Colors.grey),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: startDateController,
                      labletext: 'Start Date',
                      hintText: "dd-mm-yyyy",
                      readOnly: true,
                      onTap: _handleStartDateSelection,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "To",
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: endDateController,
                      labletext: 'End Date',
                      hintText: "dd-mm-yyyy",
                      readOnly: true,
                      onTap: _handleEndDateSelection,
                    ),
                  ),
                ],
              ),
              vGap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    context,
                    'Cancel',
                    Icons.cancel,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  _buildActionButton(
                    context,
                    'Download Excel',
                    Icons.download,
                    onTap: () {
                      if (startDate == null || endDate == null) {
                        Get.snackbar(
                          'Error',
                          'Please select both start and end dates',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      // Add your download logic here
                      // You can access the selected dates using startDate and endDate
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}

Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    {required VoidCallback onTap}
    ) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: appColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    onPressed: onTap,
    icon: Icon(icon, size: 18),
    label: Text(
      label,
      style: MontserratStyles.montserratSemiBoldTextStyle(size: 13),
    ),
  );
}

// void _showCustomDropdown(BuildContext context, AMCScreenController controller) {
//   // Create a dropdown overlay
//   final RenderBox textFieldRenderBox = context.findRenderObject() as RenderBox;
//   final size = textFieldRenderBox.size;
//   final position = textFieldRenderBox.localToGlobal(Offset.zero);
//
//   // Calculate screen dimensions to ensure dropdown fits
//   final screenWidth = MediaQuery.of(context).size.width;
//   final screenHeight = MediaQuery.of(context).size.height;
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         contentPadding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         content: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxHeight: 300, // Limit maximum height
//             maxWidth: size.width, // Match text field width
//           ),
//           child: ListView.separated(
//             shrinkWrap: true,
//             itemCount: controller.reminderList.length,
//             separatorBuilder: (context, index) => Divider(height: 1),
//             itemBuilder: (context, index) {
//               final value = controller.reminderList[index];
//               return ListTile(
//                 title: Text(value),
//                 onTap: () {
//                   // Update the text field
//                   controller.reminderController.text = value;
//
//                   // Close the dialog
//                   Navigator.of(context).pop();
//                 },
//               );
//             },
//           ),
//         ),
//       );
//     },
//   );
// }
//
void showServiceOccurancesDropdown(BuildContext context, AMCScreenController controller) {
  // Get the render box of the context to position the dropdown
  final RenderBox renderBox = context.findRenderObject() as RenderBox;
  final Size textFieldSize = renderBox.size;
  final Offset textFieldPosition = renderBox.localToGlobal(Offset.zero);

  // Calculate maximum height for the dropdown (e.g., 200 pixels or 3 items)
  final double maxDropdownHeight = 200;
  final int maxVisibleItems = 3;

  // Show a custom dropdown overlay
  OverlayEntry? overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      left: textFieldPosition.dx,
      top: textFieldPosition.dy + textFieldSize.height,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: textFieldSize.height*45,
          width: textFieldSize.width*3,
          constraints: BoxConstraints(
            maxHeight: maxDropdownHeight,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: controller.serviceOccurenceList.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
            itemBuilder: (context, index) {
              final value = controller.serviceOccurenceList[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Update the text field with selected value
                    controller.serviceOccurrenceController.text = value;

                    // Remove the overlay
                    overlayEntry?.remove();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );

  // Insert the overlay
  Overlay.of(context).insert(overlayEntry);
}
void showReminderDropdown(BuildContext context, AMCScreenController controller, ) {
  // Get the render box of the context to position the dropdown
  final RenderBox renderBox = context.findRenderObject() as RenderBox;
  final Size textFieldSize = renderBox.size;
  final Offset textFieldPosition = renderBox.localToGlobal(Offset.zero);

  // Calculate maximum height for the dropdown (e.g., 200 pixels or 3 items)
  final double maxDropdownHeight = 200;
  final int maxVisibleItems = 3;

  // Show a custom dropdown overlay
  OverlayEntry? overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      left: textFieldPosition.dx,
      top: textFieldPosition.dy + textFieldSize.height,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: textFieldSize.width*3,
          constraints: BoxConstraints(
            maxHeight: maxDropdownHeight,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: controller.reminderList.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
            itemBuilder: (context, index) {
              final value = controller.reminderList[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Update the text field with selected value
                    controller.reminderController.text = value;

                    // Remove the overlay
                    overlayEntry?.remove();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );

  // Insert the overlay
  Overlay.of(context).insert(overlayEntry);
}

Future<void> showAmcHistoryData(BuildContext context, AMCScreenController controller,AmcResult amcData){
  return showDialog(context: context, builder: (context){
    return Dialog(
      child: Container(
        height: Get.height * 0.8,
        width: Get.width*0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Stack(
          children: [
            Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('${amcData.amcName}',style: MontserratStyles.montserratSemiBoldTextStyle(size: 20,color: Colors.black),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${amcData.status}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],) ,
              ),
              vGap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: Get.height*0.1,
                  // width: Get.height*0.4,
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset:Offset(0,1),
                        color: Colors.grey.shade400,
                        spreadRadius: 1
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      vGap(20),
                    Row(
                      children: [
                        Text('Created At:',style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: Colors.black),),
                        vGap(5),
                        Text('${amcData.createdAt}',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                      ],
                    ),
                    vGap(5),
                    Row(
                      children: [
                        Text('Created By:',style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: Colors.black),),
                        vGap(5),
                        Text('${amcData.createdBy}',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                      ],
                    )

                  ],),
                ),
              ),
              vGap(20),
              Text(' Progress History',style: MontserratStyles.montserratSemiBoldTextStyle(size: 20, color: Colors.black),),
              Divider(),
             Obx((){
               return controller.amcHistoryListData.isNotEmpty
                   ? ListView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemCount: controller.amcHistoryListData.length,
                 itemBuilder: (context,index){
                   final amcHistory = controller.amcHistoryListData[index];
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       ListTile(
                         title: Text(
                           "${amcHistory.actionBy}",
                           style: MontserratStyles.montserratSemiBoldTextStyle(
                               size: 16,
                               color: Colors.black
                           ),
                         ),
                         subtitle: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               amcHistory.changeTimestamp.toString(),
                               style: TextStyle(color: Colors.grey),
                             ),
                             Text(
                               amcHistory.actionMessage.toString(),
                               style: TextStyle(color: Colors.blue),
                             ),
                             if (amcHistory.fieldChanges.isNotEmpty)
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: amcHistory.fieldChanges.map((change) =>
                                     Text(
                                       change,
                                       style: TextStyle(color: Colors.green),
                                     )
                                 ).toList(),
                               )
                           ],
                         ),
                       ),
                       Divider(),
                     ],
                   );
                 },

               ):
               Center(
                 child: Text(
                   'No history data available',
                   style: TextStyle(color: Colors.grey),
                 ),
               );
             }),

            ],),

            Positioned(
              bottom: 10,
              right: 10,
              child: _buildActionButton(
                context,
                'Okay',
                Icons.cancel,
                onTap: (){
                  // controller.fetchTicketsApiCall();
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  });
}