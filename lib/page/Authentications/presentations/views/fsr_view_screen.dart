import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
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
                  },
                  icon: const Icon(FeatherIcons.plus),
                ).paddingOnly(left: 20.0)
              ],
            ),
            body: Column(
              children: [
                _buildSearchBar(controller),
                Expanded(
                  child: _mainDataRowAndColumn(
                    context: context,
                    controller: controller,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mainDataRowAndColumn({
    required BuildContext context,
    required FsrViewcontroller controller,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          horizontalMargin: 50,
          border: TableBorder(
            horizontalInside: BorderSide(width: 1, color: Colors.grey.shade300),
          ),
          columnSpacing: 60,
          headingRowColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return Colors.grey.shade100;
            },
          ),
          columns: const [
            DataColumn(label: Text('Sr. No.')),
            DataColumn(label: Text('FSR Name')),
            DataColumn(label: Text('FSR Categories')),
            DataColumn(label: Text('Actions')),
          ],
          rows: controller.filteredTickets.asMap().entries.map((entry) {
            final index = entry.key;
            final FsrResponseModel fsrData = entry.value;

            String categoryNames = fsrData.categories
                ?.map((category) => category.name ?? '')
                .where((name) => name.isNotEmpty)
                .join(', ') ?? '';

            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(fsrData.fsrName ?? '')),
                DataCell(Text(categoryNames)),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      // Handle info button press
                    },
                  ),
                ),
              ],
            );
          }).toList(),
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