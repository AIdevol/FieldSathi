import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/sales_view_screen_controller.dart';
import 'package:tms_sathi/response_models/sales_response_model.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../navigations/navigation.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';

class SalesViewScreen extends GetView<SalesViewScreenController>{

  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<SalesViewScreenController>(
      init: SalesViewScreenController(),
        builder: (controller)=>
    Scaffold(
      appBar: _buildAppBar(controller),
      body: SafeArea(child: Column(children: [
        _buildTopBar(context, controller),
        Expanded(child: _buildDataTableView(controller, context))
      ],)),
    )));
  }
}
PreferredSizeWidget _buildAppBar(SalesViewScreenController controller) {
  return AppBar(
    leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
    backgroundColor: appColor,
    elevation: 0,
    title: Text(
      "Sales",
      style: MontserratStyles.montserratBoldTextStyle(
        size: 15,
        color: Colors.black,
      ),
    ),
    actions: [
      IconButton(
        onPressed: ()=> controller.hitRefreshGetSalesApiCall(),
        icon: Icon(FontAwesomeIcons.rotate),
        tooltip: 'Refresh',
      ),
      IconButton(
        onPressed: ()=>Get.toNamed(AppRoutes.addSalesListScreen),
        icon: Icon(FontAwesomeIcons.plus),
        tooltip: 'Filter',
      ),
    ],
  );
}
Widget _buildTopBar(BuildContext context,SalesViewScreenController controller) {
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
void _showImportModelView(BuildContext context,SalesViewScreenController controller) {
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
void _downLoadExportModelView(BuildContext context, SalesViewScreenController controller) {
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

Widget _buildDataTableView(SalesViewScreenController controller, BuildContext context){
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SingleChildScrollView(
      child: DataTable(columns: [
        _buildTableHeader('Id'),
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
          rows: controller.salesData.map((f){
        return DataRow(cells: [
        DataCell(_ticketBoxIcons(f.id.toString())),
            DataCell(Text("${f.firstName} ${f.lastName}")),
            DataCell(Text(f.email)),
            DataCell(Text(f.phoneNumber)),
            DataCell(Text(f.allocatedCasualLeave.toString())),
            DataCell(Text(f.allocatedSickLeave.toString())),
            DataCell(Text(_formatDateTime(
            f.todayAttendance?['check_in'] ?? 'N/A'))),
            DataCell(Text(_formatDateTime(
            f.todayAttendance?['check_out'] ?? 'N/A'))),
            DataCell(_buildAttendanceStatusBadge(
            f.todayAttendance?['status'] ?? '')),
            DataCell(Text(f.batteryStatus  ?? 'N/A')),
            DataCell(Text(f.gpsStatus ? 'On' : 'Off')),
            DataCell(_dropDownValueViews(controller,f.id.toString(),f, context))
        ],
            );
      }
       ).toList()),
    ),
  );
}
DataColumn _buildTableHeader(String title) {
  return DataColumn(
    label: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
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
String _formatDateTime(String dateTimeStr) {
  try {
    final dateTime = DateTime.parse(dateTimeStr);
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  } catch (e) {
    return dateTimeStr;
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

Widget _dropDownValueViews(SalesViewScreenController controller,
    String agentId, SalesResutls salesData, BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (String result) {
          switch (result) {
            case 'Edit':
              showDialogBoxForDataUpdating(controller, context, salesData,agentId);
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

Future<void> showDialogBoxForDataUpdating(
    SalesViewScreenController controller,
    BuildContext context,
    SalesResutls salesData,
    String agentId,
    ) {
  controller.initializeWithSalesData(salesData);

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      insetPadding: EdgeInsets.all(20),
      child: _form(controller, context, salesData, agentId),
    ),
  ).then((_) {
    controller.clearFormData();
  });
}

// Update the _form widget
Widget _form(
    SalesViewScreenController controller,
    BuildContext context,
    SalesResutls salesData,
    String agentId,
    ) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Edit User",
                style: MontserratStyles.montserratBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          Divider(color: Colors.black),
          vGap(20),
          _buildEmployeeId(controller),
          vGap(20),
          _buildDateOfJoining(controller, context),
          vGap(20),
          _buildFirstName(controller),
          vGap(20),
          _buildLastName(controller),
          vGap(20),
          _buildEmail(controller),
          vGap(20),
          _buildPhoneNumber(controller),
          vGap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Get.back(),
                style: _buttonStyle(),
                child: Text(
                  'Cancel',
                  style: MontserratStyles.montserratBoldTextStyle(
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
              hGap(20),
              ElevatedButton(
                onPressed: () => controller.updateSalesData(salesData, agentId),
                style: _buttonStyle(),
                child: Text(
                  'Update',
                  style: MontserratStyles.montserratBoldTextStyle(
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildOptionButtons(SalesViewScreenController controller, SalesResutls salesData, String agentId) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton(
        onPressed: () => Get.back(),
        child: Text(
          'Cancel',
          style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),
        ),
        style: _buttonStyle(),
      ),
      hGap(20),
      ElevatedButton(
        onPressed: () {
          // Call the update API with the updated controller data and agentId
          // controller.updateSalesData(salesData, agentId);
        },
        child: Text(
          'Submit',
          style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
        ),
        style: _buttonStyle(),
      ),
    ],
  );
}


Widget _buildEmployeeId(SalesViewScreenController controller) {
  return CustomTextField(
    hintText: "Employee Id".tr,
    controller: controller.employeeIdController,
    textInputType: TextInputType.text,
    focusNode: controller.firstFocusNode,
    onFieldSubmitted: (_) => _shiftFocus(controller.lastFocusNode),
    labletext: "Employee Id".tr,
    prefix: Icon(Icons.person, color: Colors.black),
  );
}

Widget _buildDateOfJoining(SalesViewScreenController controller, BuildContext context) {
  return CustomTextField(
    hintText: "dd-mm-yyyy".tr,
    controller: controller.dateJoiningController,
    textInputType: TextInputType.datetime,
    labletext: "Date of Joining".tr,
    onTap: () => controller.selectDate(context),
    suffix: IconButton(
      onPressed: () => controller.selectDate(context),
      icon: Icon(Icons.calendar_month, color: Colors.black),
    ),
  );
}

Widget _buildFirstName(SalesViewScreenController controller) {
  return CustomTextField(
    hintText: "First Name".tr,
    controller: controller.firstNameController,
    textInputType: TextInputType.text,
    focusNode: controller.firstFocusNode,
    onFieldSubmitted: (_) => _shiftFocus(controller.lastFocusNode),
    labletext: "First Name".tr,
    prefix: Icon(Icons.person, color: Colors.black),
  );
}

Widget _buildLastName(SalesViewScreenController controller) {
  return CustomTextField(
    hintText: "Last Name".tr,
    controller: controller.lastNameController,
    textInputType: TextInputType.text,
    focusNode: controller.lastFocusNode,
    onFieldSubmitted: (_) => _shiftFocus(controller.emailFocusNode),
    labletext: "Last Name".tr,
    prefix: Icon(Icons.person, color: Colors.black),
  );
}

Widget _buildEmail(SalesViewScreenController controller) {
  return CustomTextField(
    hintText: "Email".tr,
    controller: controller.emailController,
    textInputType: TextInputType.emailAddress,
    focusNode: controller.emailFocusNode,
    onFieldSubmitted: (_) => _shiftFocus(controller.phoneFocusNode),
    labletext: "Email".tr,
    prefix: Icon(Icons.mail, color: Colors.black),
  );
}

Widget _buildPhoneNumber(SalesViewScreenController controller) {
  return CustomTextField(
    hintText: "Phone Number".tr,
    controller: controller.phoneController,
    textInputType: TextInputType.phone,
    focusNode: controller.phoneFocusNode,
    labletext: "Phone Number".tr,
    prefix: Icon(Icons.phone_android_rounded, color: Colors.black),
  );
}

/*Widget _buildOptionButtons(SalesViewScreenController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton(
        onPressed: () => Get.back(),
        child: Text(
          'Cancel',
          style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),
        ),
        style: _buttonStyle(),
      ),
      hGap(20),
      ElevatedButton(
        onPressed: () {
          // Ensure API call or logic is implemented here.
          // controller.hitAddTechnicianApiCall();
        },
        child: Text(
          'Submit',
          style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
        ),
        style: _buttonStyle(),
      ),
    ],
  );
}*/

// ButtonStyle _buttonStyle() {
//   return ButtonStyle(
//     backgroundColor: MaterialStateProperty.all(appColor),
//     foregroundColor: MaterialStateProperty.all(Colors.white),
//     padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
//     elevation: MaterialStateProperty.all(3),
//     shape: MaterialStateProperty.all(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//     ),
//   );
// }

void _shiftFocus(FocusNode? nextFocusNode) {
  if (nextFocusNode != null) {
    FocusScope.of(Get.context!).requestFocus(nextFocusNode);
  }
}
