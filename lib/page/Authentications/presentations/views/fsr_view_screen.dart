import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../../../constans/color_constants.dart';
import '../../../../navigations/navigation.dart';
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
                style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
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
                  child: _buildTicketList(controller),
                ),
              ],
            ),
          ),
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
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(color: Colors.grey),
          prefixIcon: Icon(FeatherIcons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        style: MontserratStyles.montserratSemiBoldTextStyle(color: Colors.black),
        onChanged: (value) {
          controller.updateSearch(value);
        },
      ),
    );
  }

  Widget _buildCheckpointStatusButton() {
    return ElevatedButton(
      onPressed: () => _buildAlertButton(context: Get.context!),
      style: _buttonStyle(),
      child: Text(
        'CheckPoint Status',
        style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
      ),
    );
  }

  Widget _buildTicketList(FsrViewcontroller controller) {
    return Obx(() => ListView.builder(
      itemCount: controller.filteredTickets.length,
      itemBuilder: (context, index) {
        final ticket = controller.filteredTickets[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            title: Text(
              'Name: ${ticket.Name}',
              style: MontserratStyles.montserratSemiBoldTextStyle(color: blackColor, size: 14),
            ),
            subtitle: Text(
              'Categories: ${ticket.Categories}',
              style: MontserratStyles.montserratRegularTextStyle(color: Colors.grey, size: 12),
            ),
            trailing: ElevatedButton(
              onPressed: () => controller.makeChanges(ticket.Name),
              style: _buttonStyle(),
              child: Text(
                'Make Changes',
                style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 12),
              ),
            ),
          ),
        );
      },
    ));
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(appColor),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
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

void _buildAlertButton({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Checkpoint Status",
            style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 16),
          ),
          vGap(20),
          TextField(
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
                // Implement checkpoint status update logic here
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(appColor),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                elevation: MaterialStateProperty.all(3),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: Text(
                '+CheckPoint Status',
                style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}