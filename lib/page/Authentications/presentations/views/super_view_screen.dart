import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/super_view_screen_controller.dart';
import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../response_models/super_user_response_model.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class SuperViewScreen extends GetView<SuperViewScreenController>{
  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<SuperViewScreenController>(builder: (controller)=>Scaffold(
      bottomNavigationBar: _buildPaginationControls(controller),
      appBar: AppBar(
        title: Text("Managers", style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),
        backgroundColor: appColor,
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
        actions: [
          IconButton(onPressed: ()async{
            await controller.refreshSupperData();
          }, icon: Icon(Icons.refresh)),
          IconButton(onPressed: (){
            Get.toNamed(AppRoutes.addSuperuserViewScreen);
          }, icon: Icon(FeatherIcons.plus)),
        ],
      ),
      body: Column(
        children: [
          _viewTopBar(context,controller),
          Expanded(
            child: Obx(() =>
                _mainData(controller)),
          ),
        ],
      ),
    )));
  }
  Widget _viewTopBar(BuildContext context, SuperViewScreenController controller) {
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
  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(appColor),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
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
Widget _buildSearchField(SuperViewScreenController controller) {
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
      onChanged: (value) {
        controller.applyFilter();
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

Widget _mainData(SuperViewScreenController controller){
  // final ticketData = controller.filterePaginationsData.map((value)=>value.todayAttendance)
  if(controller.filterePaginationsData.isEmpty){
    return _buildEmptyState();
  }
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child:  DataTable(columns: const[
      DataColumn(label: Text("Employee Id")),
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Email')),
      DataColumn(label: Text('Phone')),//
      DataColumn(label: Text('Date of Joining')),
      DataColumn(label: Text('Casual Leaves')),
      DataColumn(label: Text('Sick Leaves')),
      DataColumn(label: Text('Check in times')),
      DataColumn(label: Text('Check out times')),
      DataColumn(label: Text('Status')),
      DataColumn(label: Text(" ")),
    ], rows: controller.filterePaginationsData.map((superData){
      final ticketAttendance = superData.todayAttendance.map((value)=> value.punchIn.toString()).toList();
      final ticketAttendance1 = superData.todayAttendance.map((value)=> value.punchOut.toString()).toList();
      return DataRow(cells: [
        DataCell(_ticketBoxIcons(superData.empId.toString()),),
        DataCell(Row(
            children: [
              hGap(8),
              CircleAvatar(
                backgroundImage: superData.profileImage != null
                    ? NetworkImage(superData.profileImage!)
                    : AssetImage(userImageIcon) as ImageProvider,
              ),
              hGap(10),
              Text("${superData.firstName} ${superData.lastName}"),
            ],
          )),
          DataCell(Text(superData.email.toString())),
          DataCell(Text(superData.phoneNumber.toString())),//
          DataCell(Text(superData.dateJoined.toString())),
          DataCell(Text(superData.allocatedCasualLeave.toString())),
          DataCell(Text(superData.allocatedSickLeave.toString())),
          DataCell(Text(ticketAttendance.toString())),
          DataCell(Text(ticketAttendance1.toString())),
          DataCell(_buildStatusIndicator(superData,superData.isActive)),
          DataCell(_dropDownValueViews(controller, SuperUserId, superData))
        ],
        );
    }).toList()
    ),
  );
}

Widget _buildPaginationControls(SuperViewScreenController controller) {
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
Widget _ticketBoxIcons(String ticketId) {
  return Center(
    child: Column(
      children: [
        vGap(12),
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
        // Text(text,style: MontserratStyles.montserratSemiBoldTextStyle(size: 12, color: Colors.black),)
      ],
    ),
  );
}

Widget _buildStatusIndicator(Result superdata,bool? isActive) {
  return Column(
    children: [
      Text("${superdata.todayAttendance.map((value)=>value.status)}",style: MontserratStyles.montserratSemiBoldTextStyle(
       color: Colors.black54,
      ),),

      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive! ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
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
      ),
    ],
  );
}
Widget _dropDownValueViews(SuperViewScreenController controller, String agentId, Result superData) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (String result) {
          switch (result) {
            case 'Edit':
              _editWidgetOfAgentsDialogValue(controller, Get.context!, agentId, superData);
              break;
            case 'Delete':
            // controller.hitUpdateStatusValue(agentId);
              break;
            case 'Deactivate':
              // controller.hitUpdateStatusValue(agentId);
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Edit',
            // onTap: (){
            //   _editWidgetOfAgentsDialogValue(controller, context, agentId, agentData)
            // },
            child: ListTile(
              leading: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.black),
              title: Text('Edit', style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              )),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Delete',
            child: ListTile(
              leading: Icon(Icons.delete, color: Colors.red,size: 20,),
              title: Text('Delete', style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              )),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Deactivate',
            child: ListTile(
              leading: Image.asset(wrongRoundedImage, color: Colors.black, height: 25, width: 25,),
              title: Text('Deactivate', style: MontserratStyles.montserratBoldTextStyle(
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
void _editWidgetOfAgentsDialogValue(SuperViewScreenController controller, BuildContext context, String agentId, Result agentData) {
  controller.employeeIdController.text = agentData.empId??"";
  controller.firstNameController.text = agentData.firstName ?? '';
  controller.lastNameController.text = agentData.lastName ?? '';
  controller.emailController.text = agentData.email ?? '';
  controller.phoneController.text = agentData.phoneNumber ?? '';
  controller.joiningDateController.text = agentData.dateJoined.toString()??"";

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

Widget _form(SuperViewScreenController controller, BuildContext context, String agentId, Result agentData){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: ListView(
      // controller: ,
        children: [
          vGap(20),
          Text('Edit Manager',style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.black),),
          Divider(color: Colors.black,),
          vGap(20),
          _employeIdField(controller, context, agentId, agentData),
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

_employeIdField(SuperViewScreenController controller, BuildContext context, String agentId, Result agentData){
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

_joiningDateField(SuperViewScreenController controller, BuildContext context) {
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


_firstNameField(SuperViewScreenController controller, BuildContext context){
  return CustomTextField(
    controller: controller.firstNameController,
    hintText: 'First Name',
    labletext: 'First Name',
    // prefix: Icon(Icons.),
  );
}

_lastNameField(SuperViewScreenController controller, BuildContext context){
  return CustomTextField(
    controller: controller.lastNameController,
    hintText: 'Last Name',
    labletext: 'Last Name',
    // prefix: Icon(Icons.)

  );
}

_emailField(SuperViewScreenController controller, BuildContext context){
  return CustomTextField(
    controller: controller.emailController,
    hintText: 'Email',
    labletext: 'Email',
    prefix: Icon(Icons.email
    ),
  );
}

_phoneNumberField(SuperViewScreenController controller, BuildContext context){
  return CustomTextField(
    controller: controller.phoneController,
    hintText: 'Phone Number',
    labletext: 'Phone Number',
    textInputType: TextInputType.phone,
    prefix: Icon(Icons.phone
    ),
  );
}

_buildOptionButtons(SuperViewScreenController controller, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
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

void _showImportModelView(BuildContext context,
    SuperViewScreenController controller) {
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

void _downLoadExportModelView(BuildContext context, SuperViewScreenController controller) {
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
                "Download Manager Report",
                style: MontserratStyles.montserratBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                )
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