import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import '../../../../response_models/attendance_response_model.dart';
import '../controller/show_technician_data_controller.dart';

class TechniciansFullViewDetailsDescriptionScreen extends GetView<ShowTechnicianDataController> {
  const TechniciansFullViewDetailsDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<ShowTechnicianDataController>(
        init: ShowTechnicianDataController(),
        builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: appColor,
            title: Text(
              'Attendance Lists',
              style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),
            ),
          ),
          body: _listViewContainerScreen(context, controller),
        ),
      ),
    );
  }

  Widget _listViewContainerScreen(BuildContext context, ShowTechnicianDataController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.attendanceData.isEmpty) {
        return Center(child: Text('No attendance data available'));
      } else {
        return ListView.separated(
          itemCount: controller.attendanceData.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: Get.height * 0.1,
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  width: 0.80,
                  color: Colors.black,
                ),
              ),
              child: _mainViewScreenResultAfterDataFetchedLists(controller, index, context),
            );
          },
          separatorBuilder: (BuildContext context, int index) => vGap(10),
        );
      }
    });
  }

  Widget _mainViewScreenResultAfterDataFetchedLists(ShowTechnicianDataController controller, int index, context) {
    TechnicianData technician = controller.attendanceData[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _profileImageOfTheTechnicianCircularViewResult(technician),
        hGap(20),
        _technicianDetailsDataViewScreenPresentationResult(technician),
        hGap(20),
        _calenderViewPresentScreenPresentationResultandShowingDateOfAttendance(technician, context, controller),
      ],
    );
  }

  Widget _profileImageOfTheTechnicianCircularViewResult(TechnicianData technician) {
    return CircleAvatar(
      radius: 35,
      backgroundImage: technician.profileImage != null
          ? NetworkImage(technician.profileImage)
          : null,
      child: technician.profileImage == null ? Icon(Icons.person) : null,
    );
  }

  Widget _technicianDetailsDataViewScreenPresentationResult(TechnicianData technician) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${technician.firstName} ${technician.lastName}',
            style: MontserratStyles.montserratSemiBoldTextStyle(size: 16, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            technician.todayAttendance?.status ?? 'Not Marked',
            style: MontserratStyles.montserratSemiBoldTextStyle(
              size: 14,
              color: technician.todayAttendance?.status == 'Present' ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _calenderViewPresentScreenPresentationResultandShowingDateOfAttendance(TechnicianData technician, context, ShowTechnicianDataController controller) {
    return IconButton(
      onPressed: () {
        _calenderViewScreen(controller, context);
      },
      icon: Icon(Icons.calendar_month_rounded, color: Colors.black),
    );
  }
}

void _calenderViewScreen(ShowTechnicianDataController controller, context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: Get.height * 0.5,
          width: Get.width * 0.8,
          color: appColor,
          // Add calendar view implementation here
        ),
      );
    },
  );
}