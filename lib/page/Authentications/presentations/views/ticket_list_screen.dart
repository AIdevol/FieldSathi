import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/response_models/ticket_history_response_model.dart';
import 'package:tms_sathi/response_models/ticket_response_model.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/string_const.dart';
import '../../../../utilities/common_textFields.dart';
import '../../widgets/views/principal_customer_view.dart';
import '../controllers/ticket_list_controller.dart';

class TicketListScreen extends GetView<TicketListController> {
   TicketListScreen({Key? key}) : super(key: key);

  // Define fixed column widths
  final Map<String, double> columnWidths = {
    'ID': 50,
    'Task Name': 150,
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
            backgroundColor: CupertinoColors.white,
            resizeToAvoidBottomInset: true,
            appBar: _buildAppBar(),
            body: RefreshIndicator(child:  Column(
              children: [
                _buildTopBar(context, controller),
                _buildSearchBar(),
                Expanded(
                  child: Obx(() => controller.isLoading.value
                      ?  Center(child: Container())
                      : _buildContent(context,controller)),
                ),
              ],
            ), onRefresh: ()async{
              await controller.hitRefreshAllTicketData();
            })
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
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

   Widget _buildTopBar(BuildContext context, TicketListController controller) {
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
             onTap: () => _showImportModelView(context, controller),
           ),
           const SizedBox(width: 12),
           _buildActionButton(
             context,
             'Export',
             Icons.file_upload_outlined,
             onTap: () => _downLoadExportModelView(context, controller),
           ),
         ],
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

   Widget _buildContent(BuildContext context, TicketListController controller) {
     return Obx(() {
       if (controller.ticketResult.isEmpty) {
         return _buildEmptyState();
       }

       return _buildTicketTable(context, controller);
     });
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

  Widget _buildTicketTable(BuildContext context, TicketListController controller) {
    final resultData = controller.ticketResult.map((Ids)=> Ids.id);
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
              rows: _buildTableRows(context, controller),
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



  List<DataRow> _buildTableRows(BuildContext context, TicketListController controller) {
    return controller.ticketResult.map((ticket) {
      return DataRow(
        onSelectChanged:(selected) {
          if(selected != null){ showDialogWidgetContext(
          context, controller, ticket.id.toString(), ticket);}
        },
        cells: [
          DataCell(_ticketBoxIcons(ticket.id.toString() ?? 'NA')),
          DataCell(_buildDataCell(ticket.taskName?.toString() ?? 'NA')),
          DataCell(_buildDataCell(
            ticket.customerDetails.customerName ?? 'NA',
            maxWidth: columnWidths['Customer Name'],
          )),
          DataCell(_buildDataCell(
            ticket.subCustomerDetails.customerName ?? 'NA',
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
          DataCell(_buildActionCell(controller, ticket.id.toString(), ticket),),
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

   Widget _buildActionCell(TicketListController controller, String? tickId, TicketResult ticket) {
     return Container(
       width: columnWidths['Actions'],
       child: PopupMenuButton<String>(
         color: Colors.white,
         offset: const Offset(0, 40),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
         itemBuilder: (BuildContext context) => _buildMenuItems(context, controller, tickId, ticket),
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

   List<PopupMenuEntry<String>> _buildMenuItems(BuildContext context, TicketListController controller, String? tickId, TicketResult ticket, ) {
     // Find the ticket by ID to get its status
     final ticket = controller.ticketResult.firstWhere(
           (ticket) => ticket.id.toString() == tickId,
       // orElse: () => null, // Handle case where ticket is not found
     );

     final status = ticket?.status?.toLowerCase() ?? '';

     List<PopupMenuEntry<String>> menuItems = [
       _buildPopupMenuItem('Download', Icons.download, Colors.blue.shade700, context, controller, tickId),
     ];

     // Add either Reassign or Edit based on status
     if (status == 'completed') {
       menuItems.add(
         _buildPopupEditMenuItem('Reassign', Icons.edit_outlined, Colors.blue.shade700, context, controller, ticket),
       );
     } else {
       menuItems.add(
         _buildPopupEditMenuItem('Edit', Icons.edit_outlined, Colors.blue.shade700, context, controller, ticket),
       );
     }

     // Add Delete option
     menuItems.add(
       _buildPopupDeleteMenuItem('Delete', Icons.delete_outline, Colors.red, context, controller),
     );

     return menuItems;
   }

  PopupMenuItem<String> _buildPopupMenuItem(
      String text, IconData icon, Color iconColor, BuildContext context, TicketListController controller, String? tickId) {
    return PopupMenuItem<String>(
      onTap: ()=> controller.downloadTicketData(tickId),
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
       String text, IconData icon, Color iconColor, BuildContext context, TicketListController controller, TicketResult ticket) {
     return PopupMenuItem<String>(
       onTap: ()=>_showInbuildDialogValue(context, controller,ticket),
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


_showInbuildDialogValue(BuildContext context, TicketListController controller, TicketResult ticket){
  Get.dialog(
    Dialog(
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: _form(context, controller, ticket),
      ),
    )
  );
}

_form(BuildContext context, TicketListController controller, TicketResult ticket) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: SingleChildScrollView(  // Changed from ListView to SingleChildScrollView
      child: Column(  // Changed to Column for better layout control
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reassign',
            style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 18,
                color: Colors.black
            ),
          ),
          Divider(height: 20),
          _buildTaskName(context,controller, ticket),
          vGap(20),
          _addTechnician(context, controller, ticket),
          vGap(20),
          _buildOptionbutton(context, controller, ticket),
          vGap(20),
          _buildtextContainer(context, controller, ticket),
          vGap(20),
          _dobView(context, controller, ticket),
          vGap(20),
          _buildGroupForm(context, controller, ticket)  // Renamed and restructured
        ],
      ),
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
_buildTaskName( BuildContext context,TicketListController controller, TicketResult? ticket){
  controller.taskNameController.text = ticket?.taskName ?? "N/A";
  return CustomTextField(
    hintText: "Task Name".tr,
    controller:controller.taskNameController,
    textInputType: TextInputType.emailAddress,
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

_addTechnician(BuildContext context,TicketListController controller, TicketResult? ticket){
  controller.assignTo.text = ticket!.assignTo.toString();

  return CustomTextField(
    hintText: "Assign To".tr,
    controller: controller.assignTo,
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

Widget _buildOptionbutton(BuildContext context,TicketListController controller, TicketResult? ticket) {
  controller.rateController.text = ticket!.rate.toString();
  return GetBuilder<TicketListController>(
    builder: (controller) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // AMC Button
          ElevatedButton(
            onPressed: () => controller.toggleAmc(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                controller.isAmcSelected ? appColor : Colors.white,
              ),
              foregroundColor: MaterialStateProperty.all(
                controller.isAmcSelected ? Colors.white : Colors.black,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: controller.isAmcSelected ? appColor : Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
            ),
            child: Text(
              'AMC',
              style: MontserratStyles.montserratBoldTextStyle(
                color: controller.isAmcSelected ? whiteColor : Colors.black,
                size: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => controller.toggleRate(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                controller.isRateSelected ? appColor : Colors.white,
              ),
              foregroundColor: MaterialStateProperty.all(
                controller.isRateSelected ? Colors.white : Colors.black,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: controller.isRateSelected ? appColor : Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
            ),
            child: Text(
              'Rate',
              style: MontserratStyles.montserratBoldTextStyle(
                color: controller.isRateSelected ? whiteColor : Colors.black,
                size: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (controller.isRateSelected)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: Get.height * 0.06,
              width: Get.width * 0.30,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: controller.rateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Rate *',
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}


_buildtextContainer(BuildContext context,TicketListController controller, TicketResult? ticket){
  controller.purposeController.text = ticket!.purpose.toString();
  return  Container(
    height: Get.height * 0.16,
    decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            width: 1,
            color: Colors.grey
        )
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller.purposeController,
        style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13
        ),
        maxLines: 10,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Purpose*',
        ),
      ),
    ),
  );
}

Widget _dobView(BuildContext context,TicketListController controller, TicketResult? ticket) {
  controller.dateController.text = ticket!.date.toString();
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


Widget _buildGroupForm(BuildContext context,TicketListController controller, TicketResult? ticket) {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Customer Details',
        style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13
        ),
      ),
      _buildListCustomerDetails(context,controller, ticket),
      vGap(20),
      Text(
        'FSR Details',
        style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13
        ),
      ),
      _buildFSRDetails(context, controller, ticket),
      vGap(20),
      Text(
        'Services Details',
        style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13
        ),
      ),
      _buildServicesDetails(context,controller, ticket),
      vGap(20),
      Text(
        'Instructions',
        style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13
        ),
      ),
      _buildInstructionsField(context,controller,ticket),
      vGap(20),
      _buildButtonView(context, controller, ticket)
    ],
  );
}

Widget _buildFSRDetails(BuildContext context,TicketListController controller, TicketResult? ticket) {
  controller.fsrController.text = ticket!.fsrDetails.fsrName.toString();

  return CustomTextField(
    controller: controller.fsrController,
    hintText: "FSR Details".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    prefix: IconButton(
      onPressed: () {},
      icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
    ),
  );
}

Widget _buildServicesDetails(BuildContext context,TicketListController controller, TicketResult? ticket) {
  controller.servicesDetailsController.text = ticket!.serviceDetails.toString();
  return CustomTextField(
    controller: controller.servicesDetailsController,
    hintText: "Services Details".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    prefix: IconButton(
      onPressed: () {},
      icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
    ),
  );
}

// New widget for Instructions field
Widget _buildInstructionsField(BuildContext context,TicketListController controller, TicketResult? ticket) {
  controller.instructionController.text = ticket!.instructions.toString();

  return Container(
    height: Get.height * 0.16,
    decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            width: 1,
            color: Colors.grey
        )
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller.instructionController,
        style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13
        ),
        maxLines: 10,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Instructions *',
        ),
      ),
    ),
  );
}

Widget _buildListCustomerDetails(BuildContext context,TicketListController controller, TicketResult? ticket) {
  controller.customerNameController.text = ticket!.customerDetails.customerName.toString();
  controller.productNameController.text = ticket!.brand.toString();
  controller.modelNoController.text = ticket!.model.toString();

  return Column(
    children: [
      vGap(20),
      CustomTextField(
        controller: controller.customerNameController,
        hintText: "Customer Details".tr,
        textInputType: TextInputType.text,
        labletext: "customer name".tr,
        prefix: IconButton(
          onPressed: () => _buildBottomsheet(context),
          icon: Icon(Icons.add, color: Colors.black),
        ),
      ),
      CustomTextField(
        controller: controller.productNameController,
        hintText: "product name".tr,
        textInputType: TextInputType.text,
        labletext: "product name".tr,
        prefix: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_drop_down_sharp, color: Colors.black, size: 30),
        ),
      ),
      CustomTextField(
        controller: controller.modelNoController,
        hintText: "model no".tr,
        textInputType: TextInputType.text,
        labletext: "model no".tr,
        prefix: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add, color: Colors.black),
        ),
      )
    ],
  );
}
/// ShowPrincipalView
_buildBottomsheet(BuildContext context){
  return showBottomSheet(context: context, builder: (BuildContext context){
    return PrincipalCustomerView();
  });
}

Widget _buildButtonView(BuildContext context,TicketListController controller, TicketResult? ticket) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => Get.back(),
          style: _buttonStyle(),
          child: Text(
            'Cancel',
            style: MontserratStyles.montserratBoldTextStyle(
                color: Colors.black,
                size: 13
            ),
          ),
        ),
        hGap(20),
        ElevatedButton(
          onPressed: () {},
          style: _buttonStyle(),
          child: Text(
            "Add Ticket",
            style: MontserratStyles.montserratBoldTextStyle(
                color: Colors.black,
                size: 13
            ),
          ),
        )
      ],
    ),
  );
}

// Extracted button style for consistency
ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: appColor,
    foregroundColor: Colors.white,
    shadowColor: Colors.black,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  );
}


void _downLoadExportModelView(BuildContext context, TicketListController controller) {
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
                "Download Tickets Report",
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

void _showImportModelView(BuildContext context,TicketListController controller) {
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
                                    TextSpan(text: '• Customer\'s Name\n'),
                                    TextSpan(text: '• Address\n'),
                                    TextSpan(text: '• Phone Number\n\n'),
                                    TextSpan(
                                      text: 'Optional Fields:\n',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: '• Landmark'),
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

Future<void> showDialogWidgetContext(BuildContext context, TicketListController controller, String ticketid, TicketResult ticket, ){
   controller.hitGetTicketHistoryApiCall(ticketid);
   final progressResult = controller.ticketHistoryData;
  return showDialog(context: context, builder: (context){
    return Dialog(
      child: Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${ticket.taskName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${ticket.status}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Created & Assigned Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Created At: ${ticket.createdAt}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text("Created By: ${ticket.createdBy}"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Assigned To: ${ticket.assignTo}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Technician\nfthhhhhhhhhhhhhhhhhhhhhhhhhhhhh",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Ticket Details Section
                      Text(
                        "Ticket Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Divider(),
                      ...[
                        "Customer Name: ${ticket.customerDetails.customerName}",
                        "Subcustomer Name: ${ticket.subCustomerDetails.customerName} ",
                        "FSR: ${ticket.fsrDetails.fsrName}",
                        "Phone Number: ${ticket.customerDetails.phoneNumber}",
                        "Service: ${ticket.serviceDetails}",
                        "Address: ${ticket.ticketAddress}",
                        "Purpose: ${ticket.purpose??"N/A"}",
                        "Instructions: ${ticket.instructions??"N/A"}",
                        "Brand: ${ticket.brand??"N/A"}",
                        "Model: ${ticket.model}",
                      ].map((detail) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(detail),
                      )),
                      SizedBox(height: 16),
                      // Progress History Section
                      Text(
                        "Progress History",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Divider(),
                      ...[
                        "${progressResult.map((ticket){return ticket.actionMessage;})}",
                        // "Rohitddfdx\nfthhhhhhhhhhhhhhhhhhhhhhhhhhh",
                        // "Technician\nhhhhhhhhhhhhhhhhhhhhhhhhhhh",
                        // "17-11-2024 08:10 AM",
                        // "Ticket updated by Rohitddfdx",
                      ].map((history) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(history),
                      )),
                      vGap(20),
                      _buildActionButton(
                        context,
                        'Okay',
                        Icons.cancel,
                        onTap: () => Get.back(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),);
  });
}


