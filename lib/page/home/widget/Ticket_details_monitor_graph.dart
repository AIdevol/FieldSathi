import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import '../presentations/controllers/graph_view_controller.dart';

class GraphViewScreen extends GetView<GraphViewController> {
  const GraphViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 8.0 : 16.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                // Pie Chart Section
                Container(
                  margin: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
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
                        height: screenSize.height * 0.35,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback: (FlTouchEvent event,
                                      pieTouchResponse) {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      controller.setTouchedIndex(-1);
                                      return;
                                    }
                                    controller.setTouchedIndex(pieTouchResponse
                                        .touchedSection!
                                        .touchedSectionIndex);
                                  },
                                ),
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 3,
                                centerSpaceRadius:
                                isSmallScreen ? 60 : 80,
                                sections: _showingSections(controller),
                              ),
                            ),
                            _buildCenterStats(controller),
                          ],
                        ),
                      ),
                      _buildLegend(controller),
                    ],
                  ),
                ),

                // Grid View Section with responsive layout
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isSmallScreen ? 2 : 3,
                    childAspectRatio: isSmallScreen ? 1.0 : 1.2,
                    mainAxisSpacing: isSmallScreen ? 8.0 : 16.0,
                    crossAxisSpacing: isSmallScreen ? 8.0 : 16.0,
                  ),
                  itemCount: 7, // Total number of stat cards
                  itemBuilder: (context, index) {
                    return _buildResponsiveStatCard(
                      context,
                      controller,
                      index,
                      isSmallScreen,
                    );
                  },
                ),
                SizedBox(height: 20), // Bottom padding
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildCenterStats(GraphViewController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Total',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${controller.totalTicketsCount.value}',
          style: const TextStyle(
            fontSize: 22,
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
    );
  }

  Widget _buildResponsiveStatCard(
      BuildContext context,
      GraphViewController controller,
      int index,
      bool isSmallScreen,
      ) {
    final statConfigs = [
      (
      'Completed',
      controller.completedTicketsCount.value,
      Icons.check_circle,
      Colors.blue
      ),
      (
      'Accepted',
      controller.acceptedTicketsCount.value,
      Icons.thumb_up,
      Colors.pink
      ),
      (
      'Ongoing',
      controller.ongoingTicketsCount.value,
      Icons.timer,
      Colors.amber
      ),
      (
      'Inactive',
      controller.inactiveTicketsCount.value,
      Icons.block,
      Colors.purple
      ),
      (
      'On-Hold',
      controller.onHoldTicketsCount.value,
      Icons.pause_circle,
      Colors.green
      ),
      (
      'Rejected',
      controller.rejectedTicketsCount.value,
      Icons.cancel,
      Colors.red
      ),
      ('Total', controller.totalTicketsCount.value, Icons.people, Colors.orange),
    ];

    if (index >= statConfigs.length) return const SizedBox.shrink();

    final config = statConfigs[index];
    final percentage = controller.getPercentage(config.$2);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Material(
        elevation: 1,
        shadowColor: appColor.withOpacity(0.03),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 30),
        ),
        child: Container(
          padding: EdgeInsets.all(isSmallScreen ? 15 : 20.0),
          decoration: BoxDecoration(
            color: config.$4.shade50,
            borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    config.$3,
                    size: isSmallScreen ? 40 : 52,
                    color: config.$4.shade400,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 26,
                        fontWeight: FontWeight.bold,
                        color: config.$4.shade400,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        config.$1,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          color: config.$4.shade400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${config.$2} tickets',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          title: '',
          radius: 60,
          titleStyle: const TextStyle(fontSize: 0),
        ),
      ];
    }

    final sections = <PieChartSectionData>[];
    final data = [
      (Colors.blue.shade400, controller.completedTicketsCount.value, 'Completed'),
      (Colors.pink.shade400, controller.acceptedTicketsCount.value, 'Accepted'),
      (Colors.amber.shade400, controller.ongoingTicketsCount.value, 'Ongoing'),
      (Colors.purple.shade400, controller.inactiveTicketsCount.value, 'Inactive'),
      (Colors.green.shade400, controller.onHoldTicketsCount.value, 'On-Hold'),
      (Colors.red.shade400, controller.rejectedTicketsCount.value, 'Rejected'),
    ];

    for (var i = 0; i < data.length; i++) {
      final isTouched = i == controller.touchedIndex;
      final radius = isTouched ? 50.0 : 40.0;
      final percentage = controller.getPercentage(data[i].$2);

      if (percentage > 0) {
        sections.add(
          PieChartSectionData(
            color: data[i].$1,
            value: percentage,
            title: '',
            radius: radius,
            titleStyle: const TextStyle(fontSize: 0),
          ),
        );
      }
    }

    return sections;
  }


  Widget _buildLegend(GraphViewController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          _LegendItem(color: Colors.blue.shade400, label: 'Completed'),
          _LegendItem(color: Colors.pink.shade400, label: 'Accepted'),
          _LegendItem(color: Colors.amber.shade400, label: 'Ongoing'),
          _LegendItem(color: Colors.purple.shade400, label: 'Inactive'),
          _LegendItem(color: Colors.green.shade400, label: 'On-Hold'),
          _LegendItem(color: Colors.red.shade400, label: 'Rejected'),
        ],
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
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 6.0 : 8.0,
        vertical: isSmallScreen ? 3.0 : 4.0,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isSmallScreen ? 12 : 16,
            height: isSmallScreen ? 12 : 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: isSmallScreen ? 4 : 6),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmallScreen ? 10 : 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

