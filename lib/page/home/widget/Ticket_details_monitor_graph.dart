import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../presentations/controllers/graph_view_controller.dart';

class GraphViewScreen extends GetView<GraphViewController> {
  const GraphViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GraphViewController>(
      init: GraphViewController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              // Pie Chart Section with improved styling
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection ==
                                          null) {
                                    controller.setTouchedIndex(-1);
                                    return;
                                  }
                                  controller.setTouchedIndex(
                                      pieTouchResponse
                                          .touchedSection!
                                          .touchedSectionIndex);
                                },
                              ),
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 3,
                              centerSpaceRadius: 80,
                              sections: _showingSections(controller),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                '${controller.totalTicketsCount.value}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Text(
                                'Tickets',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildLegend(controller),
                  ],
                ),
              ),

              // Grid View Section with improved stat cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                  children: [
                    _buildAnimatedStatCard(
                      title: 'Completed',
                      count: controller.completedTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.completedTicketsCount.value),
                      icon: Icons.check_circle,
                      backgroundColor: Colors.blue.shade50,
                      iconColor: Colors.blue.shade400,
                    ),
                    _buildAnimatedStatCard(
                      title: 'Accepted',
                      count: controller.acceptedTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.acceptedTicketsCount.value),
                      icon: Icons.thumb_up,
                      backgroundColor: Colors.pink.shade50,
                      iconColor: Colors.pink.shade400,
                    ),
                    _buildAnimatedStatCard(
                      title: 'Ongoing',
                      count: controller.ongoingTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.ongoingTicketsCount.value),
                      icon: Icons.timer,
                      backgroundColor: Colors.amber.shade50,
                      iconColor: Colors.amber.shade400,
                    ),
                    _buildAnimatedStatCard(
                      title: 'Inactive',
                      count: controller.inactiveTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.inactiveTicketsCount.value),
                      icon: Icons.block,
                      backgroundColor: Colors.purple.shade50,
                      iconColor: Colors.purple.shade400,
                    ),
                    _buildAnimatedStatCard(
                      title: 'On-Hold',
                      count: controller.onHoldTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.onHoldTicketsCount.value),
                      icon: Icons.pause_circle,
                      backgroundColor: Colors.green.shade50,
                      iconColor: Colors.green.shade400,
                    ),
                    _buildAnimatedStatCard(
                      title: 'Rejected',
                      count: controller.rejectedTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.rejectedTicketsCount.value),
                      icon: Icons.cancel,
                      backgroundColor: Colors.red.shade50,
                      iconColor: Colors.red.shade400,
                    ),
                    _buildAnimatedStatCard(
                      title: 'Total',
                      count: controller.totalTicketsCount.value,
                      percentage: controller.getPercentage(
                          controller.totalTicketsCount.value),
                      icon: Icons.people,
                      backgroundColor: Colors.orange.shade50,
                      iconColor: Colors.orange.shade400,
                    ),
                    vGap(20)
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildLegend(GraphViewController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          _LegendItem(color: Colors.blue.shade400, label: 'Completed'),
          _LegendItem(color: Colors.amber.shade400, label: 'Ongoing'),
          _LegendItem(color: Colors.purple.shade400, label: 'Inactive'),
          _LegendItem(color: Colors.green.shade400, label: 'On-Hold'),
          _LegendItem(color: Colors.red.shade400, label: 'Rejected'),
          _LegendItem(color: Colors.orange.shade400, label: 'Total Tickets'),
        ],
      ),
    );
  }

  Widget _buildAnimatedStatCard({
    required String title,
    required int count,
    required double percentage,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, opacity, child) => Opacity(
        opacity: opacity,
        child: Transform.scale(
          scale: opacity,
          child: child,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              // Optional: Add navigation or details screen
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        icon,
                        size: 36,
                        color: iconColor,
                      ),
                      Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                  ),
                  Text(
                    '$count tickets',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
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

  List<PieChartSectionData> _showingSections(GraphViewController controller) {
    if (controller.totalTicketsCount.value == 0) {
      return [
        PieChartSectionData(
          color: Colors.grey.shade300,
          value: 100,
          title: 'No Data',
          radius: 60,
          titleStyle: const TextStyle(
            fontSize: 18,
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
      (Colors.orange.shade400, controller.totalTicketsCount.value, 'Total Tickets'),
    ];

    for (var i = 0; i < data.length; i++) {
      final isTouched = i == controller.touchedIndex;
      final fontSize = isTouched ? 22.0 : 16.0;
      final radius = isTouched ? 50.0 : 40.0;
      final percentage = controller.getPercentage(data[i].$2);

      if (percentage > 0) {
        sections.add(
          PieChartSectionData(
            color: data[i].$1.withOpacity(0.8),
            value: percentage,
            title: '', // Removed percentage text
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: const [
                Shadow(color: Colors.black45, blurRadius: 3),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
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
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}