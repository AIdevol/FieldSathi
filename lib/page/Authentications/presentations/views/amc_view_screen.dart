import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/amc_screen_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_amc_view_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../../widgets/views/add_amc_view_screen.dart';

class AMCViewScreen extends GetView<AMCScreenController> {
  // Ensure the controller is initialized
  @override
  final AMCScreenController controller = Get.put(AMCScreenController());

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            title: Text(
              'AMC',
              style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 15,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.addAmcCallenderScreen);
                },
                icon: Icon(Icons.calendar_month),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.createamcScreen);
                },
                icon: Icon(FeatherIcons.plus),
              ).paddingSymmetric(horizontal: 20.0),
            ],
          ),
          body: Column(
            children: [
              _buildTopBar(),
              vGap(10),
              _mainData(),
              vGap(10),
              // Expanded(child: _buildTicketTable()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200, // Consider making this responsive
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _totalAmcWidget(),
            hGap(20),
            _totalUpcomingWidget(),
            hGap(20),
            _totalRenewalWidget(),
            hGap(20),
            _totalCompletedWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
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
          // controller.updateSearch(value); // Implement this method in your controller
        },
      ),
    );
  }

  Widget _totalAmcWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total AMC',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
          Text(
              '0',
              // controller.totalAmc.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalUpcomingWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.greenAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upcoming',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
           Text(
              '0',
              // controller.totalUpcoming.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalRenewalWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Renewal',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
            Text(
              '',
              // controller.totalRenewal.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _totalCompletedWidget() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.redAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Completed',
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
            vGap(20),
             Text(
              '0',
              // controller.totalCompleted.value.toString(),
              style: MontserratStyles.montserratBoldTextStyle(size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
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
          Expanded(child: _buildSearchField()),
          hGap(10),
          ElevatedButton(
            onPressed: () => _showImportModelView(),
            style: _buttonStyle(),
            child: Text(
              'Import',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
          ),
          hGap(10),
          ElevatedButton(
            onPressed: () {
              // controller.exportData(); // Implement this method in your controller
            },
            child: Text(
              'Export',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
            style: _buttonStyle(),
          ),
          hGap(10),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: appColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black.withOpacity(0.5),
    );
  }

  void _showImportModelView() {
    Get.dialog(
      AlertDialog(
        title: Text('Import File'),
        content: SizedBox(
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
                    // controller.importFile(result); // Handle the file in controller
                    Get.snackbar('File Selected', 'You selected: $fileName');
                    Get.back(); // Close the dialog
                  }
                },
                child: Text('Select File from Local'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: appColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 /* Widget _buildTicketTable() {
    return Obx(() {
      if (controller.amcData.isEmpty) {
        return Center(child: Text('No AMC data found'));
      }

      // Define columns
      List<PlutoColumn> columns = [
        PlutoColumn(
          title: 'Name',
          field: 'name',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Date',
          field: 'date',
          type: PlutoColumnType.date(),
          // You can add a date format if needed
        ),
        PlutoColumn(
          title: 'Customer Name',
          field: 'customerName',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Services',
          field: 'services',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Service Amount',
          field: 'serviceAmount',
          type: PlutoColumnType.number(),
        ),
        PlutoColumn(
          title: 'Service Occurrence',
          field: 'serviceOccurrence',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Remaining Amount',
          field: 'remainingAmount',
          type: PlutoColumnType.number(),
        ),
        PlutoColumn(
          title: 'Remainder',
          field: 'remainder',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Status',
          field: 'status',
          type: PlutoColumnType.text(),
        ),
        PlutoColumn(
          title: 'Actions',
          field: 'actions',
          type: PlutoColumnType.text(),
          renderer: (rendererContext) {
            return Center(
              child: PopupMenuButton<String>(
                color: CupertinoColors.white,
                offset: Offset(0, 56),
                onSelected: (value) {
                  if (value == 'Edit') {
                    // controller.editAmc(rendererContext.row);
                  } else if (value == 'Delete') {
                    // controller.deleteAmc(rendererContext.row);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Edit',
                    child: ListTile(
                      leading: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.black),
                      title: Text('Edit'),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Delete',
                    child: ListTile(
                      leading: Icon(Icons.delete, size: 20, color: Colors.red),
                      title: Text('Delete'),
                    ),
                  ),
                ],
                child: Icon(Icons.more_horiz, size: 20),
              ),
            );
          },
        ),
      ];

      // Define rows
      List<PlutoRow> rows = controller.amcData.map((amc) {
        return PlutoRow(cells: {
          'name': PlutoCell(value: amc.amcName ?? 'NA'),
          'date': PlutoCell(value: amc.activationDate != null ? amc.activationDate!.toString() : 'NA'),
          'customerName': PlutoCell(value: amc.customer ?? 'NA'),
          'services': PlutoCell(value: amc.selectServiceOccurrence ?? 'NA'),
          'serviceAmount': PlutoCell(value: amc.serviceAmount ?? 0),
          'serviceOccurrence': PlutoCell(value: amc.selectServiceOccurrence ?? 'NA'),
          'remainingAmount': PlutoCell(value: amc.remainingAmount ?? 0),
          'remainder': PlutoCell(value: amc.remainder ?? 'NA'),
          'status': PlutoCell(value: amc.status ?? 'NA'),
          'actions': PlutoCell(value: ''),
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
          enableMoveHorizontalInEditing: true,
        ),
      );
    });
  }*/
}
