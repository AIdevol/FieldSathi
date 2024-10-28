import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../presentations/controllers/graph_view_controller.dart';

class GraphViewScreen extends GetView<GraphViewController> {
  const GraphViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GraphViewController>(
      init: GraphViewController(),
      builder: (controller) => Scaffold(
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            // Pie Chart Section
            Container(
              height: 300,
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  // Pie Chart
                  Expanded(
                    flex: 3,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              controller.setTouchedIndex(-1);
                              return;
                            }
                            controller.setTouchedIndex(pieTouchResponse
                                .touchedSection!.touchedSectionIndex);
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: showingSections(controller),
                      ),
                    ),
                  ),
                  // Expanded(flex:2 ,child: _buildLegend()),
                  // Legend
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendItem(
                          Colors.blue.shade400,
                          'Completed',
                          controller.completedTicketsCount.value,
                          controller.getPercentage(
                              controller.completedTicketsCount.value),
                        ),
                        const SizedBox(height: 8),
                        _buildLegendItem(
                          Colors.amber.shade400,
                          'Ongoing',
                          controller.ongoingTicketsCount.value,
                          controller.getPercentage(
                              controller.ongoingTicketsCount.value),
                        ),
                        const SizedBox(height: 8),
                        _buildLegendItem(
                          Colors.purple.shade400,
                          'Inactive',
                          controller.inactiveTicketsCount.value,
                          controller.getPercentage(
                              controller.inactiveTicketsCount.value),
                        ),
                        const SizedBox(height: 8),
                        _buildLegendItem(
                          Colors.green.shade400,
                          'On-Hold',
                          controller.onHoldTicketsCount.value,
                          controller.getPercentage(
                              controller.onHoldTicketsCount.value),
                        ),
                        const SizedBox(height: 8),
                        _buildLegendItem(
                          Colors.red.shade400,
                          'Rejected',
                          controller.rejectedTicketsCount.value,
                          controller.getPercentage(
                              controller.rejectedTicketsCount.value),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Divider
            // const Divider(height: 10),

            // Grid View Section
            Expanded(
              child: SizedBox(
                height: Get.height*0.05,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 1.5,
                  children: [
                    _buildStatCard(
                      title: 'Completed',
                      count: controller.completedTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.completedTicketsCount.value),
                      icon: Icons.check_circle,
                      backgroundColor: Colors.blue.shade50,
                      iconColor: Colors.blue.shade400,
                    ),
                    _buildStatCard(
                      title: 'Ongoing',
                      count: controller.ongoingTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.ongoingTicketsCount.value),
                      icon: Icons.timer,
                      backgroundColor: Colors.amber.shade50,
                      iconColor: Colors.amber.shade400,
                    ),
                    _buildStatCard(
                      title: 'Inactive',
                      count: controller.inactiveTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.inactiveTicketsCount.value),
                      icon: Icons.block,
                      backgroundColor: Colors.purple.shade50,
                      iconColor: Colors.purple.shade400,
                    ),
                    _buildStatCard(
                      title: 'On-Hold',
                      count: controller.onHoldTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.onHoldTicketsCount.value),
                      icon: Icons.pause_circle,
                      backgroundColor: Colors.green.shade50,
                      iconColor: Colors.green.shade400,
                    ),
                    _buildStatCard(
                      title: 'Rejected',
                      count: controller.rejectedTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.rejectedTicketsCount.value),
                      icon: Icons.cancel,
                      backgroundColor: Colors.red.shade50,
                      iconColor: Colors.red.shade400,
                    ),
                    _buildStatCard(
                      title: 'Total',
                      count: controller.totalTicketsCount.value,
                      percentage: 100.0,
                      icon: Icons.rocket_launch,
                      backgroundColor: Colors.orange.shade50,
                      iconColor: Colors.orange.shade400,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _LegendItem(
          color: Colors.blue,
          label: 'Completed',
        ),
        SizedBox(width: 16),
        _LegendItem(
          color: Colors.yellow,
          label: 'Ongoing',
        ),
        SizedBox(width: 16),
        _LegendItem(
          color: Colors.purple,
          label: 'Inactive',
        ),
        SizedBox(width: 16),
        _LegendItem(
          color: Colors.green,
          label: 'On-Holding',
        ),
        SizedBox(width: 16),
        _LegendItem(
          color: Colors.red,
          label: 'Rejected',
        ),
        SizedBox(width: 16),
        _LegendItem(
          color: Colors.orange,
          label: 'Total',
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label, int count, double percentage) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label: $count (${percentage.toStringAsFixed(1)}%)',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required int count,
    required double percentage,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    // double? height,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: () {
            // Handle tap event if needed
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        icon,
                        size: 32,
                        color: iconColor,
                      ),
                      Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                  ),
                  Text(
                    '$count tickets',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(GraphViewController controller) {
    if (controller.totalTicketsCount.value == 0) {
      return [
        PieChartSectionData(
          color: Colors.grey.shade300,
          value: 100,
          title: 'No Data',
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ];
    }

    final sections = <PieChartSectionData>[];
    final data = [
      (Colors.blue.shade400, controller.completedTicketsCount.value, 'Completed'),
      (Colors.amber.shade400, controller.ongoingTicketsCount.value, 'Ongoing'),
      (Colors.purple.shade400, controller.inactiveTicketsCount.value, 'Inactive'),
      (Colors.green.shade400, controller.onHoldTicketsCount.value, 'On-Hold'),
      (Colors.red.shade400, controller.rejectedTicketsCount.value, 'Rejected'),
      (Colors.orange.shade400, controller.totalTicketsCount.value, 'Total'),
    ];

    for (var i = 0; i < data.length; i++) {
      final isTouched = i == controller.touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      final percentage = controller.getPercentage(data[i].$2);

      if (percentage > 0) {
        sections.add(
          PieChartSectionData(
            color: data[i].$1,
            value: percentage,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: const [
                Shadow(color: Colors.black, blurRadius: 2),
              ],
            ),
          ),
        );
      }
    }

    return sections;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
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