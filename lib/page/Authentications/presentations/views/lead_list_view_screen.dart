import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/lead_list_view_controller.dart';
import 'package:tms_sathi/response_models/lead_response_model.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constans/role_based_keys.dart';
import '../../../../main.dart';
import '../../../../utilities/common_textFields.dart';

class LeadListViewScreen extends GetView<LeadListViewController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<LeadListViewController>(
        builder: (controller) => Scaffold(
          backgroundColor: CupertinoColors.white,
          floatingActionButton: _buildFloatingActionButton(),
          bottomNavigationBar: _buildPaginationControls(controller),
          appBar: AppBar(
            backgroundColor: appColor,
            leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
            title: Text(
              'Lead List',
              style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       Get.toNamed(AppRoutes.leadFormFieldScreen);
            //     },
            //     icon: Icon(FeatherIcons.plus, size: 24, color: Colors.black),
            //   ).paddingSymmetric(horizontal: 20.0)
            // ],
          ),
          body: Column(
            children: [
              _buildTopBar(context, controller),
              Expanded(
                child: _mainDataAnalytics(controller, context),
              ),

            ],
          ),
        ),
      ),
    );
  }
  FloatingActionButton? _buildFloatingActionButton() {
    final userrole = storage.read(userRole);
    return (userrole != 'technician'&&userrole !='sale')?
    FloatingActionButton(
      onPressed: () =>Get.toNamed(AppRoutes.leadFormFieldScreen),
      backgroundColor: appColor,
      child: Icon(Icons.add, color: Colors.white),
    )
        : null;
  }
  Widget _buildTopBar(BuildContext context, LeadListViewController controller) {
    return Container(
      height: Get.height * 0.15,
      width: Get.width,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          vGap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _buildSearchField(controller)),
              _buildButton('Import', () => _showImportModelView(context, controller)),
              hGap(10),
              _buildButton('Export', () => _downLoadExportModelView(context, controller)),
              hGap(10),
            ],
          ),
          // vGap(10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _buildSelectStatusWidget(),
                ),
                hGap(10),
                Expanded(child: _buildSelectDateWidget()
                ),
            ],),
          )

        ],
      ),
    );
  }

  _buildSelectStatusWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
            () => DropdownButton<String>(
              dropdownColor: Colors.white,
              value: controller.dropdownValue.value,
          // isExpanded: true,
          underline: Container(),
          items: controller.leadStatusValue.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 13,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: controller.updateSelectedStatusFilter,
        ),
      ),
    );
  }
  _buildSelectDateWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
            () => DropdownButton<String>(
              dropdownColor: Colors.white,
          value: controller.dropdownDateValue.value,
          isExpanded: true,
          underline: Container(),
          items: controller.leadDateWiseValue.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 13,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: controller.updateSelectedDateFilter,
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: whiteColor,
        backgroundColor: appColor,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
      child: Text(
        text,
        style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 14),
      ),
    );
  }

  Widget _mainDataAnalytics(LeadListViewController controller, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          vGap(20),
          _buildHorizontalScrollableContainers(controller),
          vGap(20),
           _dataTableViewScreen(controller: controller,context: context),
        ],
      ),
    );
  }

  Widget _buildHorizontalScrollableContainers(LeadListViewController controller) {
    return Container(
      height: Get.height * 0.2,
      child: Obx(()=>ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        children: [
          _buildAnalyticsContainer('Inactive', controller.InActiveValue.value, Colors.blue.shade300),
          _buildAnalyticsContainer('Intract', controller.IntractValue.value, Colors.greenAccent.shade100),
          _buildAnalyticsContainer('In-Discussion',controller.IndiscussionValue.value, Colors.red.shade200),
          _buildAnalyticsContainer('Quote Sent', controller.QuoteSentValue.value, lightBlue),
          _buildAnalyticsContainer('Service Taken', controller.ServiceTakenValue.value, lighthardGreen),
          // vGap(10),
          _buildAnalyticsContainer('Not Interested', controller.NoInterestedValue.value, lightcream),
          // vGap(10),

        ],
      ),)
    );
  }

  Widget _buildSearchField(LeadListViewController controller) {
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
          controller.applyFilter();
        },
      ),
    );
  }
  
  Widget _buildAnalyticsContainer(String title, String value, Color color) {
    return Container(
      height: Get.height * 0.15,
      width: Get.width * 0.4,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: MontserratStyles.montserratBoldTextStyle(size: 16, color: Colors.white),
          ),
          vGap(10),
          Text(
            value,
            style: MontserratStyles.montserratBoldTextStyle(size: 24, color: Colors.white),
          ),
        ],
      ),
    );
  }
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
_dataTableViewScreen({required LeadListViewController controller, required BuildContext context}){
  if(controller.leadPaginationsData.isEmpty){
    return _buildEmptyState();
  }
  return Obx((){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columns: [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Company Name')),
        DataColumn(label: Text('Source')),
        DataColumn(label: Text('Since')),
        DataColumn(label: Text('Mobile No.')),
        DataColumn(label: Text('Address')),
        DataColumn(label: Text('Remark')),
        DataColumn(label: Text('Next Update')),
        DataColumn(label: Text('Lead Status')),
        DataColumn(label: Text(' ')),
        DataColumn(label: Text('')),
      ], rows: controller.leadPaginationsData.map((leadData)=>
           DataRow(cells: [
             DataCell(_ticketBoxIcons(leadData.id.toString())/*Text("${leadData.id.toString()}")*/),
             DataCell(Text("${leadData.firstName.toString() +" "+ leadData.lastName.toString()}")),
             DataCell(Text("${leadData.companyName.toString()}")),
             DataCell(Text(leadData.source.toString())),
             DataCell(Text(leadData.createdAt.toString())),
            DataCell(Text(leadData.mobile.toString())),
            DataCell(Text(leadData.address.toString())),
             DataCell(Text(leadData.notes.toString())),
            DataCell(Text(leadData.nextInteraction.toString())),
            DataCell(Text(leadData.status.toString())),
            DataCell(_rowIconButtonData(controller, context,leadData)),
            DataCell(_viewDetailsButton(controller, leadData))
      ])).toList(),
      ),
    );
  });
}

Widget _buildPaginationControls(LeadListViewController controller) {
  return Obx(() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.first_page),
          onPressed: controller.currentPage.value > 1
              ? () => controller.goToFirstPage()
              : null,
        ),
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: controller.currentPage.value > 1
              ? () => controller.previousPage()
              : null,
        ),
        Text(
          'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: controller.currentPage.value < controller.totalPages.value
              ? () => controller.nextPage()
              : null,
        ),
        IconButton(
          icon: Icon(Icons.last_page),
          onPressed: controller.currentPage.value < controller.totalPages.value
              ? () => controller.goToLastPage()
              : null,
        ),
      ],
    ),
  ));
}
// void _showImportModelView(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         title: Text('Import File', style: MontserratStyles.montserratBoldTextStyle(size: 20)),
//         content: Container(
//           height: Get.height * 0.2,
//           width: Get.width * 0.8,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.upload_file, size: 60, color: appColor),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                   if (result != null) {
//                     String fileName = result.files.single.name;
//                     Get.back();
//                     Get.snackbar('File Selected', 'You selected: $fileName',
//                         snackPosition: SnackPosition.BOTTOM,
//                         backgroundColor: appColor,
//                         colorText: Colors.white);
//                   }
//                 },
//                 child: Text('Select File', style: TextStyle(fontSize: 16)),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: appColor,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
_viewDetailsButton(LeadListViewController controller, LeadResult leadStatus) {
  final leadStatusData = leadStatus.status??"Inactive";
  return ElevatedButton(onPressed: () {
    showModelViewDetailsWidgets(controller, leadStatusData);
  },
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        minimumSize: Size(130, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Update Status",style: MontserratStyles.montserratBoldTextStyle(
        color: whiteColor,
        size: 13,)));
}


_rowIconButtonData(LeadListViewController controller,BuildContext context,LeadResult leadMobile,){
  return Row(children: [
    GestureDetector(onTap: ()async{
      final Uri url = Uri.parse('https://wa.me/91${leadMobile.mobile}');
        if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
        }
      print("helloo brother And you mobile No ishttps://wa.me/91${leadMobile.mobile}");
  },child: Image.asset(whatsappIcon, fit: BoxFit.cover,height: 25, width: 25,),),
    GestureDetector(onTap: (){
      showModelEditwidget(controller, context, leadMobile);
    },child: Icon(Icons.edit),),
    GestureDetector(onTap: (){controller.hitDeleteLeadListApiCall(leadMobile.id.toString());},child: Icon(Icons.delete, color: Colors.red,),)
  ],);
}

void _downLoadExportModelView(BuildContext context,  LeadListViewController controller) {
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
                "Download Report",
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
                    'Close',
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

Widget _ticketBoxIcons(String? leadId) {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: normalBlue,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.blue.shade300,
          width: 1,
        ),
      ),
      child: Text(
        leadId?.isNotEmpty == true ? leadId! : 'NA',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    ),
  );
}

void _showImportModelView(BuildContext context,LeadListViewController controller) {
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
                                    'Rule',
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
                                      text: 'Compulsory Field:\n',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: '• Customer Name\n'),
                                    TextSpan(text: '• Address\n'),
                                    // TextSpan(text: '• Phone Number\n\n'),
                                    TextSpan(
                                      text: 'Optional Fields:\n',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: '• Landmark'),
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
                                'Choose File',
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

void showModelViewDetailsWidgets(
    LeadListViewController controller, String? leadStatus) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: Get.height * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Update Status",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: Colors.black54, height: 20),
              const SizedBox(height: 20),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: controller.dropdownValue.value,
                  decoration: InputDecoration(
                    labelText: "Select Status",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                  ),
                  items: controller.leadStatusValue.value
                      .map(
                        (String? leadstatus) => DropdownMenuItem(
                      value: leadstatus,
                      child: Text(leadstatus!),
                    ),
                  )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      controller.dropdownValue.value = value;
                    }
                  },
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                  child: viewDetailsButton(controller)),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Implement view details functionality
              //     },
              //     style: ElevatedButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //     ),
              //     child: Text("View Details"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ),
  );
}


Widget viewDetailsButton(LeadListViewController controller,/* LeadResult leadStatu*/) {
  // final leadStatusData = leadStatus.status??"Inactive";
  return ElevatedButton(onPressed: () {

  },
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        minimumSize: Size(130, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Update",style: MontserratStyles.montserratBoldTextStyle(
        color: whiteColor,
        size: 13,)));
}

void showModelEditwidget(LeadListViewController controller,BuildContext context, LeadResult leadMobile, ){
   Get.dialog(Dialog(
     child:_formEdit(controller, context, leadMobile),
   ));
}

_formEdit(LeadListViewController controller, BuildContext context, LeadResult leadMobile){
  controller.companyController.text = leadMobile.companyName ?? 'N/A';
  controller.firstNameController.text = leadMobile.firstName ?? 'N/A';
  controller.lastNameController.text = leadMobile.lastName ?? 'N/A';
  controller.emailController.text = leadMobile.email ?? 'N/A';
  controller.phoneController.text = leadMobile.mobile ?? 'N/A';
  controller.addressController.text = leadMobile.address ?? 'N/A';
  controller.countryController.text = leadMobile.country ?? 'N/A';
  controller.stateController.text = leadMobile.state ?? 'N/A';
  controller.cityController.text = leadMobile.city ?? 'N/A';
  controller.additionalNotesController.text = leadMobile.notes ?? 'N/A';
  controller.sourceController.text = leadMobile.source ?? 'N/A';
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: ListView(children: [
      vGap(20),
      Text("Basics Informations",style: MontserratStyles.montserratBoldTextStyle(size: 20, color: Colors.black),),
      Divider(color: Colors.black,),
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
      _customButtonViewWidget(controller,context,leadMobile),
      vGap(20),
    ],),
  );
}

_customerCompanyContainer(LeadListViewController controller){
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
_customerFirstNameContainer(LeadListViewController controller){
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

_customerLastNameContainer(LeadListViewController controller){
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
_customerEmailContainer(LeadListViewController controller){
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

_customerPhoneContainer(LeadListViewController controller){
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
_customerAddressContainer(LeadListViewController controller){
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
_customerCountryContainer(LeadListViewController controller){
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
_customerStateContainer(LeadListViewController controller){
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
_customerCityContainer(LeadListViewController controller){
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

_customerAdditionalContainer(LeadListViewController controller){
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

_customerSourceContainer(LeadListViewController controller){
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

Widget _customButtonViewWidget( LeadListViewController controller,BuildContext context,LeadResult leadMobile) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildButton('Cancel',onPressed: ()=>Get.back(), controller: controller),
      hGap(10),
      _buildButton('Update', onPressed: ()=>controller.hitLeadPutMethodApiCall(leadMobile.id.toString()), controller:  controller),
      hGap(10),
      // _buildRateTextField(),
    ],
  );
}

Widget _buildButton(String text,{required LeadListViewController controller,required onPressed}) {
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