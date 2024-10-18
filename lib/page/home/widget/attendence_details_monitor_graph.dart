import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilities/helper_widget.dart';
import '../presentations/controllers/attendance_monitor_graph_controller.dart';

// class AttendenceDetailsMonitorGraph extends GetView<AttendanceGraphViewController> {
//   const AttendenceDetailsMonitorGraph({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Pie chart on the right
//         Expanded(
//           flex: 3,
//           child: AspectRatio(
//             aspectRatio: 1,
//             child: Obx(() =>
//                 PieChart(
//                   PieChartData(
//                     pieTouchData: PieTouchData(
//                       touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                         if (!event.isInterestedForInteractions ||
//                             pieTouchResponse == null ||
//                             pieTouchResponse.touchedSection == null) {
//                           controller.setTouchedIndex(-1);
//                           return;
//                         }
//                         controller.setTouchedIndex(
//                             pieTouchResponse.touchedSection!
//                                 .touchedSectionIndex);
//                       },
//                     ),
//                     borderData: FlBorderData(show: false),
//                     sectionsSpace: 0,
//                     centerSpaceRadius: 40,
//                     sections: showingSections(),
//                   ),
//                 )),
//           ),
//         ),
//         hGap(20),
//         // Labels on the left
//         Expanded(
//           flex: 2,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 LineChartSample2()
//                 // LabelWidget(color: Colors.blue, label: 'Present'),
//                 // SizedBox(height: 16),
//                 // LabelWidget(color: Colors.yellow, label: 'Absent'),
//                 // SizedBox(height: 16),
//                 // LabelWidget(color: Colors.purple, label: 'Idle'),
//                 // SizedBox(height: 16),
//                 // LabelWidget(color: Colors.green, label: 'Total'),
//               ],
//             ),
//           ),
//         ),
//
//       ],
//     );
//   }
//
// }
class AttendenceDetailsMonitorGraph extends StatefulWidget {
  const AttendenceDetailsMonitorGraph({super.key});

  @override
  State<AttendenceDetailsMonitorGraph> createState() => _AttendenceDetailsMonitorGraph();
}

class _AttendenceDetailsMonitorGraph extends State<AttendenceDetailsMonitorGraph> {
  final Color primaryColor = const Color(0xFF2196F3);
  final Color accentColor = const Color(0xFFFFA726);
  final Color textColor = const Color(0xFF333333);

  int present = 18;
  int absent = 3;
  int idle = 2;
  int total = 23;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        height: Get.height*.09,
          width: Get.width*3,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black)
          ),
          child: _buildGraph()),
    );
  }

  // Widget _buildAttendanceBoxes() {
  //   return GridView.count(
  //     crossAxisCount: 2,
  //     crossAxisSpacing: 16,
  //     mainAxisSpacing: 16,
  //     childAspectRatio: 1,
  //     physics: const NeverScrollableScrollPhysics(),
  //     children: [
  //       _buildAttendanceBox('Present', present, Colors.green),
  //       _buildAttendanceBox('Absent', absent, Colors.red),
  //       _buildAttendanceBox('Idle', idle, Colors.amber),
  //       _buildAttendanceBox('Total', total, primaryColor),
  //     ],
  //   );
  // }

  Widget _buildAttendanceBox(String label, int value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
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

  Widget _buildGraph() {
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
              FlSpot(1, absent.toDouble()),
              FlSpot(2, idle.toDouble()),
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
  // List<Color> gradientColors = [
  //   Colors.amber,
  //   Colors.amberAccent
  //   // AppColors.contentColorCyan,
  //   // AppColors.contentColorBlue,
  // ];
  //
  // bool showAvg = false;
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Stack(
  //     children: <Widget>[
  //       AspectRatio(
  //         aspectRatio: 1.70,
  //         child: Padding(
  //           padding: const EdgeInsets.only(
  //             right: 18,
  //             left: 12,
  //             top: 24,
  //             bottom: 12,
  //           ),
  //           child: LineChart(
  //             showAvg ? avgData() : mainData(),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         width: 60,
  //         height: 34,
  //         child: TextButton(
  //           onPressed: () {
  //             setState(() {
  //               showAvg = !showAvg;
  //             });
  //           },
  //           child: Text(
  //             'avg',
  //             style: TextStyle(
  //               fontSize: 12,
  //               color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget bottomTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     fontWeight: FontWeight.bold,
  //     fontSize: 16,
  //   );
  //   Widget text;
  //   switch (value.toInt()) {
  //     case 2:
  //       text = const Text('Present', style: style);
  //       break;
  //     case 5:
  //       text = const Text('Absent', style: style);
  //       break;
  //     case 8:
  //       text = const Text('idle', style: style);
  //       break;
  //     case 11:
  //       text = const Text('Total', style: style);
  //       break;
  //     default:
  //       text = const Text('', style: style);
  //       break;
  //   }
  //
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     child: text,
  //   );
  // }
  //
  // Widget leftTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     fontWeight: FontWeight.bold,
  //     fontSize: 15,
  //   );
  //   String text;
  //   switch (value.toInt()) {
  //     case 0:
  //       text = '0';
  //       break;
  //     case 1:
  //       text = '1';
  //       break;
  //     case 2:
  //       text = '2';
  //       break;
  //     case 3:
  //       text = '3';
  //       break;
  //     case 4:
  //       text = '4';
  //       break;
  //     case 5:
  //       text = '5';
  //       break;
  //     case 6:
  //       text = '6';
  //       break;
  //     default:
  //       return Container();
  //   }
  //
  //   return Text(text, style: style, textAlign: TextAlign.left);
  // }
  //
  // LineChartData mainData() {
  //   return LineChartData(
  //     gridData: FlGridData(
  //       show: true,
  //       drawVerticalLine: true,
  //       horizontalInterval: 1,
  //       verticalInterval: 1,
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       rightTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       topTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 30,
  //           interval: 1,
  //           getTitlesWidget: bottomTitleWidgets,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           interval: 1,
  //           getTitlesWidget: leftTitleWidgets,
  //           reservedSize: 42,
  //         ),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: true,
  //       border: Border.all(color: const Color(0xff37434d)),
  //     ),
  //     minX: 0,
  //     maxX: 11,
  //     minY: 0,
  //     maxY: 6,
  //     lineBarsData: [
  //       LineChartBarData(
  //         spots: const [
  //           FlSpot(0, 3),
  //           FlSpot(2.6, 2),
  //           FlSpot(4.9, 5),
  //           FlSpot(6.8, 3.1),
  //           FlSpot(8, 4),
  //           FlSpot(9.5, 3),
  //           FlSpot(11, 4),
  //         ],
  //         isCurved: true,
  //         gradient: LinearGradient(
  //           colors: gradientColors,
  //         ),
  //         barWidth: 5,
  //         isStrokeCapRound: true,
  //         dotData: const FlDotData(
  //           show: false,
  //         ),
  //         belowBarData: BarAreaData(
  //           show: true,
  //           gradient: LinearGradient(
  //             colors: gradientColors
  //                 .map((color) => color.withOpacity(0.3))
  //                 .toList(),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // LineChartData avgData() {
  //   return LineChartData(
  //     lineTouchData: const LineTouchData(enabled: false),
  //     gridData: FlGridData(
  //       show: true,
  //       drawHorizontalLine: true,
  //       verticalInterval: 1,
  //       horizontalInterval: 1,
  //       getDrawingVerticalLine: (value) {
  //         return const FlLine(
  //           color: Color(0xff37434d),
  //           strokeWidth: 1,
  //         );
  //       },
  //       getDrawingHorizontalLine: (value) {
  //         return const FlLine(
  //           color: Color(0xff37434d),
  //           strokeWidth: 1,
  //         );
  //       },
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 30,
  //           getTitlesWidget: bottomTitleWidgets,
  //           interval: 1,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: leftTitleWidgets,
  //           reservedSize: 42,
  //           interval: 1,
  //         ),
  //       ),
  //       topTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       rightTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: true,
  //       border: Border.all(color: const Color(0xff37434d)),
  //     ),
  //     minX: 0,
  //     maxX: 11,
  //     minY: 0,
  //     maxY: 6,
  //     lineBarsData: [
  //       LineChartBarData(
  //         spots: const [
  //           FlSpot(0, 3.44),
  //           FlSpot(2.6, 3.44),
  //           FlSpot(4.9, 3.44),
  //           FlSpot(6.8, 3.44),
  //           FlSpot(8, 3.44),
  //           FlSpot(9.5, 3.44),
  //           FlSpot(11, 3.44),
  //         ],
  //         isCurved: true,
  //         gradient: LinearGradient(
  //           colors: [
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //           ],
  //         ),
  //         barWidth: 5,
  //         isStrokeCapRound: true,
  //         dotData: const FlDotData(
  //           show: false,
  //         ),
  //         belowBarData: BarAreaData(
  //           show: true,
  //           gradient: LinearGradient(
  //             colors: [
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
//   List<PieChartSectionData> showingSections() {
//     return List.generate(4, (i) {
//       final isTouched = i == controller.touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
//       switch (i) {
//         case 0:
//           return PieChartSectionData(
//             color: Colors.blue,
//             value: 40,
//             title: '40%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               shadows: shadows,
//             ),
//           );
//         case 1:
//           return PieChartSectionData(
//             color: Colors.yellow,
//             value: 30,
//             title: '30%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               shadows: shadows,
//             ),
//           );
//         case 2:
//           return PieChartSectionData(
//             color: Colors.purple,
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               shadows: shadows,
//             ),
//           );
//         case 3:
//           return PieChartSectionData(
//             color: Colors.green,
//             value: 15,
//             title: '15%',
//             radius: radius,
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               shadows: shadows,
//             ),
//           );
//         default:
//           throw Error();
//       }
//     });
//   }
// }
//
// class LabelWidget extends StatelessWidget {
//   final Color color;
//   final String label;
//
//   const LabelWidget({
//     Key? key,
//     required this.color,
//     required this.label,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 16,
//           height: 16,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: color,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }