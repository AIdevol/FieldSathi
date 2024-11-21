import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/customer_list_view_controller.dart';
import 'package:tms_sathi/response_models/customer_list_response_model.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
                _dataTableViewScreen(controller, context),
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

Widget _dataTableViewScreen(CustomerListViewController controller, BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Obx(() => DataTable(
      columnSpacing: 20, // Add consistent spacing between columns
      columns: [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Profile')),
        DataColumn(label: Text('Customer Name')),
        DataColumn(label: Text('Company Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Mobile No.')),
        DataColumn(label: Text('Address')),
        DataColumn(label: Text('Region')),
        DataColumn(label: Text('Model No.')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Container(width: 50, child: Text('Action'))), // Fixed width for action column
        DataColumn(label: Container(width: 50, child: Text(''))), // Fixed width for more options
      ],
      rows: controller.customerListData.map((customerData) {
        return DataRow(cells: [
          DataCell(_ticketBoxIcons(customerData.id.toString())),
          DataCell(CircleAvatar(
            radius: 15,
            backgroundImage: customerData.profileImage != null
                ? NetworkImage(customerData.profileImage!)
                : AssetImage(userImageIcon) as ImageProvider,
          )),
          DataCell(Text(customerData.customerName.toString())),
          DataCell(Text(customerData.companyName.toString())),
          DataCell(Text(customerData.email.toString())),
          DataCell(Text(customerData.phoneNumber.toString())),
          DataCell(Text(customerData.primaryAddress?.toString() ?? "None")),
          DataCell(Text(customerData.region?.toString() ?? "N/A")),
          DataCell(Text(customerData.modelNo.toString())),
          DataCell(_buildStatusIndicator(customerData.isActive)),
          DataCell(Container(
            width: 50,
            alignment: Alignment.center,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () async{
                final Uri url = Uri.parse('https://wa.me/91${customerData.phoneNumber}');
                if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
                }
              },
              icon: Image.asset(whatsappIcon, width: 24, height: 24),
            ),
          )),
          DataCell(Container(
            width: 50,
            alignment: Alignment.center,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                _editWidgetOfAgentsDialogValue(controller, context, customerData.id.toString(), customerData);
              },
              icon: Icon(Icons.more_vert, size: 24),
            ),
          )),
        ]);
      }).toList(),
    )),
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
Widget _ticketBoxIcons(String? ticketId) {
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
        ticketId?.isNotEmpty == true ? ticketId! : 'NA',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    ),
  );
}
void _editWidgetOfAgentsDialogValue(CustomerListViewController controller, BuildContext context, String agentId,CustomerData customdata) {

  Get.dialog(
      Dialog(
        insetAnimationDuration: Duration(milliseconds: 3),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: _form(controller, context, agentId,customdata),
        ),
      )
  );
}
Widget _form(CustomerListViewController controller, BuildContext context, String? agentId, CustomerData customData) {
  WidgetsBinding.instance.addPostFrameCallback((_){
    controller.customerNameController.text = customData.customerName ?? '';
  controller.phoneController.text = customData.phoneNumber ?? '';
  controller.emailController.text = customData.email ?? '';
    controller.companyNameController.text = customData.companyName ?? '';
    controller.modelNoController.text = customData.modelNo ?? '';
    // controller.productTypeController.text = customData. ?? '';
    controller.addressNameController.text = customData.primaryAddress ?? '';
    controller.landMarkController.text = customData.landmarkPaci ?? '';
    controller.cityController.text = customData.city ?? '';
    controller.stateController.text = customData.state ?? '';
    controller.zipController.text = customData.zipcode ?? '';
    controller.countryController.text = customData.country ?? '';
    controller.selectedRegionController.text = customData.region ?? '';
  });
  return Container(
    height: Get.height,
    width: Get.width,
    color: whiteColor,
    // decoration: BoxDecoration(
    //   borderRadius: BorderRadius.circular(20)
    // ),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(
        children: [
          vGap(20),
          _buildCustomerName(controller,context),
          vGap(20),
          _buildMobileNoTextContainer(controller,context),
          vGap(20),
          _buildEmailIdContainer(controller,context),
          vGap(20),
          _buildCompanyName(controller,context),
          vGap(20),
          _buildModeNoContainer(controller,context),
          vGap(20),
          ProductTypeBuilder(),
          vGap(20),
          Container(
            alignment: Alignment.center,
            height: Get.height*0.03,
            width: Get.width*4,
            color: Colors.grey,
            child: Text("Address", style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.black),),
          ),
          vGap(20),
          _buildAddressName(controller,context),
          vGap(20),
          _buildLandMarkName(controller,context),
          vGap(20),
          _buildCityName(controller,context),
          vGap(20),
          _buildStateName(controller,context),
          vGap(20),
          _buildzipcode(controller,context),
          vGap(20),
          _countryView(controller,context),
          vGap(20),
          _buildSelectedRegion(controller,context),
          vGap(20),
          _buildOptionbutton(controller,context)
        ],
      ),
    ),
  );
}


Widget _buildCustomerName(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Customer Name".tr,
    controller: controller.customerNameController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Customer Name".tr,
    prefix: Icon(Icons.person, color: Colors.black),
  );
}

Widget _buildMobileNoTextContainer(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Mobile No".tr,
    controller: controller.phoneController,
    textInputType: TextInputType.phone,
    onFieldSubmitted: (String? value) {},
    labletext: "Mobile No".tr,
    prefix: Icon(Icons.phone_android_rounded, color: Colors.black),
  );
}

Widget _buildEmailIdContainer(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Email Id".tr,
    controller: controller.emailController,
    textInputType: TextInputType.emailAddress,
    onFieldSubmitted: (String? value) {},
    labletext: "Email Id".tr,
    prefix: Icon(Icons.email, color: Colors.black),
  );
}

Widget _buildCompanyName(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Company Name".tr,
    controller: controller.companyNameController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Company Name".tr,
    prefix: Icon(Icons.add_business, color: Colors.black),
  );
}

Widget _buildModeNoContainer(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Model No".tr,
    controller: controller.modelNoController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Model No".tr,
    prefix: Icon(Icons.work_rounded, color: Colors.black),
  );
}

Widget _buildAddressName(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Address Name".tr,
    controller: controller.addressNameController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Address Name".tr,
  );
}

Widget _buildLandMarkName(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "LandMark".tr,
    controller: controller.landMarkController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "LandMark".tr,
  );
}

Widget _buildCityName(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "City".tr,
    controller: controller.cityController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "City".tr,
  );
}

Widget _buildStateName(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "State".tr,
    controller: controller.stateController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "State".tr,
  );
}

Widget _buildzipcode(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Zip code".tr,
    controller: controller.zipController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Zip code".tr,
  );
}

Widget _countryView(CustomerListViewController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Country ".tr,
    controller: controller.countryController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Country".tr,
  );
}

Widget _buildSelectedRegion(CustomerListViewController controller, BuildContext context) {
  // final controller = Get.put(PrincipalCstomerViewController());
  return CustomTextField(
    // hintText: "Selected Region ".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Selected Region".tr,
    controller: TextEditingController(text: controller.defaultValue),
    readOnly: true,
    suffix: IconButton(
      onPressed: () {
        _showRegionSelection(controller, context);
      },
      icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
    ),
  );
}

void _showRegionSelection(CustomerListViewController controller, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text("Select Region"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.regionValues.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.regionValues[index]),
                onTap: () {
                  controller.updateRegion(controller.regionValues[index]);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      );
    },
  );
}

_buildOptionbutton(CustomerListViewController controller, BuildContext context){
  return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => Get.back(),
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
          child: Text('Cancel',style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),),
        ),
        hGap(20),
        ElevatedButton(
          onPressed: (){
            // controller.hitPostCustomerApiCall();
            Get.back();},
          child: Text('Add',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
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

class ProductTypeBuilder extends StatefulWidget {
  @override
  _ProductTypeBuilderState createState() => _ProductTypeBuilderState();
}

class _ProductTypeBuilderState extends State<ProductTypeBuilder> {
  List<Widget> _productTypeFields = [];

  @override
  void initState() {
    super.initState();
    _productTypeFields.add(_buildProductTypeField(isFirst: true));
  }

  Widget _buildProductTypeField({required bool isFirst}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              hintText: "Product Type".tr,
              textInputType: TextInputType.text,
              onFieldSubmitted: (String? value) {},
              labletext: "Product Type".tr,
              prefix: Icon(Icons.production_quantity_limits, color: Colors.black),
            ),
          ),
          hGap(20),
          Column(
            children: [
              _buildAddButton(),
              vGap(10),
              if (!isFirst) _buildDeleteButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      width: 40,
      height: 40,
      child: FloatingActionButton(
        child: Icon(Icons.delete, color: Colors.white),
        backgroundColor: Colors.red,
        onPressed: () {
          setState(() {
            if (_productTypeFields.length > 1) {
              _productTypeFields.removeLast();
            }
          });
        },
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 40,
      height: 40,
      child: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {
            _productTypeFields.add(_buildProductTypeField(isFirst: false));
          });
        },
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _productTypeFields,
    );
  }
}
// Widget _form(CustomerListViewController controller, BuildContext context, String agentId,CustomerData customdata) {
//   WidgetsBinding.instance.addPostFrameCallback((_){
//     controller.firstNameController.text = customdata.firstName ?? '';
//   controller.lastNameController.text = customdata.lastName ?? '';
//   controller.emailController.text = customdata.email ?? '';
//   controller.phoneController.text = customdata.phoneNumber ?? '';
//   });
//
//   return Container(
//     height: Get.height,
//     width: Get.width,
//     color: whiteColor,
//     child: Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: ListView(
//         children: [
//           vGap(40),
//           _buildTopBarView(controller: controller, context: context),
//           Divider(height: 1, color: Colors.black),
//           vGap(40),
//           _buildTaskName(context: context, controller: controller),
//           vGap(20),
//           _buildLastName(context: context, controller: controller),
//           vGap(20),
//           _addTechnician(context: context, controller: controller),
//           vGap(20),
//           _phoneNumber(context: context, controller: controller),
//           vGap(40),
//           _buildOptionbutton(context: context, controller: controller, agentId: agentId),
//         ],
//       ),
//     ),
//   );
// }
//
// Widget _buildTopBarView({required CustomerListViewController controller, required BuildContext context}) {
//   return Center(child: Text('Edit Agent', style: MontserratStyles.montserratBoldTextStyle(size: 25, color: blackColor)));
// }
//
// Widget _buildTaskName({required CustomerListViewController controller, required BuildContext context}) {
//   return CustomTextField(
//     hintText: "First Name".tr,
//     controller: controller.firstNameController,
//     textInputType: TextInputType.text,
//     // focusNode: controller.lastNameFocusNode,
//     labletext: "First Name".tr,
//     prefix: Icon(Icons.person, color: Colors.black),
//   );
// }
//
// Widget _buildLastName({required CustomerListViewController controller, required BuildContext context}) {
//   return CustomTextField(
//     hintText: "Last Name".tr,
//     controller: controller.lastNameController,
//     textInputType: TextInputType.text,
//     // focusNode: controller.emailFocusnode,
//     labletext: "Last Name".tr,
//     prefix: Icon(Icons.person, color: Colors.black),
//   );
// }
//
// Widget _addTechnician({required CustomerListViewController controller, required BuildContext context}) {
//   return CustomTextField(
//     hintText: "Email".tr,
//     controller: controller.emailController,
//     textInputType: TextInputType.emailAddress,
//     // focusNode: controller.phoneFocusNode,
//     labletext: "Email".tr,
//     prefix: Icon(Icons.mail, color: Colors.black),
//   );
// }
//
// Widget _phoneNumber({required CustomerListViewController controller, required BuildContext context}) {
//   return CustomTextField(
//     hintText: "Phone Number".tr,
//     controller: controller.phoneController,
//     textInputType: TextInputType.phone,
//     // focusNode: controller.firstNameFocusNode,
//     labletext: "Phone Number".tr,
//     prefix: Icon(Icons.phone_android_rounded, color: Colors.black),
//   );
// }
//
// Widget _buildOptionbutton({required CustomerListViewController controller, required BuildContext context, required String agentId}) {
//   return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             Get.back();
//           },
//           child: Text('Cancel', style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13)),
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(appColor),
//             foregroundColor: MaterialStateProperty.all(Colors.white),
//             padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
//             elevation: MaterialStateProperty.all(5),
//             shape: MaterialStateProperty.all(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
//           ),
//         ),
//         hGap(20),
//         ElevatedButton(
//           onPressed: () {},/* controller.hitPutAgentsDetailsApiCall(agentId),*/
//           child: Text('Update', style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13)),
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(appColor),
//             foregroundColor: MaterialStateProperty.all(Colors.white),
//             padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
//             elevation: MaterialStateProperty.all(5),
//             shape: MaterialStateProperty.all(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
//           ),
//         )
//       ]
//   );
// }

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