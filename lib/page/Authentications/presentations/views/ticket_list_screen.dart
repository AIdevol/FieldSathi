import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../utilities/common_textFields.dart';
import '../../widgets/views/principal_customer_view.dart';
import '../controllers/ticket_list_controller.dart';

class TicketListScreen extends GetView<TicketListController> {
   TicketListScreen({Key? key}) : super(key: key);

  // Define fixed column widths
  final Map<String, double> columnWidths = {
    'ID': 50,
    'Customer Name': 150,
    'Sub-Customer': 150,
    'Technician': 150,
    'Start Date/Time': 160,
    'End Date/Time': 160,
    'Total Time': 100,
    'Address': 200,
    'Region': 120,
    'Purpose': 150,
    'Status': 120,
    'Ticket Date': 120,
    'Aging': 100,
    'Actions': 80,
  };
  

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<TicketListController>(
        init: TicketListController(),
        builder: (controller) => SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(),
            body: Column(
              children: [
                _buildTopBar(context),
                _buildSearchBar(),
                Expanded(
                  child: Obx(() => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : _buildTicketTable()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: appColor,
      title: Text(
        'Ticket Details',
        style: MontserratStyles.montserratBoldTextStyle(
          size: 18,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: controller.fetchTicketsApiCall,
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.ticketListCreationScreen);
          },
          icon: const Icon(FeatherIcons.plus),
        ),
      ],
    );
  }

   Widget _buildTopBar(BuildContext context) {
     return Container(
       padding: const EdgeInsets.all(16.0),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(8),
         boxShadow: [
           BoxShadow(
             color: Colors.grey.withOpacity(0.1),
             spreadRadius: 1,
             blurRadius: 3,
             offset: const Offset(0, 2),
           ),
         ],
       ),
       margin: const EdgeInsets.all(6),
       child: Row(
         children: [
           Expanded(child: _buildFilterDropdown()),
           const SizedBox(width: 16),
           _buildActionButton(
             context,
             'Import',
             Icons.file_download_outlined,
             onTap: () => _showImportModelView(context),
           ),
           const SizedBox(width: 12),
           _buildActionButton(
             context,
             'Export',
             Icons.file_upload_outlined,
             onTap: () {},
           ),
         ],
       ),
     );
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

  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
            () => DropdownButton<String>(
          value: controller.selectedFilter.value,
          isExpanded: true,
          underline: Container(),
          items: controller.filterTypes.map((String value) {
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
          onChanged: controller.updateSelectedFilter,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: TextField(
        onChanged: controller.updateSearchQuery,
        style: MontserratStyles.montserratSemiBoldTextStyle(
          size: 14,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: 'Search tickets',
          labelStyle: MontserratStyles.montserratSemiBoldTextStyle(
            size: 14,
            color: Colors.grey,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: appColor),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildTicketTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(Get.context!).size.width - 32,
            ),
            child: DataTable(
              headingRowHeight: 60,
              dataRowHeight: 65,
              horizontalMargin: 20,
              columnSpacing: 20,
              border: TableBorder(
                horizontalInside: BorderSide(width: 1, color: Colors.grey.shade200),
                verticalInside: BorderSide(width: 1, color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
              columns: _buildTableColumns(),
              rows: _buildTableRows(),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return columnWidths.keys.map((header) {
      return DataColumn(
        label: Container(
          width: columnWidths[header],
          child: _buildHeaderCell(header),
        ),
      );
    }).toList();
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: MontserratStyles.montserratSemiBoldTextStyle(
          size: 13,
          color: Colors.black87,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDataCell(String text, {double? maxWidth}) {
    return Tooltip(
      message: text,
      child: Container(
        width: maxWidth,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: MontserratStyles.montserratSemiBoldTextStyle(
            size: 12,
            color: Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _ticketBoxIcons(String ticketId) {
    return Container(
      width: columnWidths['Ticket ID'],
      padding: const EdgeInsets.symmetric(horizontal:8, vertical: 4),
      decoration: BoxDecoration(
        color: normalBlue,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blue.shade200,
          width: 1,
        ),
      ),
      child: Text(
        '$ticketId',
        style: MontserratStyles.montserratSemiBoldTextStyle(
          size: 12,
          color: Colors.white,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    return controller.ticketResult.map((ticket) {
      return DataRow(
        cells: [
          DataCell(_ticketBoxIcons(ticket.id?.toString() ?? 'NA')),
          DataCell(_buildDataCell(
            ticket.customerDetails?.name ?? 'NA',
            maxWidth: columnWidths['Customer Name'],
          )),
          DataCell(_buildDataCell(
            ticket.subCustomerDetails?.subCustomerName ?? 'NA',
            maxWidth: columnWidths['Sub-Customer'],
          )),
          DataCell(_buildDataCell(
            '${ticket.assignTo?.firstName ?? ''} ${ticket.assignTo?.lastName ?? ''}'.trim(),
            maxWidth: columnWidths['Technician'],
          )),
          DataCell(_buildDataCell(
            ticket.startDateTime ?? 'NA',
            maxWidth: columnWidths['Start Date/Time'],
          )),
          DataCell(_buildDataCell(
            ticket.endDateTime ?? 'NA',
            maxWidth: columnWidths['End Date/Time'],
          )),
          DataCell(_buildDataCell(
            ticket.totalTime ?? 'NA',
            maxWidth: columnWidths['Total Time'],
          )),
          DataCell(_buildDataCell(
            '${ticket.ticketAddress?.city ?? ''}, ${ticket.ticketAddress?.state ?? ''}'.trim(),
            maxWidth: columnWidths['Address'],
          )),
          DataCell(_buildDataCell(
            ticket.ticketAddress?.country ?? 'NA',
            maxWidth: columnWidths['Region'],
          )),
          DataCell(_buildDataCell(
            ticket.purpose ?? 'NA',
            maxWidth: columnWidths['Purpose'],
          )),
          DataCell(_buildStatusCell(ticket.status ?? 'NA')),
          DataCell(_buildDataCell(
            ticket.date ?? 'NA',
            maxWidth: columnWidths['Ticket Date'],
          )),
          DataCell(_buildAgingCell(ticket.aging?.toString() ?? 'NA')),
          DataCell(_buildActionCell()),
        ],
      );
    }).toList();
  }

  Widget _buildStatusCell(String status) {
    Color backgroundColor;
    Color textColor;
    IconData statusIcon;

    switch (status.toLowerCase()) {
      case 'completed':
        backgroundColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        statusIcon = Icons.check_circle_outline;
        break;
      case 'pending':
        backgroundColor = Colors.orange.shade50;
        textColor = Colors.orange.shade700;
        statusIcon = Icons.pending_outlined;
        break;
      case 'in progress':
        backgroundColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        statusIcon = Icons.sync;
        break;
      default:
        backgroundColor = Colors.grey.shade50;
        textColor = Colors.grey.shade700;
        statusIcon = Icons.info_outline;
    }

    return Container(
      width: columnWidths['Status'],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              status,
              style: MontserratStyles.montserratMediumTextStyle(
                size: 12,
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgingCell(String aging) {
    int? agingDays = int.tryParse(aging);
    Color textColor = Colors.black54;
    IconData icon = Icons.schedule;

    if (agingDays != null) {
      if (agingDays > 7) {
        textColor = Colors.red.shade700;
        icon = Icons.error_outline;
      } else if (agingDays > 3) {
        textColor = Colors.orange.shade700;
        icon = Icons.warning_amber_rounded;
      }
    }

    return Container(
      width: columnWidths['Aging'],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              '$aging days',
              style: MontserratStyles.montserratMediumTextStyle(
                size: 12,
                color: textColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCell() {
    return Container(
        width: columnWidths['Actions'],
        child: PopupMenuButton<String>(
        color: Colors.white,
        offset: const Offset(0, 40),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      _buildPopupMenuItem('Download', Icons.download, Colors.blue.shade700, context, controller),
      _buildPopupEditMenuItem('Edit', Icons.edit_outlined, Colors.blue.shade700, context, controller),
      _buildPopupDeleteMenuItem('Delete', Icons.delete_outline, Colors.red, context, controller),
    ],
    child: Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
    color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
      child: const Icon(
        Icons.more_horiz,
        size: 20,
        color: Colors.black54,
      ),
    ),
        ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String text, IconData icon, Color iconColor, BuildContext context, TicketListController controller) {
    return PopupMenuItem<String>(
      onTap: (){},
      value: text,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Text(
            text,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              size: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
   PopupMenuItem<String> _buildPopupEditMenuItem(
       String text, IconData icon, Color iconColor, BuildContext context, TicketListController controller) {
     return PopupMenuItem<String>(
       onTap: ()=>_showInbuildDialogValue(context, controller),
       value: text,
       child: Row(
         mainAxisSize: MainAxisSize.min,
         children: [
           Icon(icon, size: 18, color: iconColor),
           const SizedBox(width: 8),
           Text(
             text,
             style: MontserratStyles.montserratSemiBoldTextStyle(
               size: 13,
               color: Colors.black87,
             ),
           ),
         ],
       ),
     );
   }
   PopupMenuItem<String> _buildPopupDeleteMenuItem(
       String text, IconData icon, Color iconColor, BuildContext context, TicketListController controller) {
     return PopupMenuItem<String>(
       onTap: (){},
       value: text,
       child: Row(
         mainAxisSize: MainAxisSize.min,
         children: [
           Icon(icon, size: 18, color: iconColor),
           const SizedBox(width: 8),
           Text(
             text,
             style: MontserratStyles.montserratSemiBoldTextStyle(
               size: 13,
               color: Colors.black87,
             ),
           ),
         ],
       ),
     );
   }
}


_showInbuildDialogValue(BuildContext context, TicketListController controller){
  Get.dialog(
    Dialog(
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: _form(context, controller),
      ),
    )
  );
}

_form(BuildContext context, TicketListController controller){
return Padding(
  padding: const EdgeInsets.all(18.0),
  child: ListView(
    children: [
      Text('Reassign', style: MontserratStyles.montserratSemiBoldTextStyle(size: 18,color: Colors.black),),
      Divider(height: 20,),
      _buildTaskName(context: context),
      vGap(20),
      _addTechnician(context: context),
      vGap(20),
      _buildOptionbutton(context: context),
      vGap(20),
      _buildtextContainer(context: context),
      vGap(20),
      _dobView(context: context, controller:  controller),
      vGap(20),
      _selectGroupViewform(context: context)
    ],
  ),
);
}
Widget _buildTopBarView({required TicketListController controller, required BuildContext context}) {
  return Center(child: Text('ReAssign Ticket', style: MontserratStyles.montserratBoldTextStyle(size: 18, color: blackColor)));
}
// Add these extension methods to help with responsive sizing
extension TicketListScreenExtensions on TicketListScreen {
  double getResponsiveWidth(BuildContext context, double defaultWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return defaultWidth * 0.8; // Reduce width for small screens
    } else if (screenWidth < 1200) {
      return defaultWidth * 0.9; // Slightly reduce width for medium screens
    }
    return defaultWidth; // Use default width for large screens
  }

  // Helper method to format dates consistently
  String formatDateTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'NA';
    try {
      final DateTime dt = DateTime.parse(dateTime);
      return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute}';
    } catch (e) {
      return dateTime;
    }
  }

  // Helper method to calculate aging in days
  String calculateAging(String? startDate) {
    if (startDate == null || startDate.isEmpty) return 'NA';
    try {
      final DateTime start = DateTime.parse(startDate);
      final DateTime now = DateTime.now();
      return '${now.difference(start).inDays}';
    } catch (e) {
      return 'NA';
    }
  }
}
_buildTaskName({required BuildContext context}){
  return CustomTextField(
    hintText: "Task Name".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.emailAddress,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Task Name".tr,
    prefix: Icon(Icons.add_task, color: Colors.black,),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}

_addTechnician({required BuildContext context}){
  return CustomTextField(
    hintText: "Assign To".tr,
    // controller: controller.emailcontroller,
    textInputType: TextInputType.emailAddress,
    // focusNode: controller.phoneFocusNode,
    onFieldSubmitted: (String? value) {
      // FocusScope.of(Get.context!)
      //     .requestFocus(controller.passwordFocusNode);
    },
    labletext: "Assign To".tr,
    prefix: Icon(Icons.add_task, color: Colors.black,),
    suffix: IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.black,),),
    // validator: (value) {
    //   return value?.isEmptyField(messageTitle: "Email");
    // },
    inputFormatters:[
      // LengthLimitingTextInputFormatter(10),
    ],
  );

}

_buildOptionbutton({required BuildContext context}){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      ElevatedButton(
        onPressed: () {},
        child: Text('AMC',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(appColor),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 120, vertical: 15)),
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
      Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Rate',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(appColor), // Background color
              foregroundColor: WidgetStateProperty.all(Colors.white), // Text color
              padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 55, vertical: 15)), // Padding
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
          Container(
            height: Get.height*0.06,
            width: Get.width*0.30,
            decoration: BoxDecoration(color: whiteColor,borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    width:1,
                    color: Colors.grey
                  // _isFocused ? Colors.blue : Colors.black,

                )),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Rate *',
                ),
              ),
            ),
          ),
        ],
      )

      // InkWell(onTap: (){},child: Container(height: 40,width: 120,color:appColor,),)
    ],);
  //   GetBuilder<TicketListController>(builder: (context){
  //   return
  // });
}

_buildtextContainer({required BuildContext context}){
  return  Container(
    height: Get.height*0.16,
    width: Get.width*0.40,
    decoration: BoxDecoration(color: whiteColor,borderRadius: BorderRadius.circular(25),
        border: Border.all(
            width:1,
            color: Colors.grey
          // _isFocused ? Colors.blue : Colors.black,

        )),
    child:  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
        maxLines: 10,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Purpose *',
        ),
      ),
    ),
  );
}

Widget _dobView({required BuildContext context, required TicketListController controller}) {
  // final controller = Get.put(TicketListController());
  return CustomTextField(
    hintText: "dd-month-yyyy".tr,
    controller: controller.dateController,
    textInputType: TextInputType.datetime,
    focusNode: controller.focusNode,
    onFieldSubmitted: (String? value) {
      // Handle field submission if needed
    },
    labletext: "Date".tr,
    prefix: IconButton(
      onPressed: () => controller.selectDate(context),
      icon: Icon(Icons.calendar_month, color: Colors.black),
    ),
  );
}

Widget _selectGroupViewform({required BuildContext context}){
  return SizedBox(
    height: Get.height,
    width: Get.width,
    child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        Text('Customer Details',    style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
        _buildListCustomerDetails(context: context),
        vGap(20),
        Text('FSR Details',    style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
        CustomTextField(
          hintText: "FSR Details".tr,
          // controller: controller.dateController,
          textInputType: TextInputType.datetime,
          // focusNode: controller.focusNode,
          onFieldSubmitted: (String? value) {
            // Handle field submission if needed
          },
          // labletext: "Date".tr,
          prefix: IconButton(
            onPressed: (){} /*=> controller.selectDate(context)*/,
            icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30,),
          ),
        ),
        vGap(20),
        Text('Services Details',    style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
        CustomTextField(
          hintText: "Services Details".tr,
          // controller: controller.dateController,
          textInputType: TextInputType.datetime,
          // focusNode: controller.focusNode,
          onFieldSubmitted: (String? value) {
            // Handle field submission if needed
          },
          // labletext: "Date".tr,
          prefix: IconButton(
            onPressed: (){} /*=> controller.selectDate(context)*/,
            icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30,),
          ),
        ),
        vGap(20),
        Text('Instructions',    style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
        Container(
          height: Get.height*0.16,
          width: Get.width*0.40,
          decoration: BoxDecoration(color: whiteColor,borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  width:1,
                  color: Colors.grey
                // _isFocused ? Colors.blue : Colors.black,

              )),
          child:  Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
              maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Instructions *',
              ),
            ),
          ),
        ),
        vGap(20),
        _buildButtonView(context:  context)
      ],),
  );
}

Widget _buildListCustomerDetails({required BuildContext context}){
  return Column(children: [
    vGap(20),
    CustomTextField(
      hintText: "Customer Details".tr,
      // controller: controller.dateController,
      textInputType: TextInputType.datetime,
      // focusNode: controller.focusNode,
      onFieldSubmitted: (String? value) {
        // Handle field submission if needed
      },
      labletext: "customer name".tr,
      prefix: IconButton(
        onPressed: () => _buildBottomsheet(context:  context),
        icon: Icon(Icons.add, color: Colors.black),
      ),
    ),
    CustomTextField(
      hintText: "product name".tr,
      // controller: controller.dateController,
      textInputType: TextInputType.datetime,
      // focusNode: controller.focusNode,
      onFieldSubmitted: (String? value) {
        // Handle field submission if needed
      },
      labletext: "product name".tr,
      prefix: IconButton(
        onPressed: () {}/*=> controller.selectDate(context)*/,
        icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30,),
      ),
    ),
    CustomTextField(
      hintText: "model no".tr,
      // controller: controller.dateController,
      textInputType: TextInputType.datetime,
      // focusNode: controller.focusNode,
      onFieldSubmitted: (String? value) {
        // Handle field submission if needed
      },
      labletext: "model no".tr,
      prefix: IconButton(
        onPressed: () {}/*=> controller.selectDate(context)*/,
        icon: Icon(Icons.add, color: Colors.black),
      ),
    )
  ],);
}


Widget _buildButtonView({required BuildContext context}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    // crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      ElevatedButton(onPressed: ()=>Get.back(), child: Text('Cancel',style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        foregroundColor: Colors.white,           // Text and icon color
        shadowColor: Colors.black,         // Shadow color
        elevation: 5,                      // Elevation of the button
        shape: RoundedRectangleBorder(     // Rounded corners
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),)),
      hGap(20),
      ElevatedButton(onPressed: (){}, child: Text("Add Ticket", style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),),
          style: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            foregroundColor: Colors.white,           // Text and icon color
            shadowColor: Colors.black,         // Shadow color
            elevation: 5,                      // Elevation of the button
            shape: RoundedRectangleBorder(     // Rounded corners
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),))
    ],
  );
}

_buildBottomsheet({required BuildContext context}){
  return showBottomSheet(context: context, builder: (BuildContext context){
    return PrincipalCustomerView();
  });
}

void _showImportModelView(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Import File'),
          content: SizedBox(
            height: Get.height * 0.2,
            width: Get.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload_file, size: 60, color: appColor),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles();
                    if (result != null) {
                      String fileName = result.files.single.name;
                      Get.snackbar('File Selected', 'You selected: $fileName');
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Select File from Local'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: appColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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