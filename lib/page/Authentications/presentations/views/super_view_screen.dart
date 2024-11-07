import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/super_view_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class SuperViewScreen extends GetView<SuperViewScreenController>{
  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<SuperViewScreenController>(builder: (controller)=>Scaffold(
      appBar: AppBar(
        title: Text("Managers", style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),
        backgroundColor: appColor,
        actions: [
          IconButton(onPressed: (){
            Get.toNamed(AppRoutes.addSuperuserViewScreen);
          }, icon: Icon(FeatherIcons.plus))],
      ),
      body: Column(
        children: [
          _viewTopBar(context,controller),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? Center(child: Container())
                : _mainData(controller)),
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
            onPressed: () {},
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
Widget _mainData(SuperViewScreenController controller){
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child:  DataTable(columns: const[
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Email')),
      DataColumn(label: Text('Contact Number')),
      DataColumn(label: Text('Status')),
      DataColumn(label: Text(" ")),
    ], rows: controller.filteredData.map((superData){
        return DataRow(cells: [
          DataCell(Row(
            children: [
              CircleAvatar(
                backgroundImage: superData.profileImage != null
                    ? NetworkImage(superData.profileImage!)
                    : AssetImage(userImageIcon) as ImageProvider,
              ),
              hGap(10),
              Text("${superData.firstName} ${superData.lastName}"),
            ],
          )),
          DataCell(Text(superData.email)),
          DataCell(Text(superData.phoneNumber)),
          DataCell(_buildStatusIndicator(superData.isActive)),
          DataCell(_dropDownValueViews(controller, SuperUserId))
        ],
        );
    }).toList()
    ),
  );
  //   return SingleChildScrollView(
  //   scrollDirection: Axis.horizontal,
  //   child: DataTable(
  //     columns:const [
  //       DataColumn(label: Text('Name')),
  //       DataColumn(label: Text('Phone')),
  //       DataColumn(label: Text('Profile')),
  //       DataColumn(label: Text('From Date')),
  //       DataColumn(label: Text('To Date')),
  //       DataColumn(label: Text('Days')),
  //       DataColumn(label: Text('Reason')),
  //       DataColumn(label: Text('Status')),
  //       DataColumn(label: Text('Actions')),
  //     ],
  //     rows: controller.filteredLeaves.map((leave) {
  //       return DataRow(
  //         cells: [
  //           DataCell(Text('${leave.userId.firstName} ${leave.userId.lastName}')),
  //           DataCell(Text(leave.userId.phoneNumber)),
  //           DataCell(Text(leave.userId.role)),
  //           // DataCell(Text(controller.formatDate(leave.startDate))),
  //           // DataCell(Text(controller.formatDate(leave.endDate))),
  //           // DataCell(Text(controller.calculateDays(leave.startDate, leave.endDate).toString())),
  //           DataCell(Text(leave.reason)),
  //           DataCell(Text(leave.status)),
  //           DataCell(
  //             IconButton(
  //               icon: Icon(Icons.info),
  //               onPressed: () =>/* controller.showLeaveDetails(leave)*/,
  //             ),
  //           ),
  //         ],
  //       );
  //     }).toList(),
  //   ),
  // );
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
Widget _dropDownValueViews(SuperViewScreenController controller, String agentId) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (String result) {
          switch (result) {
            case 'Edit':
              // _editWidgetOfAgentsDialogValue(controller, Get.context!, agentId, agentData);
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
// void _editWidgetOfAgentsDialogValue(SuperViewScreenController controller, BuildContext context, String agentId, Result agentData) {
//   controller.firstNameController.text = agentData.firstName ?? '';
//   controller.lastNameController.text = agentData.lastName ?? '';
//   controller.emailController.text = agentData.email ?? '';
//   controller.phoneController.text = agentData.phoneNumber ?? '';
//
//   Get.dialog(
//       Dialog(
//         insetAnimationDuration: Duration(milliseconds: 3),
//         child: Container(
//           height: Get.height,
//           width: Get.width,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//           child: _form(controller, context, agentId),
//         ),
//       )
//   );
// }
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
