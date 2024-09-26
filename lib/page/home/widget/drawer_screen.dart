import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';

import '../../../utilities/helper_widget.dart';

class DrawerScreen extends StatefulWidget{
  final formGlobalKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> dkey;

  DrawerScreen({
    Key? key,
    required this.dkey,
  }) : super(key: key);
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>{
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appColor,
      child: ListView(
      padding: EdgeInsets.zero,
      children: [
        vGap(20),
        Padding(
          padding:const EdgeInsets.only(top: 30.0),
          child: AnimatedContainer(
            color: appColor,
            duration: const Duration(milliseconds: 200),
            // padding: const EdgeInsets.symmetric(vertical: 10),
            height: isExpanded ? MediaQuery.of(context).size.height * 0.36 : 150,
            child: SizedBox(height: Get.height,width:Get.width,child: Image.asset(appIcon, fit: BoxFit.cover,) ,)
          ),
        ),
        divider(),
        menuTile(
          icon: Icons.dashboard,
          title: "Dashboard",
          onTap: () {
            Get.back();
          },
        ),
        divider(),
        menuTile(
          icon: Icons.calendar_month,
          title: "calender",
          onTap: () async {
            customLoader.show();
            await Future.delayed(Duration(seconds: 1));
            Get.toNamed(AppRoutes.calendarScreen);
            customLoader.hide();
          },
        ),
        divider(),
        menuTile(
          icon: FeatherIcons.grid,
          title: "Leaves",
          onTap: () async {
            Get.back();
            Get.toNamed(AppRoutes.leaveReportScreen);
          },
        ),
        divider(),
        menuTile(
          icon: Icons.token,
          title: "Ticket",
          onTap: () async {
            customLoader.show();
            await Future.delayed(Duration(seconds: 1));
            Get.toNamed(AppRoutes.ticketListScreen);
            customLoader.hide();
          },
        ),
        divider(),
        menuTile(
          icon: FeatherIcons.grid,
          title: "FSR",
          onTap: () async {
            Get.toNamed(AppRoutes.fsrScreen);
          },
        ),
        divider(),
        menuTile(
          icon: Icons.amp_stories,
          title: "AMC",
          onTap: () async {
            Get.toNamed(AppRoutes.amcScreen);
          },
        ),
        divider(),
        menuTile(
          icon: Icons.person_search,
          title: "Agents",
          onTap: () async {
            Get.toNamed(AppRoutes.agentsScreen);
          },
        ),
        divider(),
        // menuTile(
        //   icon: Icons.person_pin,
        //   title: "Super User",
        //   onTap: () async {
        //   },
        // ),
        // divider(),
        // menuTile(
        //   icon: Icons.person_pin_circle_sharp,
        //   title: "Services",
        //   onTap: () async {
        //   },
        // )
      ],),);
  }
  Widget menuTile({required IconData icon, required String title, required VoidCallback onTap}) {
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
                Icon(icon as IconData?, color: darkBlue),
                hGap(30),
                Text(title, style: MontserratStyles.montserratBoldTextStyle(color: Colors.black87)),
              ],
            ),
            Icon(Icons.arrow_forward_ios_outlined, size: 14, color: Colors.black54),
          ],
        ),
      ),
    );
  }

}