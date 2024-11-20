import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../presentations/controllers/attendance_monitor_graph_controller.dart';

class AttendanceMonitorDashboard extends StatelessWidget {
  AttendanceMonitorDashboard({Key? key}) : super(key: key);

  final controller = Get.find<AttendanceGraphViewController>();
  final Color primaryColor = const Color(0xFF2196F3);
  final Color accentColor = const Color(0xFFFFA726);
  final Color textColor = const Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSummaryHeader(),
              const SizedBox(height: 20),
              _buildAttendanceChart(),
              const SizedBox(height: 20),
              _buildAttendanceBoxes(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSummaryHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attendance Overview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Employees: ${controller.totalCount}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          _buildProgressIndicators(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicators() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCircularProgress(
            'Present',
            controller.presentPercentage.value,
            Colors.green,
          ),
          hGap(10),
          _buildCircularProgress(
            'Absent',
            controller.absentPercentage.value,
            Colors.red,
          ),
          hGap(10),
          _buildCircularProgress(
            'Idle',
            controller.idlePercentage.value,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress(String label, double percentage, Color color) {
    return CircularPercentIndicator(
      radius: 40.0,
      lineWidth: 10.0,
      animation: true,
      percent: percentage / 100,
      center: Text(
        '${percentage.toStringAsFixed(1)}%',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
      backgroundColor: Colors.white24,
    );
  }

  Widget _buildAttendanceChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 3,
          minY: 0,
          maxY: controller.totalCount.value.toDouble(),
          lineBarsData: [
            LineChartBarData(
              spots: controller.getGraphSpots(),
              isCurved: true,
              gradient: controller.getGraphGradient(),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 6,
                    color: accentColor,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.3),
                    accentColor.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceBoxes() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          _buildAttendanceBox(
            'Present',
            controller.presentCount.value,
            Colors.green,
            Image.asset(verifiedPerson, color: textColor, height: 25, width: 25, scale: 2),
          ),
          _buildAttendanceBox(
            'Absent',
            controller.absentCount.value,
            Colors.red,
            Image.asset(wrongPerson, color: textColor, height: 25, width: 25, scale: 2),
          ),
          _buildAttendanceBox(
            'Idle     ',
            controller.idleCount.value,
            Colors.amber,
            Image.asset(idleImage, color: textColor, height: 30, width: 30, scale: 2),
          ),
          _buildAttendanceBox(
            'Total  ',
            controller.totalCount.value,
            primaryColor,
            Icon(Icons.group, size: 25),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceBox(String label, int value, Color color, Widget icon) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                icon,
                hGap(10),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}