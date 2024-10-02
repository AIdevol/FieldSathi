import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import '../controllers/ticket_list_controller.dart';

class TicketListScreen extends GetView<TicketListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Ticket Details',
            style: MontserratStyles.montserratBoldTextStyle(
                size: 18, color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchTicketsApiCall,
          ),
          IconButton(onPressed: () {
            Get.toNamed(AppRoutes.ticketListCreationScreen);
          }, icon: Icon(FeatherIcons.plus))
        ],
      ),
      body: Column(
        children: [
          _buildTopBar(),
          _buildSearchBar(),
          Expanded(
            child: Obx(() =>
            controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : _buildTicketTable()),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: _buildFilterDropdown()),
          SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: appColor),
            onPressed: () {
              /* Implement import functionality */
            },
            child: Text('Import',
                style: MontserratStyles.montserratSemiBoldTextStyle(size: 13)),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: appColor),
            onPressed: () {
              /* Implement export functionality */
            },
            child: Text('Export',
                style: MontserratStyles.montserratSemiBoldTextStyle(size: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Obx(() =>
        DropdownButton<String>(
          value: controller.selectedFilter.value,
          items: controller.filterTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: controller.updateSelectedFilter,
        ));
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: controller.updateSearchQuery,
        decoration: const InputDecoration(
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
//
// Widget _buildTicketTable() {
//   return Obx(() => DataTable2(
//     columns: const [
//       DataColumn2(label: Text('Select'), size: ColumnSize.S),
//       DataColumn2(label: Text('Ticket ID'), size: ColumnSize.S),
//       DataColumn2(label: Text('Customer Name'), size: ColumnSize.M),
//       DataColumn2(label: Text('Sub-Customer Name'), size: ColumnSize.M),
//       DataColumn2(label: Text('Technician Name'), size: ColumnSize.M),
//       DataColumn2(label: Text('Start Date/Time'), size: ColumnSize.M),
//       DataColumn2(label: Text('End Date/Time'), size: ColumnSize.M),
//       DataColumn2(label: Text('Total Time'), size: ColumnSize.S),
//       DataColumn2(label: Text('Address'), size: ColumnSize.L),
//       DataColumn2(label: Text('Region'), size: ColumnSize.M),
//       DataColumn2(label: Text('Purpose'), size: ColumnSize.M),
//       DataColumn2(label: Text('Status'), size: ColumnSize.S),
//       DataColumn2(label: Text('Ticket Date'), size: ColumnSize.M),
//       DataColumn2(label: Text('Aging'), size: ColumnSize.S),
//     ],
//     rows: controller.ticketData.map((ticket) {
//       return DataRow2(
//         cells: [
//           DataCell(Checkbox(
//             value: ticket.isSelected ?? false,
//             onChanged: (bool? value) {
//               controller.toggleTicketSelection(ticket, value ?? false);
//             },
//           )),
//           DataCell(Text(ticket.id?.toString() ?? 'Testing')),
//           DataCell(Text(ticket.customerDetails?.name ?? '')),
//           DataCell(Text(ticket.subCustomerDetails?.subCustomerName ?? '')),
//           DataCell(Text('${ticket.assignTo?.firstName ?? ''} ${ticket.assignTo?.lastName ?? ''}')),
//           DataCell(Text(ticket.startDateTime ?? '')),
//           DataCell(Text(ticket.endDateTime ?? '')),
//           DataCell(Text(ticket.totalTime ?? '')),
//           DataCell(Text('${ticket.ticketAddress?.city ?? ''}, ${ticket.ticketAddress?.state ?? ''}')),
//           DataCell(Text(ticket.ticketAddress?.country ?? '')),
//           DataCell(Text(ticket.purpose ?? '')),
//           DataCell(Text(ticket.status ?? '')),
//           DataCell(Text(ticket.date ?? '')),
//           DataCell(Text(ticket.aging?.toString() ?? '')),
//         ],
//       );
//     }).toList(),
//   ));
// }

 /* Widget _buildTicketTable() {
    return Obx(() {
      // if (controller.ticketData.isEmpty) {
      //   return Center(child: Text('No tickets found'));
      // }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            border: TableBorder(
              horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
            ),
            columnSpacing: 20,
            headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
            columns: [
              DataColumn(label: Text('Ticket ID', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13, color: Colors.black))),
              DataColumn(label: Text('Customer Name', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13, color: Colors.black))),
              DataColumn(label: Text('Sub-Customer Name', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('Technician Name', style:MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('Start Date/Time', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('End Date/Time', style:MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('Total Time', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('Address', style:MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('Region', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('Purpose', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('Status', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('Ticket Date', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
              DataColumn(label: Text('Aging', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: Colors.black))),
            ],
            rows: controller.ticketData.map((ticket) {
              return DataRow(
                cells: [
                  DataCell(Text(ticket.id?.toString() ?? 'NA')),
                  DataCell(Text(ticket.customerDetails?.name ?? 'NA')),
                  DataCell(Text(ticket.subCustomerDetails?.subCustomerName ?? 'NA')),
                  DataCell(Text('${ticket.assignTo?.firstName ?? ''} ${ticket.assignTo?.lastName ?? ''}'.trim())),
                  DataCell(Text(ticket.startDateTime ?? 'NA')),
                  DataCell(Text(ticket.endDateTime ?? 'NA')),
                  DataCell(Text(ticket.totalTime ?? 'NA')),
                  DataCell(Text('${ticket.ticketAddress?.city ?? ''}, ${ticket.ticketAddress?.state ?? ''}'.trim())),
                  DataCell(Text(ticket.ticketAddress?.country ?? 'NA')),
                  DataCell(Text(ticket.purpose ?? 'NA')),
                  DataCell(Text(ticket.status ?? 'NA')),
                  DataCell(Text(ticket.date ?? 'NA')),
                  DataCell(Text(ticket.aging?.toString() ?? 'NA')),
                ],
              );
            }).toList(),
          ),
        ),
      );
    });
  }*/
  Widget _buildTicketTable() {
    return Obx(() {
      // if (controller.ticketData.isEmpty) {
      //   return Center(child: Text('No tickets found'));
      // }

      // Define columns
      List<PlutoColumn> columns = [
        PlutoColumn(
          title: 'Ticket ID',
          field: 'ticket_id',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Customer Name',
          field: 'customer_name',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Sub-Customer Name',
          field: 'sub_customer_name',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Technician Name',
          field: 'technician_name',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Start Date/Time',
          field: 'start_datetime',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'End Date/Time',
          field: 'end_datetime',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Total Time',
          field: 'total_time',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Address',
          field: 'address',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Region',
          field: 'region',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Purpose',
          field: 'purpose',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Status',
          field: 'status',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Ticket Date',
          field: 'ticket_date',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Aging',
          field: 'aging',
          type: PlutoColumnType.number(),
        ),
      ];

      // Define rows
      List<PlutoRow> rows = controller.ticketData.map((ticket) {
        return PlutoRow(cells: {
          'ticket_id': PlutoCell(value: ticket.id?.toString() ?? 'NA'),
          'customer_name': PlutoCell(value: ticket.customerDetails?.name ?? 'NA'),
          'sub_customer_name': PlutoCell(value: ticket.subCustomerDetails?.subCustomerName ?? 'NA'),
          'technician_name': PlutoCell(value: '${ticket.assignTo?.firstName ?? ''} ${ticket.assignTo?.lastName ?? ''}'.trim()),
          'start_datetime': PlutoCell(value: ticket.startDateTime ?? 'NA'),
          'end_datetime': PlutoCell(value: ticket.endDateTime ?? 'NA'),
          'total_time': PlutoCell(value: ticket.totalTime ?? 'NA'),
          'address': PlutoCell(value: '${ticket.ticketAddress?.city ?? ''}, ${ticket.ticketAddress?.state ?? ''}'.trim()),
          'region': PlutoCell(value: ticket.ticketAddress?.country ?? 'NA'),
          'purpose': PlutoCell(value: ticket.purpose ?? 'NA'),
          'status': PlutoCell(value: ticket.status ?? 'NA'),
          'ticket_date': PlutoCell(value: ticket.date ?? 'NA'),
          'aging': PlutoCell(value: ticket.aging?.toString() ?? 'NA'),
        });
      }).toList();

      return PlutoGrid(
        columns: columns,
        rows: rows,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          event.stateManager.setShowColumnFilter(true); // Enables column filtering
        },
        onChanged: (PlutoGridOnChangedEvent event) {
          print('Cell value changed: ${event.value}');
        },
        configuration: PlutoGridConfiguration(
          // enableColumnBorder: true,
          // gridBorderRadius: BorderRadius.circular(5),
          enableMoveHorizontalInEditing: true,
        ),
      );
    });
  }
}
