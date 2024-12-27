// attendance_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/attendance_screen_controller.dart';
import '../../../../constans/color_constants.dart';
import '../../../../constans/role_based_keys.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../main.dart';

class AttendanceScreen extends GetView<AttendanceScreenController> {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Obx(() {
          return controller.isLoading.value

              ? Column(
            children: [
              _buildExportButton(context),
              Expanded(child: _buildMainContent()),
            ],
          ):    Center(child: Container());
        }),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87),
      ),
      backgroundColor: appColor,
      title: Text(
        "Attendance",
        style: MontserratStyles.montserratBoldTextStyle(
          color: blackColor,
          size: 15,
        ),
      ),
    );
  }

  Widget _buildExportButton(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _buildActionButton(
          context,
          'Export all Attendance data',
          Icons.download,
          onTap: () => _showExportDialog(context),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        vGap(30),
        _buildStatCard("Total", controller.totalUsers, Colors.blue),
        vGap(30),
        _buildStatCard("Present", controller.totalPresent, Colors.green),
        vGap(30),
        _buildStatCard("Absent", controller.totalAbsent, Colors.red),
        vGap(30),
        _buildStatCard("Idle", controller.totalIdle, Colors.amber),
      ],
    );
  }

  FloatingActionButton? _buildFloatingActionButton() {
    final userrole = storage.read(userRole);
    if (userrole == 'technician' || userrole == 'sale') return null;

    return FloatingActionButton(
      onPressed: () => Get.toNamed(AppRoutes.showViewAllDataAttendanceScreen),
      backgroundColor: appColor,
      child: const Icon(Icons.remove_red_eye, color: Colors.white),
    );
  }

  Widget _buildStatCard(String title, RxInt value, Color color) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.showViewAllDataAttendanceScreen),
      child: Material(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        elevation: 4,
        child: Container(
          height: Get.height * 0.2,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    title,
                    style: MontserratStyles.montserratBoldTextStyle(
                      size: 25,
                      color: color,
                    ),
                  ),
                  vGap(20),
                  Obx(() => Text(
                    value.toString(),
                    style: MontserratStyles.montserratBoldTextStyle(
                      size: 30,
                      color: color,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton1(
      BuildContext context,
      String label,
      IconData icon, {
        required VoidCallback onTap,
      }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(
        label,
        style: MontserratStyles.montserratSemiBoldTextStyle(size: 13),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context,
      String label,
      IconData icon, {
        required VoidCallback onTap,
      }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(
        label,
        style: MontserratStyles.montserratSemiBoldTextStyle(size: 13),
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
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
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogHeader(),
              divider(color: Colors.grey),
              const SizedBox(height: 20),
              _buildDateSelectionRow(context),
              vGap(30),
              _buildDialogButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Download Report",
          style: MontserratStyles.montserratBoldTextStyle(
            size: 15,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildDateSelectionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: CustomTextField(
            controller: controller.startDateController,
            labletext: 'Start Date',
            hintText: "dd-mm-yyyy",
            readOnly: true,
            onTap: () => _selectDate(context, isStartDate: true),
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
            controller: controller.endDateController,
            labletext: 'End Date',
            hintText: "dd-mm-yyyy",
            readOnly: true,
            onTap: () => _selectDate(context, isStartDate: false),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton1(
          context,
          'Cancel',
          Icons.cancel,
          onTap: () => Get.back(),
        ),
        _buildActionButton1(
          context,
          'Download Excel',
          Icons.download,
          onTap: (){} /*=> controller.downloadReport()*/,
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, {required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      if (isStartDate) {
        controller.startDateController.text = formattedDate;
      } else {
        controller.endDateController.text = formattedDate;
      }
    }
  }
}