import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constans/color_constants.dart';
import '../../../../navigations/navigation.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../../widget/amc_status_monitor_graph.dart';
import '../controllers/technician_dashboard_homepage_controller.dart';

class TechnicianDashboardHomepage extends StatelessWidget {
  TechnicianDashboardHomepage({super.key}) {
    Get.put(TechnicianDashboardHomepageController());
  }

  final List<DashboardItem> dashboardItems = [
    DashboardItem(title: 'Total Tasks', value: '156', icon: Icons.task_alt, color: Colors.blue),
    DashboardItem(title: 'Pending', value: '43', icon: Icons.pending_actions, color: Colors.orange),
    DashboardItem(title: 'Completed', value: '113', icon: Icons.check_circle, color: Colors.green),
    DashboardItem(title: 'AMC Active', value: '28', icon: Icons.security, color: Colors.purple),
    DashboardItem(title: 'Overdue', value: '5', icon: Icons.warning_amber, color: Colors.red),
    DashboardItem(title: 'Performance', value: '94%', icon: Icons.trending_up, color: Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TechnicianDashboardHomepageController>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh logic
          await Future.delayed(Duration(seconds: 1));
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            _header(),
            vGap(20),
            _mainDataGridView(context, controller),
            vGap(20),
            _graphSection(context),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Technician Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        IconButton(
          icon: Icon(Icons.notifications_none),
          onPressed: () {
            // Handle notifications
          },
        ),
      ],
    );
  }

  Widget _mainDataGridView(BuildContext context, TechnicianDashboardHomepageController controller) {
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
        return _buildGridItem(item);
      },
    );
  }

  Widget _buildGridItem(DashboardItem item) {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Handle item tap
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    item.icon,
                    color: item.color,
                    size: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.value,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        item.title,
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

  Widget _graphSection(BuildContext context) {
    final hieghtLength = MediaQuery.of(context).size * 1/2;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AMC Status Monitor',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(AppRoutes.amcScreen);
                  },
                  icon: Icon(Icons.manage_accounts, size: 20),
                  label: Text('Manage AMCs'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: hieghtLength.height*0.99,
              // width: Get.width*0.08,
              // padding: EdgeInsets.all(16),
              child: AmcStatusBarChart(),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  DashboardItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}