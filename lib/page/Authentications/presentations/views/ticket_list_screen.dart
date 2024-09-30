import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import '../controllers/ticket_list_controller.dart';

class TicketListScreen extends GetView<TicketListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Ticket Details', style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchTickets,
          ),
          IconButton(onPressed: (){}, icon: Icon(FeatherIcons.plus))
        ],
      ),
      body: Column(
        children: [
          _buildTopBar(),
          _buildSearchBar(),
          Expanded(
            child: Obx(() => controller.isLoading.value
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
            onPressed: () {/* Implement import functionality */},
            child: Text('Import', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13)),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: appColor),
            onPressed: () {/* Implement export functionality */},
            child: Text('Export', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Obx(() => DropdownButton<String>(
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

  Widget _buildTicketTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          border: TableBorder(
            horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
          ),
          columnSpacing: 20,
          headingRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            return Colors.grey.shade100;
          }),
          columns: [
            DataColumn(label: Text('Ticket ID', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Customer Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Sub-Customer Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Technician Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Start Date/Time', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('End Date/Time', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Total Time', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Address', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Region', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Purpose', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Ticket Date', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Aging', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: controller.tickets.map((ticket) {
            return DataRow(
              cells: [
                DataCell(Text(ticket.id.toString())),
                DataCell(Text(ticket.customerDetails.customerName ?? 'NA')),
                DataCell(Text(ticket.subCustomerDetails.customerName ?? 'NA')),
                DataCell(Text('${ticket.assignTo.firstName} ${ticket.assignTo.lastName}')),
                DataCell(Text(ticket.startDateTime?.toString() ?? 'NA')),
                DataCell(Text(ticket.endDateTime?.toString() ?? 'NA')),
                DataCell(Text(ticket.totalTime)),
                DataCell(Text(ticket.ticketAddress.primaryAddress ?? 'NA')),
                DataCell(Text(ticket.ticketAddress.region ?? 'NA')),
                DataCell(Text(ticket.purpose ?? 'NA')),
                DataCell(Text(ticket.status)),
                DataCell(Text(ticket.date)),
                DataCell(Text(ticket.aging?.toString() ?? 'NA')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}