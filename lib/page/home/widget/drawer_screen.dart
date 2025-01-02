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
  final userrole = storage.read(userRole);
  bool isExpanded = false;
  final Map<String, bool> _expandedMenus = {
    'Attendance': false,
    'Ticket': false,
    'Field Team': false,
    'CRM': false,
  };

  List<Map<String, dynamic>> getMenuItems() {
    final currentRole = widget.userrole;
    return [
      {
        'icon': Icons.dashboard,
        'title': "Dashboard",
        'onTap': () => Get.back(),
        'roles': ['admin', 'technician', 'superuser', 'agent', 'sales'],
      },
      {
        "icon": Icons.token,
        "title": "Ticket",
        "hasSubmenu": true,
        'submenuItems': [
          {
            'icon': Icons.token,
            'title': "Ticket",
            'onTap': () async {
              Get.toNamed(AppRoutes.ticketListScreen);
            },
            'roles': ['admin', 'technician', 'superuser', 'agent', 'sales'],
          },

          {
            'title': "FSR",
            'onTap': () async {
              Get.toNamed(AppRoutes.fsrScreen);
            },
            'roles': ['admin', 'superuser', 'agent'],
          },
        ],
        "roles": ['admin', 'technician', 'superuser', 'agent', 'sales'], // Added roles for main menu item
      },
      {
        'icon': FeatherIcons.calendar,
        'title': "Attendance",
        'hasSubmenu': true,
        'submenuItems': [
          {
            'title': "Attendance",
            'onTap': () async {
              // if (currentRole == 'technician' || currentRole == 'sales' || currentRole == agentRole) {
              //   Get.toNamed(AppRoutes.forTechnicianAndSalesAttendace);
              // } else {
              //   Get.toNamed(AppRoutes.attendanceScreen);
              // }
              (currentRole == adminRole || currentRole == agentRole)?
              Get.toNamed(AppRoutes.attendanceScreen):
              Get.toNamed(AppRoutes.forTechnicianAndSalesAttendace);
              print("current Role= ${currentRole}");

            },
            'roles': ['admin', 'technician', 'superuser', 'agent', 'sales'],
          },
          {
            'title': "Leaves",
            'onTap': () async {
              Get.toNamed(AppRoutes.leaveReportScreen);
            },
            'roles': ['admin', 'technician', 'superuser', 'agent', 'sales'],
          },
          {
            'title': "Calendar",
            'onTap': () async {
              customLoader.show();
              await Future.delayed(Duration(seconds: 1));
              Get.toNamed(AppRoutes.calendarScreen);
              customLoader.hide();
            },
            'roles': ['admin', 'technician', 'superuser', 'agent', 'sales'],
          },
        ],
        'roles': ['admin', 'technician', 'superuser', 'agent', 'sales'],
      },
      if( userrole != technicianRole && userrole != salesRole)
      {
        'icon': Icons.groups_outlined,
        "title": "Field Team",
        'hasSubmenu': true,
        'submenuItems': [
          {
            'title': "Technician",
            'onTap': () async {
              customLoader.show();
              await Future.delayed(Duration(seconds: 1));
              await Get.toNamed(AppRoutes.technicianListsScreen);
              customLoader.hide();
            },
            'roles': ['admin', 'superuser', 'agent'],
          },
          {
            'title': "Sales",
            'onTap': () async {
              customLoader.show();
              await Future.delayed(Duration(seconds: 1));
              Get.toNamed(AppRoutes.salesListScreen);
              customLoader.hide();
            },
            'roles': ['admin', 'superuser', 'agent'],
          },
          {
            'title': "Expenditure",
            'onTap': () async {
              Get.toNamed(AppRoutes.expenditureScreen);
            },
            'roles': ['admin', 'superuser', 'agent'],
          },
          {
            'title': "Material Request",
            'onTap': () async {
              Get.toNamed(AppRoutes.serviceReqScreen);
            },
            'roles': ['admin', 'superuser', 'agent'],
          },
          {
            'title': "Track All",
            'onTap': () async {
              customLoader.show();
              await Future.delayed(Duration(seconds: 1));
              await Get.toNamed(AppRoutes.mapView);
              customLoader.hide();
            },
            'roles': ['admin', 'superuser', 'agent'],
          },
        ],
        "roles": ['admin', 'technician', 'superuser', 'agent', 'sales'], // Added roles for main menu
      },
      if( userrole != technicianRole && userrole != salesRole)
      {
        "icon": Icons.group,
        "title": "CRM",
        "hasSubmenu": true,
        'submenuItems': [
          {
            'title': "Customer",
            'onTap': () async {
              Get.toNamed(AppRoutes.customerListScreen);
            },
            'roles': ['admin', 'superuser', 'agent'],
          },
          {
            'title': "Lead",
            'onTap': () async {
              Get.toNamed(AppRoutes.leadListScreen);
            },
            'roles': ['admin', 'superuser', 'agent'],
          },
        ],
        "roles": ['admin', 'superuser', 'agent'], // Added roles for main menu
      },
      {
        'title': "Expenditure",
        'onTap': () async {
          Get.toNamed(AppRoutes.expenditureScreen);
        },
      'roles': ['technician', 'sales'],
      },
      {
        'title': "Material Request",
        'onTap': () async {
          Get.toNamed(AppRoutes.serviceReqScreen);
        },
        'roles': ['technician', 'sales'],
      },
      {
        'icon': Icons.person_search,
        'title': "Executive",
        'onTap': () async {
          Get.toNamed(AppRoutes.agentsScreen);
        },
        'roles': ['admin', 'superuser'],
      },
      {
        'icon': Icons.people_alt_sharp,
        'title': "Manager",
        'onTap': () async {
          Get.toNamed(AppRoutes.SuperAgentsScreen);
        },
        'roles': ['admin'],
      },
      {
        'icon': Icons.shopping_bag,
        'title': "AMC",
        'onTap': () async {
          Get.toNamed(AppRoutes.amcScreen);
        },
        'roles': ['admin', 'superuser', 'agent'],
      },
      {
        'icon': Icons.search_rounded,
        'title': "Service",
        'onTap': () async {
          Get.toNamed(AppRoutes.serviceCategoriesScreen);
        },
        'roles': ['admin', 'superuser', 'agent'],
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
          ...menuItems.where((item) {
            final roles = List<String>.from(item['roles'] ?? []);
            return roles.isEmpty || roles.contains(currentRole);
          }).map(
                (item) => Column(
              children: [
                if (item['hasSubmenu'] == true)
                  buildExpandableMenuItem(item)
                else
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

  Widget buildExpandableMenuItem(Map<String, dynamic> item) {
    _expandedMenus.putIfAbsent(item['title'], () => false);

    return Column(
      children: [
        menuTile(
          icon: item['icon'],
          title: item['title'],
          onTap: () {
            setState(() {
              _expandedMenus[item['title']] = !(_expandedMenus[item['title']]!);
            });
          },
          trailing: Icon(
            _expandedMenus[item['title']]!
                ?Icons.keyboard_arrow_down_outlined
                :Icons.keyboard_arrow_right_rounded,
            size: 24,
            color: Colors.black54,
          ),
        ),
        vGap(10),
        if (_expandedMenus[item['title']]!)
          ...List<Widget>.from(
            (item['submenuItems'] as List).where((subItem) {
              final roles = List<String>.from(subItem['roles'] ?? []);
              return roles.isEmpty || roles.contains(widget.userrole);
            }).map(
                  (subItem) => Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Column(
                  children: [
                    menuTile(
                      title: subItem['title'],
                      onTap: subItem['onTap'],
                    ),
                    divider(),
                  ],
                ),
              ),
            ),
          ),

      ],
    );
  }

  Widget menuTile({
    IconData? icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
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
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            trailing ??
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