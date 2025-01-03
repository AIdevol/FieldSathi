import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentations/controllers/amc_status_monitor_graph_controller.dart';

class AmcStatusBarChart extends StatelessWidget {
  final controller = Get.find<AmcStatusMonitorGraphController>();

  AmcStatusBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AspectRatio(
        aspectRatio: 1.6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLegend(),
              const SizedBox(height: 16),
              Expanded(
                flex: 3,
                child: _buildChart(),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildLegend() {
    const legends = [
      {'color': Colors.blue, 'label': 'Upcoming'},
      {'color': Colors.yellow, 'label': 'Renewal'},
      {'color': Colors.purple, 'label': 'Completed'},
      {'color': Colors.red, 'label': 'Expired'},
      {'color': Colors.green, 'label': 'Total'}
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: legends.map((legend) {
          return _LegendItem(
            color: legend['color'] as Color,
            label: legend['label'] as String,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChart() {
    final List<int> counts = [
      controller.totalCount.value,
      controller.upcomingCount.value,
      controller.renewalCount.value,
      controller.completedCount.value,
      controller.expiredCount.value,
    ];

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: controller.totalCount.value.toDouble(),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const titles = ['Total', 'Upcoming', 'Renewal', 'Completed', 'Expired'];
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    titles[value.toInt()],
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
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: controller.totalCount.value > 0
                  ? (controller.totalCount.value / 5).toDouble()
                  : 1.0,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: controller.totalCount.value > 0
              ? (controller.totalCount.value / 5).toDouble()
              : 1.0,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        barGroups: counts
            .asMap()
            .map((index, value) {
          final colors = [
            Colors.green,
            Colors.blue,
            Colors.yellow,
            Colors.purple,
            Colors.red,
          ];
          return MapEntry(
            index,
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value.toDouble(),
                  color: colors[index],
                  width: 36,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
              // Removed showingTooltipIndicators to hide the count boxes
            ),
          );
        })
            .values
            .toList(),
      ),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 4),
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