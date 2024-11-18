import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';
import 'package:tms_sathi/constans/string_const.dart';

import '../../../../constans/color_constants.dart';
import '../../../../main.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../controllers/technician_dashboard_homepage_controller.dart';

class TechnicianDashboardHomepage extends GetView<TechnicianDashboardHomepageController> {
  const TechnicianDashboardHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<TechnicianDashboardHomepageController>(
        init: TechnicianDashboardHomepageController(),
        builder: (controller) => Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.hitGetTechnicianApiCall();
            },
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                _header(controller),
                vGap(20),
                _mainDataGridView(context, controller),
                vGap(20),
                _techniciansList(controller),
                vGap(20),
                _ticketDistributionChart(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(TechnicianDashboardHomepageController controller) {
    final userrole = storage.read(userRole);
    String getRoleHeader(String role) {
      switch (role) {
        case "technician":
          return "Technician";
        case "sales":
          return "Sales";
        default:
          return "";
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${getRoleHeader(userrole)} Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Obx(() => Text(
              '${controller.allTechnicians.length} Technicians Active',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            )),
          ],
        ),
      ],
    );
  }

  Widget _mainDataGridView(BuildContext context, TechnicianDashboardHomepageController controller) {
    return Obx(() {
      final dashboardItems = controller.getDashboardItems();
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.5,
        ),
        itemCount: dashboardItems.length,
        itemBuilder: (BuildContext context, int index) {
          final item = dashboardItems[index];
          return _buildGridItem(
            title: item['title'],
            value: item['value'],
            icon: _getIconData(item['icon']),
            color: _getColor(item['color']),
          );
        },
      );
    });
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'task_alt':
        return Icons.task_alt;
      case 'check_circle':
        return Icons.check_circle;
      case 'pending_actions':
        return Icons.pending_actions;
      case 'security':
        return Icons.security;
      case 'warning_amber':
        return Icons.warning_amber;
      case 'trending_up':
        return Icons.trending_up;
      default:
        return Icons.error;
    }
  }

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'Colors.blue':
        return Colors.blue;
      case 'Colors.green':
        return Colors.green;
      case 'Colors.orange':
        return Colors.orange;
      case 'Colors.purple':
        return Colors.purple;
      case 'Colors.red':
        return Colors.red;
      case 'Colors.teal':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  Widget _buildGridItem({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // Handle item tap
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _techniciansList(TechnicianDashboardHomepageController controller) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Active Users',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.filteredTechnicians.length,
            itemBuilder: (context, index) {
              final technician = controller.filteredTechnicians[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: appColor,
                  backgroundImage: NetworkImage(technician.profileImage) ,
                  // child: Text(
                  //   technician.firstName[0].toUpperCase(),
                  //   style: TextStyle(color: whiteColor),
                  // ),
                ),
                title: Text('${technician.firstName} ${technician.lastName}'),
                subtitle: Text(technician.email),
                trailing: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: technician.isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    technician.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: technician.isActive ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }

  Widget _ticketDistributionChart(BuildContext context, TechnicianDashboardHomepageController controller) {
    return Obx(() {
      final stats = controller.dashboardStats;
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Ticket Distribution',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: stats.totalTickets.toDouble(),
                            title: 'Total',
                            radius: 50,
                            titleStyle: TextStyle(color: whiteColor, fontSize: 12),
                          ),
                          PieChartSectionData(
                            color: Colors.orange,
                            value: stats.completedTickets.toDouble(),
                            title: 'Completed',
                            radius: 50,
                            titleStyle: TextStyle(color: whiteColor, fontSize: 12),
                          ),
                          PieChartSectionData(
                            color: Colors.green,
                            value: stats.onHoldTickets.toDouble(),
                            title: 'On-Hold',
                            radius: 50,
                            titleStyle: TextStyle(color: whiteColor, fontSize: 12),
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: stats.rejectedTickets.toDouble(),
                            title: 'Rejected',
                            radius: 50,
                            titleStyle: TextStyle(color: whiteColor, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _legendItem('Total (${stats.totalTickets})', Colors.blue),
                        SizedBox(height: 8),
                        _legendItem('Completed (${stats.completedTickets})', Colors.orange),
                        SizedBox(height: 8),
                        _legendItem('On-Hold (${stats.onHoldTickets})', Colors.green),
                        SizedBox(height: 8),
                        _legendItem('Rejected (${stats.rejectedTickets})', Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}