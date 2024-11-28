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

  RxList<TechnicianData> attendanceResponses = <TechnicianData>[].obs;
  RxList<TechnicianData> filteredTechnicians = <TechnicianData>[].obs;

  @override
  void onInit() {
    super.onInit();
    hitGetAttendanceApiCall();
  }

  void calculateAttendance(int total) {
    // Calculate percentages based on total
    final double presentRatio = 0.65; // 65% present
    final double idleRatio = 0.15;    // 15% idle
    final double absentRatio = 0.20;  // 20% absent

    // Calculate actual counts
    presentCount.value = (total * presentRatio).round();
    idleCount.value = (total * idleRatio).round();
    absentCount.value = (total * absentRatio).round();
    totalCount.value = total;

    // Calculate percentages
    presentPercentage.value = (presentCount.value / total) * 100;
    idlePercentage.value = (idleCount.value / total) * 100;
    absentPercentage.value = (absentCount.value / total) * 100;

    // Debug prints
    print('Total Count: $total');
    print('Present Count: ${presentCount.value} (${presentPercentage.value}%)');
    print('Absent Count: ${absentCount.value} (${absentPercentage.value}%)');
    print('Idle Count: ${idleCount.value} (${idlePercentage.value}%)');
  }

  Future<void> hitGetAttendanceApiCall() async {
    try {
      isLoading.value = true;
      FocusManager.instance.primaryFocus?.unfocus();

      final roleWiseData = {'role': 'technician'};
      final response = await Get.find<AuthenticationApiService>()
          .getTechnicianApiCall(parameters: roleWiseData);

      attendanceResponses.assignAll(response.results!);
      filteredTechnicians.assignAll(response.results!);

      // Calculate attendance based on total count from response
      calculateAttendance(response.count!);

      // Store technician IDs
      final technicianIds = response.results!.map((e) => e.id.toString()).toList();
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
}