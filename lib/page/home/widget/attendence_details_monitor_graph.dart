import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../presentations/controllers/attendance_monitor_graph_controller.dart';

class AttendanceMonitorDashboard extends StatelessWidget {
  AttendanceMonitorDashboard({Key? key}) : super(key: key);

  final controller = Get.find<AttendanceGraphViewController>();

  // Design constants
  final Color primaryColor = const Color(0xFF2196F3);
  final Color accentColor = const Color(0xFFFFA726);
  final Color textColor = const Color(0xFF333333);
  final double borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
          builder: (context, constraints) {
            // Determine if we're on a small screen
            final isSmallScreen = constraints.maxWidth < 600;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 12.0 : 20.0),
                child: Column(
                  children: [
                    _buildSummaryHeader(context, isSmallScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildAttendanceChart(context, isSmallScreen),
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    _buildAttendanceBoxes(context, isSmallScreen),
                  ],
                ),
              ),
            );
          }
      );
    });
  }

  Widget _buildSummaryHeader(BuildContext context, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade800,
            Colors.blue.shade600,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.assessment_rounded,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Attendance Overview',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total Employees: ${controller.totalCount}',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildProgressIndicators(isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildProgressIndicators(bool isSmallScreen) {
    final radius = isSmallScreen ? 35.0 : 45.0;
    final fontSize = isSmallScreen ? 14.0 : 16.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCircularProgress(
              'Present',
              controller.presentPercentage.value,
              Colors.green,
              radius,
              fontSize,
            ),
            SizedBox(width: isSmallScreen ? 16 : 24),
            _buildCircularProgress(
              'Absent',
              controller.absentPercentage.value,
              Colors.red,
              radius,
              fontSize,
            ),
            SizedBox(width: isSmallScreen ? 16 : 24),
            _buildCircularProgress(
              'Idle',
              controller.idlePercentage.value,
              Colors.orange,
              radius,
              fontSize,
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildCircularProgress(
      String label,
      double percentage,
      Color color,
      double radius,
      double fontSize,
      ) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: radius * 0.2,
      animation: true,
      animationDuration: 1500,
      percent: percentage / 100,
      center: Text(
        '${percentage.toStringAsFixed(1)}%',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
      backgroundColor: Colors.white24,
    );
  }

  Widget _buildAttendanceChart(BuildContext context, bool isSmallScreen) {
    return Container(
      height: isSmallScreen ? 200 : 300,
      padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Attendance",
            style: TextStyle(
              fontSize: isSmallScreen ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 40,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                    ),
                  ),
                ),
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
                          accentColor.withOpacity(0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceBoxes(BuildContext context, bool isSmallScreen) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSmallScreen ? 2 : 4,
        crossAxisSpacing: isSmallScreen ? 12 : 16,
        mainAxisSpacing: isSmallScreen ? 12 : 16,
        childAspectRatio: isSmallScreen ? 1.3 : 1.5,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final items = [
          (
          'Present',
          controller.presentCount.value,
          Colors.green,
          Icons.check_circle_outline,
          ),
          (
          'Absent',
          controller.absentCount.value,
          Colors.red,
          Icons.cancel_outlined,
          ),
          (
          'Idle',
          controller.idleCount.value,
          Colors.amber,
          Icons.access_time,
          ),
          (
          'Total',
          controller.totalCount.value,
          primaryColor,
          Icons.groups_outlined,
          ),
        ];

        final (label, value, color, icon) = items[index];
        return _buildAttendanceBox(
          label,
          value,
          color,
          icon,
          isSmallScreen,
        );
      },
    );
  }

  Widget _buildAttendanceBox(
      String label,
      int value,
      Color color,
      IconData icon,
      bool isSmallScreen,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: isSmallScreen ? 24 : 28,
          ),
          SizedBox(height: isSmallScreen ? 8 : 12),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          SizedBox(height: isSmallScreen ? 4 : 8),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}