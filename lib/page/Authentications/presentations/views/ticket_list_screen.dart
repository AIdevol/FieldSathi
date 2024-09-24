  import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_feather_icons/flutter_feather_icons.dart';
  import 'package:get/get.dart';
  import 'package:syncfusion_flutter_datagrid/datagrid.dart';
  import 'package:tms_sathi/page/Authentications/presentations/controllers/ticket_list_controller.dart';

  import '../../../../constans/color_constants.dart';
  import '../../../../utilities/google_fonts_textStyles.dart';
  import '../../../../utilities/helper_widget.dart';
  import '../../widgets/views/ticket_list_creation.dart';

  class TicketListViewScreen extends GetView<TicketListViewScreenController> {
    @override
    Widget build(BuildContext context) {
      return MyAnnotatedRegion(
        child: SafeArea(
          child: GetBuilder<TicketListViewScreenController>(
            builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: appColor,
                title: Text(
                  'Ticket Details',
                  style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.to(() => TicketListCreation());
                    },
                    icon: Icon(FeatherIcons.plus),
                  ).paddingOnly(left: 20.0)
                ],
              ),
              body: Column(
                children: [
                  _buildTopBar(controller),
                  Expanded(
                    child: _buildDataGrid(controller),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildTopBar(TicketListViewScreenController controller) {
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
            _buildSelectedRegionwiseDataExtraction(controller),
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

    Widget _buildSelectedRegionwiseDataExtraction(TicketListViewScreenController controller) {
      return Container(
        height: Get.height * 0.05,
        width: Get.width * 0.40,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: DropdownButton<String>(
          elevation: 1,
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(12),
          padding: EdgeInsets.zero,
          value: controller.dropDownValue.value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: controller.filterType.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(items, style: MontserratStyles.montserratNormalTextStyle()),
                ),
              ),
            );
          }).toList(),
          onChanged: controller.updateDropDownValue,
        ),
      );
    }

    Widget _buildDataGrid(TicketListViewScreenController controller) {
      return SfDataGrid(
        source: TicketDataSource(ticketData: controller.tickets),
        columns: [
          GridColumn(
            columnName: 'id',
            label: _buildHeaderCell('ID'),
          ),
          GridColumn(
            columnName: 'customer_name',
            label: _buildHeaderCell('Customer Name'),
          ),
          GridColumn(
            columnName: 'subcustomer_name',
            label: _buildHeaderCell('Subcustomer Name'),
          ),
          GridColumn(
            columnName: 'technician_name',
            label: _buildHeaderCell('Technician Name'),
          ),
          GridColumn(
            columnName: 'start_datetime',
            label: _buildHeaderCell('Start Datetime'),
          ),
          GridColumn(
            columnName: 'end_datetime',
            label: _buildHeaderCell('End Datetime'),
          ),
          GridColumn(
            columnName: 'time',
            label: _buildHeaderCell('Time'),
          ),
          GridColumn(
            columnName: 'address',
            label: _buildHeaderCell('Address'),
          ),
          GridColumn(
            columnName: 'region',
            label: _buildHeaderCell('Region'),
          ),
          GridColumn(
            columnName: 'purpose',
            label: _buildHeaderCell('Purpose'),
          ),
          GridColumn(
            columnName: 'status',
            label: _buildHeaderCell('Status'),
          ),
          GridColumn(
            columnName: 'ticket_date',
            label: _buildHeaderCell('Ticket Date'),
          ),
          GridColumn(
            columnName: 'aging',
            label: _buildHeaderCell('Aging'),
          ),
        ],
      );
    }

    Widget _buildHeaderCell(String title) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 14),
        ),
      );
    }

    ButtonStyle _buttonStyle() {
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(appColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        elevation: MaterialStateProperty.all(5),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
      );
    }
  }

  // Data Source
  class TicketDataSource extends DataGridSource {
    TicketDataSource({required List<Ticket> ticketData}) {
      _ticketData = ticketData
          .map<DataGridRow>((e) => DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: e.id),
        DataGridCell<String>(columnName: 'customer_name', value: e.Cutstomer_Name),
        DataGridCell<String>(columnName: 'subcustomer_name', value: e.Subcutstomer_Name),
        DataGridCell<String>(columnName: 'technician_name', value: e.Technician_Name),
        DataGridCell<String>(columnName: 'start_datetime', value: e.Start_Datetime),
        DataGridCell<String>(columnName: 'end_datetime', value: e.End_DateTime),
        DataGridCell<String>(columnName: 'time', value: e.Time),
        DataGridCell<String>(columnName: 'address', value: e.Address),
        DataGridCell<String>(columnName: 'region', value: e.Region),
        DataGridCell<String>(columnName: 'purpose', value: e.Purpose),
        DataGridCell<String>(columnName: 'status', value: e.status),
        DataGridCell<String>(columnName: 'ticket_date', value: e.Ticket_Date),
        DataGridCell<String>(columnName: 'aging', value: e.Aging),
      ]))
          .toList();
    }

    List<DataGridRow> _ticketData = [];

    @override
    List<DataGridRow> get rows => _ticketData;

    @override
    DataGridRowAdapter buildRow(DataGridRow row) {
      return DataGridRowAdapter(
          cells: row.getCells().map<Widget>((e) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(e.value.toString()),
            );
          }).toList());
    }
  }

  // Model
  class Ticket {
    final int id;
    final String Cutstomer_Name;
    final String Subcutstomer_Name;
    final String Technician_Name;
    final String Start_Datetime;
    final String End_DateTime;
    final String Time;
    final String Address;
    final String Region;
    final String Purpose;
    final String Ticket_Date;
    final String Aging;
    final String status;

    Ticket({
      required this.id,
      required this.Cutstomer_Name,
      required this.Subcutstomer_Name,
      required this.Technician_Name,
      required this.Start_Datetime,
      required this.End_DateTime,
      required this.Time,
      required this.Address,
      required this.Region,
      required this.Purpose,
      required this.Ticket_Date,
      required this.Aging,
      required this.status,
    });
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