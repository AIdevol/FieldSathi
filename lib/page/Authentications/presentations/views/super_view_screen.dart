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
        actions: [IconButton(onPressed: (){}, icon: Icon(FeatherIcons.search)),
          IconButton(onPressed: (){
            Get.toNamed(AppRoutes.addSuperuserViewScreen);
          }, icon: Icon(FeatherIcons.plus))],
      ),
      body: Column(
        children: [
          _buildTopBar(controller),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? Center(child: Container())
                : _mainData(controller)),
          ),
        ],
      ),
    )));
  }
  Widget _buildTopBar(SuperViewScreenController controller) {
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
          // _buildSearchBar(controller),
          hGap(10),
          ElevatedButton(
            onPressed: () => _showImportModelView(Get.context!),
            style: _buttonStyle(),
            child: Text(
              'Import',
              style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
            ),
          ),
          hGap(30),
          ElevatedButton(
            onPressed: () {},
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
                backgroundImage: (superData.profileImage != null && superData.profileImage!.isNotEmpty)
                    ?AssetImage(userImageIcon)
                    :null,
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
