import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/technician_list_view_screen_controller.dart';
import 'package:tms_sathi/response_models/technician_response_model.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/string_const.dart';


class TechnicianListViewScreen extends GetView<TechnicianListViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<TechnicianListViewScreenController>(
        builder: (controller) => Scaffold(
          backgroundColor: CupertinoColors.white,
          appBar: _buildAppBar(controller),
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(context,controller),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: _buildDataTableView(controller, context),
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(TechnicianListViewScreenController controller) {
    return AppBar(
      leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
      backgroundColor: appColor,
      elevation: 0,
      title: Text(
        "Technician",
        style: MontserratStyles.montserratBoldTextStyle(
          size: 15,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => controller.refreshList(),
          icon: Icon(FontAwesomeIcons.rotate),
          tooltip: 'Refresh',
        ),
        IconButton(
          onPressed: ()=>Get.toNamed(AppRoutes.addtechnicianListScreen),
          icon: Icon(FontAwesomeIcons.plus),
          tooltip: 'Filter',
        ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context,TechnicianListViewScreenController controller) {
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
            onPressed: () => _showImportModelView(context,controller),
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
              _downLoadExportModelView(context,controller);
            },
            style: _buttonStyle(),
            child: Text(
              'Export',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
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
  Widget _buildDataTableView(TechnicianListViewScreenController controller, BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.paginatedTechnicians.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              columns: [
                _buildTableHeader('Id'),
                _buildTableHeader('Image'),
                _buildTableHeader('Name'),
                _buildTableHeader('Email'),
                _buildTableHeader('Contact'),
                _buildTableHeader('Casual Leaves'),
                _buildTableHeader('Sick Leaves'),
                _buildTableHeader('Check In'),
                _buildTableHeader('Check Out'),
                _buildTableHeader('Status'),
                _buildTableHeader('Battery(%)'),
                _buildTableHeader('GPS'),
                _buildTableHeader('Actions'),
              ],
              rows: controller.paginatedTechnicians.map((technician) {
                return DataRow(
                  cells: [
                    DataCell(_ticketBoxIcons(technician.id.toString(), technician)),
                    DataCell(_technicianImage(technician.id.toString(), technician)),
                    DataCell(Text("${technician.firstName} ${technician.lastName}")),
                    DataCell(Text(technician.email.toString())),
                    DataCell(Text(technician.phoneNumber.toString())),
                    DataCell(Text(technician.allocatedCasualLeave.toString())),
                    DataCell(Text(technician.allocatedSickLeave.toString())),
                    DataCell(Text(_formatDateTime(
                        technician.todayAttendance!.punchIn.toString()?? 'N/A'))),
                    DataCell(Text(_formatDateTime(
                        technician.todayAttendance!.punchOut.toString()?? 'N/A'))),
                    DataCell(_buildAttendanceStatusBadge(
                        technician.todayAttendance!.status?? '')),
                    DataCell(Text(technician.batteryStatus ?? 'N/A')),
                    DataCell(Text(technician!.gpsStatus ? 'On' : 'Off')),
                    DataCell(_dropDownValueViews(controller, context, technician.id.toString(), technician)),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        // Pagination Controls
        _buildPaginationControls(controller),
      ],
    );
  }
  Widget _buildPaginationControls(TechnicianListViewScreenController controller) {
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

  DataColumn _buildTableHeader(String title) {
    return DataColumn(
      label: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListView(TechnicianListViewScreenController controller) {
    // Placeholder for list view if required
    return Center(child: Text("List View will be displayed here"));
  }
}

  Widget _buildAttendanceStatusBadge(String status) {
    Color color;
    String displayText = status;

    switch (status.toLowerCase()) {
      case 'present':
        color = Colors.green;
        break;
      case 'absent':
        color = Colors.red;
        break;
      case 'late':
        color = Colors.orange;
        break;
      case 'on_leave':
        color = Colors.blue;
        displayText = 'On Leave';
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  String _formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateTimeStr;
    }
  }
Widget _dropDownValueViews(TechnicianListViewScreenController controller, BuildContext context,
    String agentId, TechnicianData agentData) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (String result) {
          switch (result) {
            case 'Edit':
              _editWidgetOfAgentsDialogValue(controller, context, agentId, agentData);
              // _editWidgetOfAgentsDialogValue(
              //     controller, Get.context!, agentId, agentData);
              break;
            case 'Delete':
              // controller.hitDeleteStatuApiValue(agentId);
              break;
            case 'Deactivate':
              // controller.hitUpdateStatusValue(agentId);
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
              leading: Icon(Icons.delete, color: Colors.red, size: 20),
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
Widget _ticketBoxIcons(String ticketId, TechnicianData technician) {
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
        '${technician.empId}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    ),
  );
}
Widget _technicianImage(String ticketId, TechnicianData technician) {
  return Center(
    child: Container(
      // padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: normalBlue,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.blue.shade300,
          width: 1,
        ),
      ),
      child: CircleAvatar(radius: 25,backgroundImage: technician.profileImage != null?NetworkImage("${technician.profileImage}"): AssetImage(userImageIcon),)
    ),
  );
}
void _showImportModelView(BuildContext context,TechnicianListViewScreenController controller) {
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
                                    TextSpan(text: '• Name\n'),
                                    TextSpan(text: '• Email\n'),
                                    TextSpan(text: '• Contact Number\n\n'),
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
void _downLoadExportModelView(BuildContext context, TechnicianListViewScreenController controller) {
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
                "Download Technician Report",
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

void _editWidgetOfAgentsDialogValue(TechnicianListViewScreenController controller, BuildContext context, String agentId, TechnicianData agentData) {
  controller.firstNameController.text = agentData.firstName ?? '';
  controller.lastNameController.text = agentData.lastName ?? '';
  controller.emailController.text = agentData.email ?? '';
  controller.phoneController.text = agentData.phoneNumber ?? '';
  controller.joiningDateController.text = agentData.dateJoined??"";
  controller.employeeIdController.text = agentData.empId??"";

  Get.dialog(
      Dialog(
        insetAnimationDuration: Duration(milliseconds: 3),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: _form(controller, context, agentId, agentData),
        ),
      )
  );
}


Widget _form(TechnicianListViewScreenController controller, BuildContext context, String agentId, TechnicianData agentData){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: ListView(
      // controller: ,
        children: [
          vGap(20),
          Text('Edit Technician',style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.black),),
          Divider(color: Colors.black,),
          vGap(20),
          _employeIdField(controller, context,),
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

_employeIdField(TechnicianListViewScreenController controller, BuildContext context){
  return CustomTextField(
    controller: controller.employeeIdController,
    hintText: 'Employee Id',
    labletext: 'Employee Id',
    prefix: Icon(Icons.perm_identity),
    validator: (value){
      if (value == null || value.isEmpty) {
        return 'Please select a Employee Id';
      };
      return null;
    },
  );
}

_joiningDateField(TechnicianListViewScreenController controller, BuildContext context) {
  return CustomTextField(
    controller: controller.joiningDateController,
    hintText: 'Joining date',
    labletext: 'Joining date',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select a joining date';
      }
      return null;
    },
    suffix: IconButton(
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          String formattedDate="${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
          // String formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";  /*YYYY-MM-D*/
          controller.joiningDateController.text = formattedDate;
        }

      },
      icon: Icon(Icons.calendar_month_outlined),
    ),
  );
}


_firstNameField(TechnicianListViewScreenController controller, BuildContext context){
  return CustomTextField(
    controller: controller.firstNameController,
    hintText: 'First Name',
    labletext: 'First Name',
    // prefix: Icon(Icons.),
  );
}

_lastNameField(TechnicianListViewScreenController controller, BuildContext context){
  return CustomTextField(
    controller: controller.lastNameController,
    hintText: 'Last Name',
    labletext: 'Last Name',
    // prefix: Icon(Icons.)

  );
}

_emailField(TechnicianListViewScreenController controller, BuildContext context){
  return CustomTextField(
    controller: controller.emailController,
    hintText: 'Email',
    labletext: 'Email',
    prefix: Icon(Icons.email
    ),
  );
}

_phoneNumberField(TechnicianListViewScreenController controller, BuildContext context){
  return CustomTextField(
    controller: controller.phoneController,
    hintText: 'Phone Number',
    labletext: 'Phone Number',
    textInputType: TextInputType.phone,
    prefix: Icon(Icons.phone
    ),
  );
}

_buildOptionButtons(TechnicianListViewScreenController controller, BuildContext context) {
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
          // controller.hitPostAddSupperApiCallApiCall();
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
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
    elevation: MaterialStateProperty.all(5),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
  );
}
