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
      // if (controller.isLoading.value) {
      //   return const Center(child: CircularProgressIndicator());
      // }

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
      {'color': Colors.green, 'label': 'Total'}
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: legends.map((legend) {
        return _LegendItem(
          color: legend['color'] as Color,
          label: legend['label'] as String,
        );
      }).toList(),
    );
  }

  Widget _buildChart() {
    final List<double> values = [
      controller.upcomingPercentage.value,
      controller.renewalPercentage.value,
      controller.completedPercentage.value,
      controller.totalPercentage.value,
    ];
    final List<int> counts = [
      controller.upcomingCount.value,
      controller.renewalCount.value,
      controller.completedCount.value,
      controller.totalCount.value,
    ];

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: Colors.black54,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                'Count: ${counts[groupIndex]}\nPercentage: ${rod.toY.toStringAsFixed(1)}%',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const titles = ['Upcoming', 'Renewal', 'Completed', 'Total'];
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
              reservedSize: 45,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}%',
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
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.shade300),
        ),
        extraLinesData: ExtraLinesData(
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
        ),
        barGroups: values
            .asMap()
            .map((index, value) {
          final colors = [Colors.blue, Colors.yellow, Colors.purple, Colors.green];
          return MapEntry(
            index,
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value,
                  color: colors[index],
                  width: 36,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
              showingTooltipIndicators: [0],
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
