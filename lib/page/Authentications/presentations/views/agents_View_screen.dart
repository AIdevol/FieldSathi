
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/AgentsViewScreenController.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/amc_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/agents_list_creation.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../response_models/super_user_response_model.dart';

class AgentsViewScreen extends GetView<AgentsViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<AgentsViewScreenController>(
          builder: (controller) =>
              Scaffold(
                  bottomNavigationBar: _buildPaginationControls(controller),
                  backgroundColor: CupertinoColors.white,
                  appBar: AppBar(
                    leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
                    backgroundColor: appColor,
                    title: Text(
                      'Executives',
                      style: MontserratStyles.montserratBoldTextStyle(
                          color: blackColor, size: 15),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => AgentsListCreation());
                        },
                        icon: Icon(FeatherIcons.plus),
                      ).paddingOnly(left: 20.0)
                    ],
                  ),
                  body: RefreshIndicator(
                    onRefresh: ()=>controller.hitRefreshApiData(),
                    child: ListView(
                      children: [
                        _viewTopBar(context,controller),
                        SizedBox(height: 20),
                        _dataTableViewScreen(controller),
                      ],
                    ),
                  )
              ),
        ),
      ),
    );
  }

  Widget _viewTopBar(BuildContext context, AgentsViewScreenController controller) {
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
          Expanded(child: _buildSearchField(controller)),
          hGap(10),
          ElevatedButton(
            onPressed: () => _showImportModelView(context, controller),
            child: Text('Import',
                style: MontserratStyles.montserratBoldTextStyle(
                    color: whiteColor, size: 13)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(appColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              shadowColor: MaterialStateProperty.all(
                  Colors.black.withOpacity(0.5)),
            ),
          ),
          hGap(10),
          ElevatedButton(
            onPressed: ()=>_downLoadExportModelView(context, controller),
            child: Text('Export',
                style: MontserratStyles.montserratBoldTextStyle(
                    color: whiteColor, size: 13)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(appColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              shadowColor: MaterialStateProperty.all(
                  Colors.black.withOpacity(0.5)),
            ),
          ),
          hGap(10),
        ],
      ),
    );
  }

  Widget _buildSearchField(AgentsViewScreenController controller) {
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
          hintText: "Search by name, email, or phone",
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
      ),
    );
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
  Widget _dataTableViewScreen(AgentsViewScreenController controller) {
    if(controller.agentsPaginationsData.isEmpty){
      return _buildEmptyState();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() =>
          DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Profile')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Contact Number')),
              DataColumn(label: Text('Date of joining')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('')),
            ],
            rows: controller.agentsPaginationsData.map((resultsData) {
              return DataRow(
                  cells: [
                    DataCell(
                        _ticketBoxIcons(resultsData.id.toString() ?? 'N/A')),
                    DataCell(CircleAvatar(
                      backgroundImage: resultsData.profileImage != null
                          ? NetworkImage(resultsData.profileImage!)
                          : AssetImage(userImageIcon) as ImageProvider,
                    )),
                    DataCell(Text('${resultsData.firstName ?? ''} ${resultsData
                        .lastName ?? ''}'.trim())),
                    DataCell(Text(resultsData.email ?? 'N/A')),
                    DataCell(Text(resultsData.phoneNumber ?? 'N/A')),
                    DataCell(Text(_formatDate(resultsData.dateJoined))),
                    DataCell(_buildStatusIndicator(resultsData.isActive)),
                    DataCell(_dropDownValueViews(
                        controller, resultsData.id.toString() ?? '',
                        resultsData)),
                  ],
                  // onSelectChanged: (selected) {
                  //   if (selected == true) {
                  //     _editWidgetOfAgentsDialogValue(
                  //         controller, Get.context!,
                  //         resultsData.id.toString() ?? '',
                  //         resultsData);
                  //   }
                  // }
              );
            }).toList(),
          )),
    );
  }
  Widget _buildPaginationControls(AgentsViewScreenController controller) {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First Page Button
          IconButton(
            icon: Icon(Icons.first_page),
            onPressed: controller.currentPage.value > 1
                ? () => controller.goToFirstPage()
                : null,
          ),
          // Previous Page Button
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: controller.currentPage.value > 1
                ? () => controller.previousPage()
                : null,
          ),
          // Page Number Display
          Text(
            'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
            style: TextStyle(fontSize: 16),
          ),
          // Next Page Button
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: controller.currentPage.value < controller.totalPages.value
                ? () => controller.nextPage()
                : null,
          ),
          // Last Page Button
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
  Widget _dropDownValueViews(AgentsViewScreenController controller,
      String agentId, Result agentData) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: PopupMenuButton<String>(
          color: CupertinoColors.white,
          icon: Icon(Icons.more_vert),
          onSelected: (String result) {
            switch (result) {
              case 'Edit':
                _editWidgetOfAgentsDialogValue(
                    controller, Get.context!, agentId, agentData);
                break;
              case 'Delete':
                controller.hitDeleteStatuApiValue(agentId);
                break;
              case 'Deactivate':
                controller.hitUpdateStatusValue(agentId);
                break;
            }
          },
          itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Edit',
              child: ListTile(
                leading: Icon(Icons.edit_calendar_outlined, size: 20,
                    color: Colors.black),
                title: Text(
                    'Edit', style: MontserratStyles.montserratBoldTextStyle(
                  color: blackColor,
                  size: 13,
                )),
              ),
            ),
            PopupMenuItem<String>(
              value: 'Delete',
              child: ListTile(
                leading: Icon(Icons.delete,color: Colors.red,size: 20),
                title: Text('Delete',
                    style: MontserratStyles.montserratBoldTextStyle(
                      color: blackColor,
                      size: 13,
                    )),
              ),
            ),
            PopupMenuItem<String>(
              value: 'Deactivate',
              child: ListTile(
                leading: Image.asset(wrongRoundedImage, color: Colors.black,
                  height: 25,
                  width: 25,),
                title: Text('Deactivate',
                    style: MontserratStyles.montserratBoldTextStyle(
                      color: blackColor,
                      size: 13,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editWidgetOfAgentsDialogValue(AgentsViewScreenController controller,
      BuildContext context, String agentId, Result agentData) {
    controller.firstNameController.text = agentData.firstName ?? '';
    controller.lastNameController.text = agentData.lastName ?? '';
    controller.emailController.text = agentData.email ?? '';
    controller.phoneController.text = agentData.phoneNumber ?? '';

    Get.dialog(
        Dialog(
          insetAnimationDuration: Duration(milliseconds: 3),
          child: Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: _form(controller, context, agentId),
          ),
        )
    );
  }

  Widget _form(AgentsViewScreenController controller, BuildContext context,
      String agentId) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            vGap(20),
            _buildTopBarView(controller: controller, context: context),
            Divider(thickness: 2, color: Colors.black),
            vGap(20),
            _buildTaskName(context: context, controller: controller),
            vGap(20),
            _buildLastName(context: context, controller: controller),
            vGap(20),
            _addTechnician(context: context, controller: controller),
            vGap(20),
            _phoneNumber(context: context, controller: controller),
            vGap(40),
            _buildOptionbutton(
                context: context, controller: controller, agentId: agentId),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBarView(
      {required AgentsViewScreenController controller, required BuildContext context}) {
    return Center(child: Text('Edit Agent',
        style: MontserratStyles.montserratBoldTextStyle(
            size: 18, color: blackColor)));
  }

  Widget _buildTaskName(
      {required AgentsViewScreenController controller, required BuildContext context}) {
    return CustomTextField(
      hintText: "First Name".tr,
      controller: controller.firstNameController,
      textInputType: TextInputType.text,
      focusNode: controller.lastNameFocusNode,
      labletext: "First Name".tr,
      prefix: Icon(Icons.person, color: Colors.black),
    );
  }

  Widget _buildLastName(
      {required AgentsViewScreenController controller, required BuildContext context}) {
    return CustomTextField(
      hintText: "Last Name".tr,
      controller: controller.lastNameController,
      textInputType: TextInputType.text,
      focusNode: controller.emailFocusnode,
      labletext: "Last Name".tr,
      prefix: Icon(Icons.person, color: Colors.black),
    );
  }

  Widget _addTechnician(
      {required AgentsViewScreenController controller, required BuildContext context}) {
    return CustomTextField(
      hintText: "Email".tr,
      controller: controller.emailController,
      textInputType: TextInputType.emailAddress,
      focusNode: controller.phoneFocusNode,
      labletext: "Email".tr,
      prefix: Icon(Icons.mail, color: Colors.black),
    );
  }

  Widget _phoneNumber(
      {required AgentsViewScreenController controller, required BuildContext context}) {
    return CustomTextField(
      hintText: "Phone Number".tr,
      controller: controller.phoneController,
      textInputType: TextInputType.phone,
      focusNode: controller.firstNameFocusNode,
      labletext: "Phone Number".tr,
      prefix: Icon(Icons.phone_android_rounded, color: Colors.black),
    );
  }

  Widget _buildOptionbutton(
      {required AgentsViewScreenController controller, required BuildContext context, required String agentId}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel',
                style: MontserratStyles.montserratBoldTextStyle(
                    color: Colors.white, size: 13)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(appColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              shadowColor: MaterialStateProperty.all(
                  Colors.black.withOpacity(0.5)),
            ),
          ),
          hGap(20),
          ElevatedButton(
            onPressed: () => controller.hitPutAgentsDetailsApiCall(agentId),
            child: Text('Update',
                style: MontserratStyles.montserratBoldTextStyle(
                    color: whiteColor, size: 13)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(appColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              shadowColor: MaterialStateProperty.all(
                  Colors.black.withOpacity(0.5)),
            ),
          )
        ]
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'N/A';
    if (date is DateTime) {
      return DateFormat('yyyy-MM-dd').format(date);
    }
    if (date is String) {
      try {
        final parsedDate = DateTime.parse(date);
        return DateFormat('yyyy-MM-dd').format(parsedDate);
      } catch (e) {
        print('Error parsing date: $e');
        return date;
      }
    }
    return 'N/A';
  }

  Widget _buildStatusIndicator(bool? isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive! ? Colors.green.withOpacity(0.1) : Colors.red
            .withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? Colors.green : Colors.red, width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(width: 6),
          Text(
            isActive ? 'Active' : 'Inactive',
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: isActive ? Colors.green : Colors.red,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showImportModelView(BuildContext context,
      AgentsViewScreenController controller) {
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: '• Name\n'),
                                      TextSpan(text: '• Email\n'),
                                      // TextSpan(text: '• Phone Number\n\n'),
                                      TextSpan(
                                        text: 'Optional Fields:\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: '• Address'),
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
                                Icon(Icons.lightbulb_outline,
                                    color: Colors.blue),
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
                              FilePickerResult? result = await FilePicker
                                  .platform.pickFiles();
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

  Widget _ticketBoxIcons(String ticketId) {
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
          '$ticketId',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

void _downLoadExportModelView(BuildContext context, AgentsViewScreenController controller) {
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
                "Download Executive Report",
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