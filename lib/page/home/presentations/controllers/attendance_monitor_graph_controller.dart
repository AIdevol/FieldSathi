import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/response_models/technician_response_model.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class AttendanceGraphViewController extends GetxController {
  RxBool isLoading = true.obs;
  final _touchedIndex = (-1).obs;
  int get touchedIndex => _touchedIndex.value;
  void setTouchedIndex(int index) => _touchedIndex.value = index;

  // Observable values for attendance counts with percentage
  RxDouble presentPercentage = 0.0.obs;
  RxDouble absentPercentage = 0.0.obs;
  RxDouble idlePercentage = 0.0.obs;

  // Count values
  RxInt presentCount = 0.obs;
  RxInt absentCount = 0.obs;
  RxInt idleCount = 0.obs;
  RxInt totalCount = 0.obs;

  RxSet<TechnicianResponseModel>setTechnicianData = <TechnicianResponseModel>{}.obs;
  RxList<TechnicianData> attendanceResponses = <TechnicianData>[].obs;
  RxList<TechnicianData> filteredTechnicians = <TechnicianData>[].obs;

  @override
  void onInit() {
    super.onInit();
    hitGetAttendanceApiCall();
    hitGetAttendanceCountsApiCall();
  }

  // void calculateToTechnicianStatus() {
  //   presentCount.value = 0;
  //   absentCount.value = 0;
  //   idleCount.value = 0;
  //
  //   // Calculate the total count from technician data
  //   totalCount.value = setTechnicianData.isEmpty
  //       ? 0
  //       : setTechnicianData.first.count?.toInt() ?? 0;
  //
  //   // Loop through technicians
  //   for (var technician in attendanceResponses) {
  //     // Process only if there is attendance data
  //     if (technician.todayAttendance.isNotEmpty) {
  //       for (var attendance in technician.todayAttendance) {
  //         String status = attendance.status?.toLowerCase() ?? 'unknown';
  //
  //         print("Status: $status");
  //         switch (status) {
  //           case 'present':
  //             presentCount.value++;
  //             break;
  //           case 'absent':
  //             absentCount.value++;
  //             break;
  //           case 'idle':
  //             idleCount.value++;
  //             break;
  //           default:
  //             // Handle unknown or missing statuses
  //             absentCount.value++;
  //             break;
  //         }
  //       }
  //     }
  //   }
  //
  //   // Calculate percentages
  //   if (totalCount.value > 0) {
  //     presentPercentage.value = (presentCount.value / totalCount.value) * 100;
  //     absentPercentage.value = (absentCount.value / totalCount.value) * 100;
  //     idlePercentage.value = (idleCount.value / totalCount.value) * 100;
  //   } else {
  //     // If totalCount is 0, set percentages to 0
  //     presentPercentage.value = 0;
  //     absentPercentage.value = 0;
  //     idlePercentage.value = 0;
  //   }

    // Debug prints for verification
  //   print('Present Count: ${presentCount.value}');
  //   print('Absent Count: ${absentCount.value}');
  //   print('Idle Count: ${idleCount.value}');
  //   print('Total Count: ${totalCount.value}');
  //   print('Present Percentage: ${presentPercentage.value}');
  //   print('Absent Percentage: ${absentPercentage.value}');
  //   print('Idle Percentage: ${idlePercentage.value}');
  //
  //   // Refresh UI
  //   update();
  // }


  Future<void> hitGetAttendanceApiCall() async {
    try {
      isLoading.value = true;
      FocusManager.instance.primaryFocus?.unfocus();

      final roleWiseData = {'role': 'technician'};
      final response = await Get.find<AuthenticationApiService>()
          .getTechnicianApiCall(parameters: roleWiseData);
      setTechnicianData.add(response);
      attendanceResponses.assignAll(response.results!);
      filteredTechnicians.assignAll(response.results!);
      final technicianIds = response.results.map((e) => e.id.toString()).toList();
      await storage.write(attendanceId, technicianIds.join(','));
      toast('Technicians fetched successfully');
    } catch (error, stackTrace) {
      print('Error fetching technicians: $error');
      print('Stack trace: $stackTrace');
      toast('Error fetching technicians: ${error.toString()}');
    } finally {
      isLoading.value = false;
      update();
    }
  }



  List<FlSpot> getGraphSpots() {
    return [
      const FlSpot(0, 0),
      FlSpot(1, presentCount.value.toDouble()),
      FlSpot(2, (presentCount.value + absentCount.value).toDouble()),
      FlSpot(3, totalCount.value.toDouble()),
    ];
  }

  LinearGradient getGraphGradient() {
    if (presentPercentage.value > 70) {
      return const LinearGradient(
        colors: [Colors.green, Colors.greenAccent],
      );
    } else if (presentPercentage.value > 50) {
      return const LinearGradient(
        colors: [Colors.orange, Colors.orangeAccent],
      );
    } else {
      return const LinearGradient(
        colors: [Colors.red, Colors.redAccent],
      );
    }
  }

  void hitGetAttendanceCountsApiCall(){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().getTechnicianStatusCountsDataApiCall().then((value){
      presentCount.value = value.totalTechnicianPresent!;
      totalCount.value = value.totalTechnicianCount!;
      idleCount.value = value.totalTechnicianIdle!;
      absentCount.value = value.totalTechnicianAbsent!;

      presentPercentage.value = (presentCount.value / totalCount.value) * 100;
      idlePercentage.value = (idleCount.value / totalCount.value) * 100;
      absentPercentage.value = (absentCount.value / totalCount.value) * 100;
        print('chachaji: ${ totalCount.value}');
      update();
    }).onError((error,stackError){
      toast(error.toString());
    });
  }
}