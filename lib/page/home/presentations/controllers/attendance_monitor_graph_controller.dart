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

  // Observable values for attendance counts
  RxInt presentCount = 0.obs;
  RxInt absentCount = 0.obs;
  RxInt idleCount = 0.obs;
  RxInt totalCount = 0.obs;
  RxList<TechnicianResults> attendanceResponses = <TechnicianResults>[].obs;
  RxList<TechnicianResults> filteredTechnicians = <TechnicianResults>[].obs;

  @override
  void onInit() {
    super.onInit();
    hitGetAttendanceApiCall();
  }

  void calculateAttendance() {
    // Reset counters
    presentCount.value = 0;
    absentCount.value = 0;
    idleCount.value = 0;

    // Set total from actual technicians list
    totalCount.value = attendanceResponses.length;

    // Calculate counts for each status
    for (var technician in attendanceResponses) {
      if (technician.todayAttendance != null) {
        final status = technician.todayAttendance['status']?.toString().toLowerCase() ?? '';

        switch (status) {
          case 'present':
            presentCount.value++;
            break;
          case 'absent':
            absentCount.value++;
            break;
          case 'idle':
            idleCount.value++;
            break;
        }
      } else {
        // If no attendance record exists, count as absent
        absentCount.value++;
      }
    }

    // Debug prints
    print('Present Count: ${presentCount.value}');
    print('Absent Count: ${absentCount.value}');
    print('Idle Count: ${idleCount.value}');
    print('Total Count: ${totalCount.value}');
  }

  Future<void> hitGetAttendanceApiCall() async {
    try {
      isLoading.value = true;
      customLoader.show();
      FocusManager.instance.primaryFocus?.unfocus();

      final roleWiseData = {'role': 'technician'};
      final response = await Get.find<AuthenticationApiService>()
          .getTechnicianApiCall(parameters: roleWiseData);

      // Update both lists
      attendanceResponses.assignAll(response.results);
      filteredTechnicians.assignAll(response.results);

      // Calculate attendance statistics
      calculateAttendance();

      // Store technician IDs
      final technicianIds = response.results.map((e) => e.id.toString()).toList();
      await storage.write(attendanceId, technicianIds.join(','));

      customLoader.hide();
      toast('Technicians fetched successfully');
    } catch (error, stackTrace) {
      print('Error fetching technicians: $error');
      print('Stack trace: $stackTrace');
      customLoader.hide();
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
    final presentPercentage = totalCount.value > 0
        ? (presentCount.value / totalCount.value) * 100
        : 0.0;

    if (presentPercentage > 70) {
      return const LinearGradient(
        colors: [Colors.green, Colors.greenAccent],
      );
    } else if (presentPercentage > 50) {
      return const LinearGradient(
        colors: [Colors.orange, Colors.orangeAccent],
      );
    } else {
      return const LinearGradient(
        colors: [Colors.red, Colors.redAccent],
      );
    }
  }
}