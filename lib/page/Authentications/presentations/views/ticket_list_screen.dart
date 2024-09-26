import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import '../../widgets/views/ticket_model_data.dart';
import '../controllers/ticket_list_controller.dart';
import '../../widgets/views/ticket_list_creation.dart';

class TicketListScreen extends GetView<TicketListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Ticket Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchTickets,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.to(() => TicketListCreation()),
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

class TicketDataSource extends DataGridSource {
  TicketDataSource({required List<Ticket> tickets}) {
    _tickets = tickets
        .map<DataGridRow>((ticket) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: ticket.id),
      DataGridCell<String>(columnName: 'customerName', value: ticket?.customerName),
      DataGridCell<String>(columnName: 'subCustomerName', value: ticket.subCustomerName),
      DataGridCell<String>(columnName: 'technicianName', value: ticket.technicianName),
      DataGridCell<String>(columnName: 'startDateTime', value: _formatDateTime(ticket.startDateTime)),
      DataGridCell<String>(columnName: 'endDateTime', value: _formatDateTime(ticket.endDateTime)),
      DataGridCell<String>(columnName: 'time', value: ticket.time),
      DataGridCell<String>(columnName: 'address', value: ticket.address),
      DataGridCell<String>(columnName: 'region', value: ticket.region),
      DataGridCell<String>(columnName: 'purpose', value: ticket.purpose),
      DataGridCell<String>(columnName: 'status', value: ticket.status),
      DataGridCell<String>(columnName: 'ticketDate', value: _formatDate(ticket.ticketDate)),
      DataGridCell<String>(columnName: 'aging', value: ticket.aging),
    ]))
        .toList();
  }

  List<DataGridRow> _tickets = [];

  @override
  List<DataGridRow> get rows => _tickets;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}