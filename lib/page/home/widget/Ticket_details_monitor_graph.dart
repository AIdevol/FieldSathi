// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:get/get.dart';
// import 'package:tms_sathi/page/home/presentations/controllers/graph_view_controller.dart';
//
// class GraphViewScreen extends GetView<GraphViewController> {
//   const GraphViewScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Labels above the chart
//         Padding(
//           padding: const EdgeInsets.all(0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: const [
//               LabelWidget(color: Colors.blue, label: 'First'),
//               LabelWidget(color: Colors.yellow, label: 'Second'),
//               LabelWidget(color: Colors.purple, label: 'Third'),
//               LabelWidget(color: Colors.green, label: 'Fourth'),
//             ],
//           ),
//         ),
//         // Pie chart
//         AspectRatio(
//           aspectRatio: 1.3,
//           child: PieChart(
//             PieChartData(
//               pieTouchData: PieTouchData(
//                 touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                   if (!event.isInterestedForInteractions ||
//                       pieTouchResponse == null ||
//                       pieTouchResponse.touchedSection == null) {
//                     controller.setTouchedIndex(-1);
//                     return;
//                   }
//                   controller.setTouchedIndex(
//                       pieTouchResponse.touchedSection!.touchedSectionIndex);
//                 },
//               ),
//               borderData: FlBorderData(show: false),
//               sectionsSpace: 0,
//               centerSpaceRadius: 40,
//               sections: showingSections(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
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
//         const SizedBox(width: 4),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/home/presentations/controllers/graph_view_controller.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class GraphViewScreen extends GetView<GraphViewController> {
  const GraphViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Pie chart on the right
        Expanded(
          flex: 3,
          child: AspectRatio(
            aspectRatio: 1,
            child: Obx(() => PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      controller.setTouchedIndex(-1);
                      return;
                    }
                    controller.setTouchedIndex(
                        pieTouchResponse.touchedSection!.touchedSectionIndex);
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            )),
          ),
        ),
        hGap(20),
        // Labels on the left
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LabelWidget(color: Colors.blue, label: 'Completed'),
                SizedBox(height: 16),
                LabelWidget(color: Colors.yellow, label: 'Ongoing'),
                SizedBox(height: 16),
                LabelWidget(color: Colors.purple, label: 'Inactive'),
                SizedBox(height: 16),
                LabelWidget(color: Colors.green, label: 'Onhold'),
                SizedBox(height: 16),
                LabelWidget(color: Colors.red, label: 'Rejected'),
              ],
            ),
          ),
        ),

      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == controller.touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.red,
            value: 15,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class LabelWidget extends StatelessWidget {
  final Color color;
  final String label;

  const LabelWidget({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}