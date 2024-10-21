import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../presentations/controllers/attendance_monitor_graph_controller.dart';

class AttendenceDetailsMonitorGraph extends StatefulWidget {
  const AttendenceDetailsMonitorGraph({super.key});

  @override
  State<AttendenceDetailsMonitorGraph> createState() => _AttendenceDetailsMonitorGraph();
}

class _AttendenceDetailsMonitorGraph extends State<AttendenceDetailsMonitorGraph> {
  final Color primaryColor = const Color(0xFF2196F3);
  final Color accentColor = const Color(0xFFFFA726);
  final Color textColor = const Color(0xFF333333);

  final controller = Get.find<AttendanceGraphViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildGraph(
                    controller.presentCount.value,
                    controller.absentCount.value,
                    controller.idleCount.value,
                    controller.totalCount.value,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _buildAttendanceBoxes(
                  controller.presentCount.value,
                  controller.absentCount.value,
                  controller.idleCount.value,
                  controller.totalCount.value,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAttendanceBoxes(int present, int absent, int idle, int total) {
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
            present,
            Colors.green,
            Image.asset(verifiedPerson, color: textColor, height: 25, width: 25, scale: 2),
          ),
          _buildAttendanceBox(
            'Absent',
            absent,
            Colors.red,
            Image.asset(wrongPerson, color: textColor, height: 25, width: 25, scale: 2),
          ),
          _buildAttendanceBox(
            'Idle     ',
            idle,
            Colors.amber,
            Image.asset(idleImage, color: textColor, height: 30, width: 30, scale: 2),
          ),
          _buildAttendanceBox(
            'Total  ',
            total,
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

  Widget _buildGraph(int present, int absent, int idle, int total) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 3,
        minY: 0,
        maxY: total.toDouble(),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 0),
              FlSpot(1, present.toDouble()),
              FlSpot(2, present.toDouble() + absent.toDouble()),
              FlSpot(3, total.toDouble()),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [primaryColor, accentColor],
            ),
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
    );
  }
}
