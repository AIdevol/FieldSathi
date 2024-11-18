// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:tms_sathi/constans/color_constants.dart';
// import 'package:tms_sathi/constans/role_based_keys.dart';
// import 'package:tms_sathi/constans/string_const.dart';
// import 'package:tms_sathi/main.dart';
// import 'package:tms_sathi/navigations/navigation.dart';
// import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
//
// import '../../../utilities/helper_widget.dart';
//
// class DrawerScreen extends StatefulWidget{
//   final formGlobalKey = GlobalKey<FormState>();
//   final GlobalKey<ScaffoldState> dkey;
//   final userrole = storage.read(userRole);
//   DrawerScreen({
//     Key? key,
//     required this.dkey,
//   }) : super(key: key);
//   @override
//   _DrawerScreenState createState() => _DrawerScreenState();
// }
//
// class _DrawerScreenState extends State<DrawerScreen>{
//   bool isExpanded = false;
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: appColor,
//       child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         vGap(20),
//         Padding(
//           padding:const EdgeInsets.only(top: 30.0),
//           child: AnimatedContainer(
//             color: appColor,
//             duration: const Duration(milliseconds: 200),
//             // padding: const EdgeInsets.symmetric(vertical: 10),
//             height: isExpanded ? MediaQuery.of(context).size.height * 0.36 : 150,
//             child: SizedBox(height: Get.height,width:Get.width,child: Image.asset(appIcon, fit: BoxFit.cover,) ,)
//           ),
//         ),
//         divider(),
//         menuTile(
//           icon: Icons.dashboard,
//           title: "Dashboard",
//           onTap: () {
//             Get.back();
//           },
//         ),
//         // divider(),
//         // menuTile(
//         // icon: Icons.price_change_rounded,
//         //   title: "Pricing Plans",
//         //   onTap: () async {
//         //     Get.toNamed(AppRoutes.pricingScreenView);
//         //   },
//         // ),
//         divider(),
//         menuTile(
//           icon: Icons.calendar_month,
//           title: "calender",
//           onTap: () async {
//             customLoader.show();
//             await Future.delayed(Duration(seconds: 1));
//             Get.toNamed(AppRoutes.calendarScreen);
//             customLoader.hide();
//           },
//         ),
//         divider(),
//         menuTile(
//           icon: FeatherIcons.grid,
//           title: "Leaves",
//           onTap: () async {
//             Get.toNamed(AppRoutes.leaveReportScreen);
//           },
//         ),
//         divider(),
//         menuTile(
//           icon: Icons.token,
//           title: "Ticket",
//           onTap: () async {
//             customLoader.show();
//             await Future.delayed(Duration(seconds: 1));
//             Get.toNamed(AppRoutes.ticketListScreen);
//             customLoader.hide();
//           },
//         ),
//         divider(),
//         menuTile(
//           icon: FeatherIcons.grid,
//           title: "FSR",
//           onTap: () async {
//             Get.toNamed(AppRoutes.fsrScreen);
//           },
//         ),
//         divider(),
//         menuTile(
//           icon: Icons.amp_stories,
//           title: "AMC",
//           onTap: () async {
//             Get.toNamed(AppRoutes.amcScreen);
//           },
//         ),
//         divider(),
//         menuTile(
//           icon: Icons.person_search,
//           title: "Agents",
//           onTap: () async {
//             Get.toNamed(AppRoutes.agentsScreen);
//           },
//         ),
//         divider(),
//         // menuTile(
//         //   icon: Icons.person_pin,
//         //   title: "Super User",
//         //   onTap: () async {
//         //   },
//         // ),
//         // divider(),
//         // menuTile(
//         //   icon: Icons.person_pin_circle_sharp,
//         //   title: "Services",
//         //   onTap: () async {
//         //   },
//         // )
//       ],),);
//   }
//   Widget menuTile({ Widget? iconWidget, IconData? icon, required String title, required VoidCallback onTap,}) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(icon as IconData?, color: darkBlue),
//                 hGap(30),
//                 Text(title, style: MontserratStyles.montserratBoldTextStyle(color: Colors.black87)),
//               ],
//             ),
//             Icon(Icons.arrow_forward_ios_outlined, size: 14, color: Colors.black54),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import '../../../utilities/helper_widget.dart';

class DrawerScreen extends StatefulWidget {
  final formGlobalKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> dkey;
  final userrole = storage.read(userRole);

  DrawerScreen({
    Key? key,
    required this.dkey,
  }) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isExpanded = false;

  // Define menu items with their roles
  List<Map<String, dynamic>> getMenuItems() {
    final currentRole = widget.userrole;
    return [
      {
        'icon': Icons.dashboard,
        'title': "Dashboard",
        'onTap': () => Get.back(),
        'roles': ['admin', 'technician','superuser', 'agent','sales'], // visible to all roles
      },
      {
        'icon': Icons.calendar_month,
        'title': "Calendar",
        'onTap': () async {
          customLoader.show();
          await Future.delayed(Duration(seconds: 1));
          Get.toNamed(AppRoutes.calendarScreen);
          customLoader.hide();
        },
        'roles': ['admin', 'technician','superuser', 'agent','sales'],
      },
      {
        'icon': FeatherIcons.calendar,
        'title': "Attendance",
        'onTap': () async {
          if(currentRole == 'technician'||currentRole=='sales'){
            Get.toNamed(AppRoutes.forTechnicianAndSalesAttendace);
          }else{
            Get.toNamed(AppRoutes.attendanceScreen);
          }
        },
        'roles': ['admin', 'technician','superuser', 'agent', 'sales'],
      },
      {
        'icon': FeatherIcons.grid,
        'title': "Leaves",
        'onTap': () async {
          Get.toNamed(AppRoutes.leaveReportScreen);
        },
        'roles': ['admin', 'technician','superuser', 'agent','sales'],
      },
      {
        'icon': Icons.token,
        'title': "Ticket",
        'onTap': () async {
          customLoader.show();
          await Future.delayed(Duration(seconds: 1));
          Get.toNamed(AppRoutes.ticketListScreen);
          customLoader.hide();
        },
        'roles': ['admin', 'technician','superuser', 'agent','sales'],
      },
      {
        'icon': FeatherIcons.grid,
        'title': "FSR",
        'onTap': () async {
          Get.toNamed(AppRoutes.fsrScreen);
        },
        'roles': ['admin','superuser', 'agent'],  // only visible to admin
      },

      {
        'icon': Icons.person_search,
        'title': "Executive",
        'onTap': () async {
          Get.toNamed(AppRoutes.agentsScreen);
        },
        'roles': ['admin','superuser', 'agent'],  // only visible to admin
      },
      {
        'icon': Icons.amp_stories,
        'title': "AMC",
        'onTap': () async {
          Get.toNamed(AppRoutes.amcScreen);
        },
        'roles': ['admin','superuser', 'agent'],  // only visible to admin
      },
      {
        'icon': Icons.price_change_rounded,
        'title': "Expenditure",
        'onTap': () async {
          Get.toNamed(AppRoutes.expenditureScreen);
        },
        'roles': ['technician', 'sales'],
      },
      {
        'icon': Icons.request_page_sharp,
        'title': "Material Request",
        'onTap': () async {
          Get.toNamed(AppRoutes.serviceReqScreen);
        },
        'roles': ['technician', 'sales'],
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentRole = widget.userrole;
    final menuItems = getMenuItems();

    return Drawer(
      backgroundColor: appColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          vGap(20),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: AnimatedContainer(
              color: appColor,
              duration: const Duration(milliseconds: 200),
              height: isExpanded ? MediaQuery.of(context).size.height * 0.36 : 150,
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Image.asset(appIcon, fit: BoxFit.cover),
              ),
            ),
          ),
          divider(),
          ...menuItems.where((item) => item['roles'].contains(currentRole)).map(
                (item) => Column(
              children: [
                menuTile(
                  icon: item['icon'],
                  title: item['title'],
                  onTap: item['onTap'],
                ),
                divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuTile({
    IconData? icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, color: darkBlue),
                hGap(30),
                Text(
                  title,
                  style: MontserratStyles.montserratBoldTextStyle(
                      color: Colors.black87
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 14,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}