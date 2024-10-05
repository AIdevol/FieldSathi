import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_fsr_view_controller.dart';
import '../../../../constans/color_constants.dart';
import '../../../../navigations/navigation.dart';
import '../../../../response_models/fsr_response_model.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../controllers/fsr_screen_controller.dart';

class FsrViewScreen extends GetView<FsrViewcontroller> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<FsrViewcontroller>(
          builder: (controller) => Scaffold(
            appBar: AppBar(
              backgroundColor: appColor,
              title: Text(
                'FSR',
                style: MontserratStyles.montserratBoldTextStyle(
                  color: blackColor,
                  size: 15,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.addfsrScreen);
                    toast("Add your New FSR");
                  },
                  icon: const Icon(FeatherIcons.plus),
                ).paddingOnly(left: 20.0)
              ],
            ),
            body: Column(
              children: [
                _buildSearchBar(controller),
                Expanded(
                  child: Obx(() =>
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : _buildPlutoGrid(controller),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlutoGrid(FsrViewcontroller controller) {
    List<PlutoColumn> columns = [
      PlutoColumn(
        title: 'Sr. No.',
        field: 'srNo',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'FSR Name',
        field: 'fsrName',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'FSR Categories',
        field: 'fsrCategories',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        type: PlutoColumnType.number(),
        renderer: (rendererContext) {
          return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: PopupMenuButton<String>(
                    color: CupertinoColors.white,
                    offset: Offset(0, 56),
                    itemBuilder: (BuildContext context)=><PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Edit',
                        onTap: (){
                          // Get.toNamed(AppRoutes.editProfile);
                        },
                        child: const ListTile(
                          leading: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.black,),
                          title: Text('Edit'),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Delete',
                        onTap: (){
                          // Get.toNamed(AppRoutes.editProfile);
                        },
                        child: const ListTile(
                          leading: Icon(Icons.delete, size: 20,color: Colors.red,),
                          title: Text('Delete'),
                        ),
                      ),
                    ],
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Icon(Icons.more_vert, size: 20,))
                ),
              ),
          );
        },
      ),
    ];

    List<PlutoRow> rows = controller.filteredTickets.asMap().entries.map((entry) {
      final index = entry.key;
      final FsrResponseModel fsrData = entry.value;

      String categoryNames = fsrData.categories
          .map((category) => category.name)
          .where((name) => name.isNotEmpty)
          .join(', ') ?? '';

      return PlutoRow(
        cells: {
          'srNo': PlutoCell(value: index + 1),
          'fsrName': PlutoCell(value: fsrData.fsrName),
          'fsrCategories': PlutoCell(value: categoryNames),
          'actions':PlutoCell(value: '')
        },
      );
    }).toList();

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        // You can perform actions when the grid is loaded
      },
      onChanged: (PlutoGridOnChangedEvent event) {
        // Handle changes in the grid
      },
      configuration: PlutoGridConfiguration(
        columnFilter: PlutoGridColumnFilterConfig(
          filters: const [
            ...FilterHelper.defaultFilters,
          ],
          resolveDefaultColumnFilter: (column, resolver) {
            if (column.field == 'number') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            }

            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar(FsrViewcontroller controller) {
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
        children: [
          Expanded(
            child: _buildSearchField(controller),
          ),
          hGap(10),
          _buildCheckpointStatusButton(),
          hGap(10),
        ],
      ),
    );
  }

  Widget _buildSearchField(FsrViewcontroller controller) {
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
        controller: controller.searchController,
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
          controller.updateSearch(value);
        },
      ),
    );
  }

  Widget _buildCheckpointStatusButton() {
    return ElevatedButton(
      onPressed: () => _buildAlertDialog(Get.context!),
      style: _buttonStyle(),
      child: Text(
        'CheckPoint Status',
        style: MontserratStyles.montserratBoldTextStyle(
          color: whiteColor,
          size: 13,
        ),
      ),
    );
  }

  void _buildAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Checkpoint Status",
              style: MontserratStyles.montserratBoldTextStyle(
                color: Colors.black,
                size: 16,
              ),
            ),
            vGap(20),
            TextField(
              controller: controller.checkPointStatusCheckingController,
              focusNode: controller.checkPointStatusCheckingFocusNode,
              decoration: InputDecoration(
                hintText: 'Checkpoint status',
                border: OutlineInputBorder(),
              ),
            ),
            vGap(20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  controller.hitPostCheckingStatusApiCall();
                  Navigator.of(context).pop();
                },
                style: _buttonStyle(),
                child: Text(
                  '+CheckPoint Status',
                  style: MontserratStyles.montserratBoldTextStyle(
                    color: whiteColor,
                    size: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(appColor),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      ),
      elevation: MaterialStateProperty.all(3),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.3)),
    );
  }
}