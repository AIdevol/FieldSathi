import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tms_sathi/page/Authentications/presentations/views/ticket_list_screen.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';


import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controllers/LeaveReportViewScreenController.dart';

class LeaveReportViewScreen extends GetView<LeaveReportViewScreenController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Leaves',style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchTickets,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {}
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTopBar(),
          _buildSearchBar(),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : _buildDataGrid()),
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
            child: Text('Import',style: MontserratStyles.montserratSemiBoldTextStyle(size: 13)),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: appColor),
            onPressed: () {/* Implement export functionality */},
            child: Text('Export',style: MontserratStyles.montserratSemiBoldTextStyle(size: 13),),
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

  Widget _buildDataGrid() {
    return Obx(() => SfDataGrid(
      source: TicketDataSource(tickets: controller.tickets),
      columns: [
        GridColumn(columnName: 'id', label: _buildHeaderCell('Ticket ID')),
        GridColumn(columnName: 'customerName', label: _buildHeaderCell('Customer Name')),
        GridColumn(columnName: 'subCustomerName', label: _buildHeaderCell('Sub-Customer Name')),
        GridColumn(columnName: 'technicianName', label: _buildHeaderCell('Technician Name')),
        GridColumn(columnName: 'startDateTime', label: _buildHeaderCell('Start Date/Time')),
        GridColumn(columnName: 'endDateTime', label: _buildHeaderCell('End Date/Time')),
        GridColumn(columnName: 'time', label: _buildHeaderCell('Time')),
        GridColumn(columnName: 'address', label: _buildHeaderCell('Address')),
        GridColumn(columnName: 'region', label: _buildHeaderCell('Region')),
        GridColumn(columnName: 'purpose', label: _buildHeaderCell('Purpose')),
        GridColumn(columnName: 'status', label: _buildHeaderCell('Status')),
        GridColumn(columnName: 'ticketDate', label: _buildHeaderCell('Ticket Date')),
        GridColumn(columnName: 'aging', label: _buildHeaderCell('Aging')),
      ],
    ));
  }

  Widget _buildHeaderCell(String title) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}