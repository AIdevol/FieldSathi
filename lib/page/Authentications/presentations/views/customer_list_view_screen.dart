import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/customer_list_view_controller.dart';
import 'package:tms_sathi/response_models/customer_list_response_model.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../navigations/navigation.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../widgets/views/principal_customer_view.dart';
import '../controllers/amc_screen_controller.dart';

class CustomerListViewScreen extends GetView<CustomerListViewController>{

  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<CustomerListViewController>(
          builder: (controller) => Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
              backgroundColor: appColor,
              title: Text(
                'Customer List',
                style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
              ),
              actions: [
                IconButton(onPressed: (){
                  // PrincipalCustomerView();
                  Get.toNamed(AppRoutes.principleCustomerScreen);

                }, icon: Icon(FeatherIcons.plus)).paddingSymmetric(horizontal: 20.0)],
            ),
              body: ListView(children: [
                  _buildTopBar(context, controller),
                vGap(25),
                _dataTableViewScreen(controller),
              ],),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, CustomerListViewController controller) {
    return Container(
      height: Get.height * 0.09,
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
            onPressed: () => _showImportModelView(Get.context!),
            style: _buttonStyle(),
            child: Text(
              'Import',
              style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
            ),
          ),
          hGap(10),
          ElevatedButton(
            onPressed: () =>_downLoadExportModelView(context, controller),
            child: Text(
              'Export',
              style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
            ),
            style: _buttonStyle(),
          ),
          hGap(10),
        ],
      ),
    );
  }
  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(appColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
      elevation: WidgetStateProperty.all(5),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)),
    );
  }
}

Widget _buildSearchField(CustomerListViewController controller) {
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
        // Implement search functionality
      },
    ),
  );
}

Widget _dataTableViewScreen(CustomerListViewController controller){
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Obx(()=> DataTable(
        columns: [
          DataColumn(label: Text('ID',)),
          DataColumn(label: Text('Profile',)),
          DataColumn(label: Text('Customer Name',)),
          DataColumn(label: Text('Company Name',)),
          DataColumn(label: Text('Email',)),
          DataColumn(label: Text('Mobile No.',)),
          DataColumn(label: Text('Address',)),
          DataColumn(label: Text('Region',)),
          DataColumn(label: Text('Model No.',)),
          DataColumn(label: Text('Status',)),
          DataColumn(label: Text('',)),
          DataColumn(label: Text('',))
        ], rows: controller.customerListData.map((customerData){
          return DataRow(cells: [
            DataCell(Text(customerData.id.toString())),
            DataCell(CircleAvatar(
              backgroundImage: customerData.profileImage != null
                  ? NetworkImage(customerData.profileImage!)
                  : AssetImage(userImageIcon) as ImageProvider,
            )),
      DataCell(Text(customerData.customerName.toString())),
      DataCell(Text(customerData.companyName.toString())),
      DataCell(Text(customerData.email.toString())),
      DataCell(Text(customerData.phoneNumber.toString())),
      DataCell(Text(customerData!.primaryAddress.toString()??"None")),
      DataCell(Text(customerData!.region.toString()??"N/A")),
      DataCell(Text(customerData.modelNo.toString())),
      DataCell(_buildStatusIndicator(customerData.isActive)),
      DataCell(IconButton(onPressed: (){},icon: Image.asset(whatsappIcon),)),
      DataCell(IconButton(onPressed: (){
        // _editWidgetOfAgentsDialogValue(controller,customerData.id.toString() as BuildContext,customdata);
      },icon: Icon(Icons.more_vert),)),
      ]);
    }).toList(),
  ),
  )
  );
}
Widget _buildStatusIndicator(bool isActive) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isActive ? Colors.green : Colors.red,width: 1,
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
void _editWidgetOfAgentsDialogValue(CustomerListViewController controller, BuildContext context, String agentId,CustomerData customdata) {
  // controller.firstNameController.text = agentData.firstName ?? '';
  // controller.lastNameController.text = agentData.lastName ?? '';
  // controller.emailController.text = agentData.email ?? '';
  // controller.phoneController.text = agentData.phoneNumber ?? '';

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

Widget _form(CustomerListViewController controller, BuildContext context, String agentId) {
  return Container(
    height: Get.height,
    width: Get.width,
    color: whiteColor,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(
        children: [
          vGap(40),
          _buildTopBarView(controller: controller, context: context),
          Divider(height: 1, color: Colors.black),
          vGap(40),
          _buildTaskName(context: context, controller: controller),
          vGap(20),
          _buildLastName(context: context, controller: controller),
          vGap(20),
          _addTechnician(context: context, controller: controller),
          vGap(20),
          _phoneNumber(context: context, controller: controller),
          vGap(40),
          _buildOptionbutton(context: context, controller: controller, agentId: agentId),
        ],
      ),
    ),
  );
}

Widget _buildTopBarView({required CustomerListViewController controller, required BuildContext context}) {
  return Center(child: Text('Edit Agent', style: MontserratStyles.montserratBoldTextStyle(size: 25, color: blackColor)));
}

Widget _buildTaskName({required CustomerListViewController controller, required BuildContext context}) {
  return CustomTextField(
    hintText: "First Name".tr,
    // controller: controller.firstNameController,
    textInputType: TextInputType.text,
    // focusNode: controller.lastNameFocusNode,
    labletext: "First Name".tr,
    prefix: Icon(Icons.person, color: Colors.black),
  );
}

Widget _buildLastName({required CustomerListViewController controller, required BuildContext context}) {
  return CustomTextField(
    hintText: "Last Name".tr,
    // controller: controller.lastNameController,
    textInputType: TextInputType.text,
    // focusNode: controller.emailFocusnode,
    labletext: "Last Name".tr,
    prefix: Icon(Icons.person, color: Colors.black),
  );
}

Widget _addTechnician({required CustomerListViewController controller, required BuildContext context}) {
  return CustomTextField(
    hintText: "Email".tr,
    // controller: controller.emailController,
    textInputType: TextInputType.emailAddress,
    // focusNode: controller.phoneFocusNode,
    labletext: "Email".tr,
    prefix: Icon(Icons.mail, color: Colors.black),
  );
}

Widget _phoneNumber({required CustomerListViewController controller, required BuildContext context}) {
  return CustomTextField(
    hintText: "Phone Number".tr,
    // controller: controller.phoneController,
    textInputType: TextInputType.phone,
    // focusNode: controller.firstNameFocusNode,
    labletext: "Phone Number".tr,
    prefix: Icon(Icons.phone_android_rounded, color: Colors.black),
  );
}

Widget _buildOptionbutton({required CustomerListViewController controller, required BuildContext context, required String agentId}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel', style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13)),
          style: ButtonStyle(
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
          ),
        ),
        hGap(20),
        ElevatedButton(
          onPressed: () {},/* controller.hitPutAgentsDetailsApiCall(agentId),*/
          child: Text('Update', style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13)),
          style: ButtonStyle(
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


void _showImportModelView(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Import File'),
        content: Container(
          height: Get.height * 0.2,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file, size: 60, color: appColor),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    String fileName = result.files.single.name;
                    Get.snackbar('File Selected', 'You selected: $fileName');
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Select File from Local'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: appColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _downLoadExportModelView(BuildContext context,  CustomerListViewController controller) {
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
                "Download Customer Report",
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