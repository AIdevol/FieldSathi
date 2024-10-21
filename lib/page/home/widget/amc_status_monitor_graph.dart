import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentations/controllers/amc_status_monitor_graph_controller.dart';

class AmcStatusMonitorGraph extends GetView<AmcStatusMonitorGraphController> {
  const AmcStatusMonitorGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : AspectRatio(
      aspectRatio: 1.6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLegend(),
            const SizedBox(height: 16),
            Expanded(child: _buildChart()),
          ],
        ),
      ),
    ));
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _LegendItem(
          color: Colors.blue,
          label: 'Upcoming',
        ),
        SizedBox(width: 16),
        _LegendItem(
          color: Colors.yellow,
          label: 'Renewal',
        ),
        SizedBox(width: 16),
        _LegendItem(
          color: Colors.purple,
          label: 'Completed',
        ),
        SizedBox(width: 16),
        _LegendItem(
          color: Colors.green,
          label: 'Total',
        ),
      ],
    );
  }

  Widget _buildChart() {
    // Using percentage values for Y-axis max
    const yAxisMax = 100.0;

    return Obx(() => BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: yAxisMax,
        barTouchData: _buildBarTouchData(),
        titlesData: _buildTitlesData(),
        gridData: _buildGridData(),
        borderData: _buildBorderData(),
        extraLinesData: _buildExtraLinesData(),
        barGroups: [
          _createBarData(
            0,
            controller.upcomingPercentage.value,
            controller.upcomingCount.value,
            Colors.blue,
          ),
          _createBarData(
            1,
            controller.renewalPercentage.value,
            controller.renewalCount.value,
            Colors.yellow,
          ),
          _createBarData(
            2,
            controller.completedPercentage.value,
            controller.completedCount.value,
            Colors.purple,
          ),
          _createBarData(
            3,
            controller.totalPercentage.value,
            controller.totalCount.value,
            Colors.green,
          ),
        ],
      ),
    ));
  }

  BarTouchData _buildBarTouchData() {
    return BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            'Count: ${rod.rodStackItems.isEmpty ? rod.toY.toInt() : rod.rodStackItems.first.toY.toInt()}\n'
                'Percentage: ${rod.toY.toStringAsFixed(1)}%',
            const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const categories = ['Upcoming', 'Renewal', 'Completed', 'Total'];
            if (value.toInt() >= 0 && value.toInt() < categories.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  categories[value.toInt()],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              );
            }
            return const Text('');
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 45,
          interval: 20, // Show percentage intervals of 20
          getTitlesWidget: (value, meta) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                '${value.toInt()}%',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 20, // Grid lines every 20%
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.grey.shade300,
          strokeWidth: 1,
        );
      },
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(
      show: true,
      border: Border.all(color: Colors.grey.shade300),
    );
  }

  ExtraLinesData _buildExtraLinesData() {
    return ExtraLinesData(
      horizontalLines: [
        HorizontalLine(
          y: controller.upcomingTarget,
          color: Colors.blue,
          strokeWidth: 2,
          dashArray: [5, 5],
          label: HorizontalLineLabel(
            show: true,
            labelResolver: (line) => 'Target: ${controller.upcomingTarget}%',
            alignment: Alignment.topRight,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        HorizontalLine(
          y: controller.completedTarget,
          color: Colors.purple,
          strokeWidth: 2,
          dashArray: [5, 5],
          label: HorizontalLineLabel(
            show: true,
            labelResolver: (line) => 'Target: ${controller.completedTarget}%',
            alignment: Alignment.topRight,
            style: const TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData _createBarData(int x, double percentage, int count, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: percentage,
          color: color,
          width: 40,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}