import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/attendance_screen_controller.dart';
import 'package:tms_sathi/utilities/hex_color.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../../widgets/views/show_technician_data.dart';

class AttendanceScreen extends GetView<AttendanceScreenController>{

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(child: SafeArea(child: GetBuilder<AttendanceScreenController>(builder: (controller)=> Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Attendance", style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),),
        actions: [TextButton(
          onPressed: () {
            Get.toNamed(AppRoutes.showViewAllDataAttendanceScreen);},
          child: Text(
            "View All",
            style: MontserratStyles.montserratSemiBoldTextStyle(size: 13, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),],
      ),
      body: _mainScreenWidget(controller),
    ))));
  }

  _mainScreenWidget(AttendanceScreenController controller){
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: [
        // _rowViewWidget(controller),
      vGap(30),
        _totalViewScreenWidget(controller),
      vGap(30),
      _presentViewScreenWidget(controller),
        vGap(30),
        _absentViewScreenWidget(controller),
        vGap(30),
        _idleVieScreenWidget(controller)
    ],);
  }
}

_totalViewScreenWidget(AttendanceScreenController controller){
  // final Count = controller.attendanceResponses.map((count)=> count.count).toString();
  return GestureDetector(onTap: (){
    print('present button tapped');
  },child: Container(
    height: Get.height * 0.2,
    width: Get.width,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      color: HexColor('F6CFFC'),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Center(
        child: Column(children: [
          Text(controller.totalUsers.value.toString(), style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
          vGap(20),
          Text("Total Users", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
        ],),
      ),
    ),
  ),);
}

_presentViewScreenWidget(AttendanceScreenController controller){
  return GestureDetector(onTap: (){
    print('present button tapped');
  },child: Container(
    height: Get.height * 0.2,
    width: Get.width,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      color: lightgreens,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Center(
        child: Column(children: [
          Text(controller.totalPresent.value.toString(), style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
          vGap(20),
          Text("Present", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
        ],),
      ),
    ),
  ),);
}

_absentViewScreenWidget(AttendanceScreenController controller){
  return GestureDetector(onTap: (){
    print('absent button tapped');
  },child: Container(
    height: Get.height * 0.2,
    width: Get.width,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      color: HexColor('E8C5AF'),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Center(
        child: Column(children: [
          Text(controller.totalAbsent.value.toString(), style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
          vGap(20),
          Text("Absent", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
        ],),
      ),
    ),
  ),);
}

_idleVieScreenWidget(AttendanceScreenController controller){
  return GestureDetector(onTap: (){
    print('idle button tapped');
  },child: Container(
    height: Get.height * 0.2,
    width: Get.width,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      color: HexColor('FFEA94'),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Center(
        child: Column(children: [
          Text(controller.totalIdle.value.toString(), style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
          vGap(20),
          Text("Idle", style: MontserratStyles.montserratBoldTextStyle(size:18,color: Colors.black),),
        ],),
      ),
    ),
  ),);
}

Widget _rowViewWidget(AttendanceScreenController controller) {
  return Row(
    children: [
      // Expanded(
      //   flex: 4,
      //   child: CustomTextField(
      //     hintText: "Search technicians...",
      //     prefix: Icon(Icons.search, color: Colors.grey),
      //     // onTap: () => controller.searchTechnicians,
      //     // controller: controller.searchController,
      //   ),
      // ),
      // SizedBox(width: 10),
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
         Get.toNamed(AppRoutes.showViewAllDataAttendanceScreen);},
          child: Text(
            "View All",
            style: MontserratStyles.montserratSemiBoldTextStyle(size: 13, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}


// Widget _buildLegendItem(String label, Color color) {
//   return Row(
//     children: [
//       Container(
//         width: 20,
//         height: 20,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: color,
//           border: Border.all(color: Colors.grey),
//         ),
//       ),
//       const SizedBox(width: 8),
//       Text(label),
//     ],
//   );
// }

// class CalendarViews extends GetView<AttendanceScreenController> {
//   const CalendarViews({Key? key}) : super(key: key);
//
//   void _showEventDialog(AttendanceScreenController controller) {
//     final startDate = DateTime.parse(controller.start!);
//     final endDate = DateTime.parse(controller.end!);
//
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Header with Icon and Close Button
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(
//                     Icons.celebration,
//                     color: Color(
//                         int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')
//                     ),
//                     size: 30,
//                   ),
//                   IconButton(
//                     onPressed: () => Get.back(),
//                     icon: const Icon(Icons.close),
//                     padding: EdgeInsets.zero,
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 15),
//
//               // Event Title
//               Text(
//                 event.title ?? 'Holiday',
//                 style: MontserratStyles.montserratBoldTextStyle(
//                   color: blackColor,
//                   size: 18,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//
//               const SizedBox(height: 20),
//
//               // Date Range
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.calendar_today, size: 20),
//                     const SizedBox(width: 10),
//                     Text(
//                       '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
//                       style: MontserratStyles.montserratNormalTextStyle(
//                         color: blackColor,
//                         size: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 15),
//
//               // Description (if available)
//               if (event.description != null && event.description!.isNotEmpty)
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[50],
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.grey[200]!),
//                   ),
//                   child: Text(
//                     event.description!,
//                     style: MontserratStyles.montserratNormalTextStyle(
//                       color: blackColor,
//                       size: 14,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: true,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CalendarController>(
//       init: CalendarController(),
//       builder: (controller) => Scaffold(
//         appBar: AppBar(
//           title: Text(
//               'Calendar',
//               style: MontserratStyles.montserratBoldTextStyle(
//                   color: blackColor,
//                   size: 15
//               )
//           ),
//           backgroundColor: appColor,
//         ),
//         body: Column(
//           children: [
//             Obx(() => TableCalendar<Result>(
//               firstDay: DateTime.utc(2024, 1, 1),
//               lastDay: DateTime.utc(2024, 12, 31),
//               focusedDay: controller.focusedDay.value,
//               calendarFormat: controller.calendarFormat.value,
//               selectedDayPredicate: (day) {
//                 return isSameDay(controller.selectedDay.value, day);
//               },
//               onDaySelected: (selectedDay, focusedDay) {
//                 controller.onDaySelected(selectedDay, focusedDay);
//               },
//               onFormatChanged: (format) {
//                 controller.onFormatChanged(format);
//               },
//               eventLoader: (day) {
//                 return controller.getEventsForDay(day);
//               },
//               calendarStyle: CalendarStyle(
//                 todayDecoration: BoxDecoration(
//                   color: Colors.blue.withOpacity(0.5),
//                   shape: BoxShape.circle,
//                 ),
//                 selectedDecoration: const BoxDecoration(
//                   color: Colors.blue,
//                   shape: BoxShape.circle,
//                 ),
//                 markerDecoration: const BoxDecoration(
//                   color: Colors.red,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//               headerStyle: const HeaderStyle(
//                 formatButtonVisible: true,
//                 titleCentered: true,
//                 formatButtonShowsNext: false,
//               ),
//               calendarBuilders: CalendarBuilders(
//                 markerBuilder: (context, date, events) {
//                   if (events.isEmpty) return null;
//
//                   return Positioned(
//                     right: 1,
//                     top: 0,
//                     child: _buildHolidayMarker(
//                         Color(int.parse(events.first.color?.replaceAll('#', '0xFF') ?? 'FF0000'))
//                     ),
//                   );
//                 },
//               ),
//             )),
//             vGap(20),
//             Expanded(
//               child: Obx(() => ListView.builder(
//                 itemCount: controller.selectedEventsResult.length,
//                 itemBuilder: (BuildContext context, index) {
//                   final event = controller.selectedEventsResult[index];
//                   final startDate = DateTime.parse(event.start!);
//                   final endDate = DateTime.parse(event.end!);
//
//                   return GestureDetector(
//                     onTap: () => _showEventDialog(event),
//                     child: Container(
//                       margin: const EdgeInsets.all(5),
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: ListTile(
//                         title: Text(
//                           event.title ?? '',
//                           style: MontserratStyles.montserratBoldTextStyle(
//                               color: blackColor,
//                               size: 15
//                           ),
//                         ),
//                         subtitle: Text(
//                             '${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}',
//                             style: MontserratStyles.montserratNormalTextStyle(
//                                 color: blackColor,
//                                 size: 15
//                             )
//                         ),
//                         leading: Icon(
//                           Icons.celebration,
//                           color: Color(
//                               int.parse(event.color?.replaceAll('#', '0xFF') ?? 'FF0000')
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHolidayMarker(Color color) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: color,
//       ),
//       width: 8.0,
//       height: 8.0,
//     );
//   }
// }