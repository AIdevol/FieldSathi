import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/AgentsViewScreenController.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/agents_list_creation.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../../widgets/views/ticket_list_creation.dart';

class AgentsViewScreen extends GetView<AgentsViewScreenController>{
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(child: SafeArea(child: GetBuilder<AgentsViewScreenController>(builder: (controller)=> Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          'Agents',
          style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
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
      body: ListView(
        children: [
          _viewTopBar(controller),
          SizedBox(height: 20,),
          _dataTableViewScreen(controller),
        ],
      )
    ),)));
  }
}

Widget _viewTopBar(AgentsViewScreenController controller){
  return Container(
    height: Get.height*0.07,
    width: Get.width,
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Grey color
          spreadRadius: 1,
          blurRadius: 5, // How blurry the shadow will be
          offset: Offset(0, 5), // Changes position of shadow (x-axis, y-axis)
        ),
      ],),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: _buildSearchField(controller)),
        hGap(10),
        ElevatedButton(
          onPressed: () =>_showImportModelView(Get.context!),
          child: Text(''
              'Import',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            elevation: WidgetStateProperty.all(5),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
          ),
        ),
        hGap(10),
        ElevatedButton(
          onPressed: () {},
          child: Text('Export',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appColor), // Background color
            foregroundColor: WidgetStateProperty.all(Colors.white), // Text color
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)), // Padding
            elevation: WidgetStateProperty.all(5), // Shadow elevation
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
          ),
        ),
        hGap(10),
        // InkWell(onTap: (){},child: Container(height: 40,width: 120,color:appColor,),)

      ],),
  );
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

_dataTableViewScreen(AgentsViewScreenController controller) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Obx(() => DataTable(
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
      rows: controller.agentsData.map((resultsData) {
        return DataRow(cells: [
          DataCell(Text(resultsData.id?.toString() ?? 'N/A')),
          DataCell(CircleAvatar(
            backgroundImage: resultsData.profileImage != null
                ? NetworkImage(resultsData.profileImage!)
                : AssetImage(userImageIcon) as ImageProvider,
          )),
          DataCell(Text('${resultsData.firstName ?? ''} ${resultsData.lastName ?? ''}'.trim())),
          DataCell(Text(resultsData.email ?? 'N/A')),
          DataCell(Text(resultsData.phoneNumber ?? 'N/A')),
          DataCell(Text(_formatDate(resultsData.dateJoined))
              /*Text(resultsData.dateJoined != null
              ? DateFormat('yyyy-MM-dd').format(resultsData.dateJoined!)
              : 'N/A')*/),
          DataCell(_buildStatusIndicator(resultsData.isActive)),
          DataCell(_dropDownValueViews(controller)),
        ]);
      }).toList(),
    )),
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
      // controller: controller.searchController,
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
        // controller.updateSearch(value);
      },
    ),
  );
}

_dropDownValueViews(AgentsViewScreenController controller){
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
            value: 'Edit',
            onTap: (){_editWidgetOfAgentsDialogValue(controller, context);},
            child: ListTile(
              leading: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.black),
              title: Text('Edit',style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,)),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Deactivate',
            child: ListTile(
              leading: Image.asset(wrongRoundedImage,color: Colors.black,height: 25,width: 25,),
              title: Text('Deactivate',style: MontserratStyles.montserratBoldTextStyle(
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
Widget _buildStatusIndicator(bool isActive) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isActive ? Colors.green : Colors.red,
        width: 1,
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


_editWidgetOfAgentsDialogValue(AgentsViewScreenController controller, BuildContext context){
  Get.dialog(
    Dialog(
      insetAnimationDuration: Duration(milliseconds: 3),
      child:Container(height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: _form(controller, context),) ,
    )
  );
}

_form(AgentsViewScreenController controller, BuildContext context) {
  return Container(
    height: Get.height,
    width: Get.width,
    color: whiteColor,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(children: [
        vGap(40),
        _buildTopBarView(controller: controller, context: context),
        Divider(height: 1,color: Colors.black,),
        vGap(40),
        _buildTaskName(context: context, controller: controller),
        vGap(20),
        _buildLastName(context: context, controller: controller),
        vGap(20),
        _addTechnician(context: context,controller:  controller),
        vGap(20),
        _phoneNumber(context: context, controller:  controller),
        vGap(40),
        _buildOptionbutton(context: context, controller:  controller),

      ],),
    ),

  );
}

_buildTopBarView({required AgentsViewScreenController controller, required BuildContext context}){
  return Center(child: Text('Edit Agent', style: MontserratStyles.montserratBoldTextStyle(size: 25, color: blackColor),));
}
_buildTaskName({required AgentsViewScreenController controller,required BuildContext context}){
  return CustomTextField(
    hintText: "First Name".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.text,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "First Name".tr,
    prefix: Icon(Icons.person, color: Colors.black,),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}
_buildLastName({required AgentsViewScreenController controller,required BuildContext context}){
  return CustomTextField(
    hintText: "last Name".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.text,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "last Name".tr,
    prefix: Icon(Icons.person, color: Colors.black,),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}

_addTechnician({required AgentsViewScreenController controller,required BuildContext context}){
  return CustomTextField(
    hintText: "Email".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.emailAddress,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Email".tr,
    prefix: Icon(Icons.mail, color: Colors.black,),
    // suffix: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.black,),),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}

_phoneNumber({required AgentsViewScreenController controller,required BuildContext context}){
  return CustomTextField(
    hintText: "Phone Number".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.phone,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Phone Number".tr,
    prefix: Icon(Icons.phone_android_rounded, color: Colors.black,),
    // suffix: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.black,),),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}

_buildOptionbutton({required AgentsViewScreenController controller, required BuildContext context}){
  return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel',style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            elevation: WidgetStateProperty.all(5),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
          ),
        ),
        hGap(20),
        ElevatedButton(
          onPressed: () {},
          child: Text('Update',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            elevation: WidgetStateProperty.all(5),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
          ),
        )
      ]
  );
}
//  _activeBeautifullUi(){
//   return Container(height: 60,width: 120,decoration: BoxDecoration(
//     color: Colors.blueAccent,
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.5), // Grey color
//         spreadRadius: 1,
//         blurRadius: 5, // How blurry the shadow will be
//         offset: Offset(0, 5), // Changes position of shadow (x-axis, y-axis)
//       ),
//     ],),
//     child: Text("Active"),);
// }
//
// _inActiveBeautifullUi(){
//   return Container(height: 60,width: 120,decoration: BoxDecoration(
//     color: Colors.redAccent,
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.5), // Grey color
//         spreadRadius: 1,
//         blurRadius: 5, // How blurry the shadow will be
//         offset: Offset(0, 5), // Changes position of shadow (x-axis, y-axis)
//       ),
//     ],),
//     child: Text("InActive"),);
// }