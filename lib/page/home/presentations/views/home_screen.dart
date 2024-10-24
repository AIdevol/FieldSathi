import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/profile_screen_controller.dart';
import 'package:tms_sathi/page/home/presentations/controllers/home_screen_controller.dart';
import 'package:tms_sathi/page/home/presentations/views/agent_dashboard_homepage.dart';
import 'package:tms_sathi/page/home/presentations/views/super_user_dashBoard_homePage.dart';
import 'package:tms_sathi/page/home/presentations/views/technician_dashboard_homepage.dart';
import 'package:tms_sathi/page/home/widget/amc_status_monitor_graph.dart';
import 'package:tms_sathi/page/home/widget/drawer_screen.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../main.dart';
import '../../../../main.dart';
import '../../../../utilities/custom_loader.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../widget/attendence_details_monitor_graph.dart';
import '../../widget/bottom_sheets.dart';
import '../../widget/Ticket_details_monitor_graph.dart';

class HomeScreen extends GetView<HomeScreenController> {
  final GlobalKey<ScaffoldState> drawerkey = GlobalKey();
  // final profileimg = Get.put(ProfileViewScreenController()).profileImageUrl.value;
  final userrole = storage.read(userRole);
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isDialOpen = false;
  HomeScreen({super.key}){
    // _controller = AnimationController(
    //   // vsync: this._controller,
    //   duration: const Duration(milliseconds: 500),
    // );
    //
    // _slideAnimation = Tween<Offset>(
    //   begin: const Offset(0.0, -1.0),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeInOut,
    // ));
  }


  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) => Scaffold(
          floatingActionButton: _buildSpeedDial(context: context),
          extendBodyBehindAppBar: true,
          key: drawerkey,
          resizeToAvoidBottomInset: true,
          drawer: DrawerScreen(
            dkey: drawerkey,
          ),
          appBar: AppBar(
            backgroundColor: appColor,
            title: Text("TMS_Sathi",style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15)),
            leading: IconButton(
              icon: Icon(FeatherIcons.menu),
              onPressed: () {
                drawerkey.currentState?.openDrawer();
              },
            ),
            actions: [
              IconButton(onPressed: ()async{
                customLoader.show();
                await Future.delayed(Duration(seconds: 2));
                Get.toNamed(AppRoutes.notificationsScreen);
                customLoader.hide();
              }, icon: Icon(Icons.notifications_sharp,size: 25,)),
              PopupMenuButton<String>(
                color: appColor,
                offset: Offset(0, 56),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: _getBackgroundImage(controller.profileImageUrl.value),
                  ),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'profile',
                    onTap: (){
                      Get.toNamed(AppRoutes.editProfile);
                    },
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Profile'),
                    ),
                  ),
                   PopupMenuItem<String>(
                    onTap: () => Get.toNamed(AppRoutes.accountViewScreen),
                    value: 'Account',
                    child: ListTile(
                      leading: Icon(Icons.account_balance),
                      title: Text('Account'),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'logout',
                    onTap: ()async{
                      _loginShowPopUpView(controller, context);
                      // final controller = Get.put(ProfileViewScreenController());
                      // controller.logout();
                    },
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Logout'),
                    ),
                  ),
                ],
                onSelected: (String value) {
                  // Handle menu item selection
                  switch (value) {
                    case 'profile':
                    // Navigate to profile page
                      break;
                    case 'logout':
                    // Perform logout action
                      break;
                  }
                },
              ),
              hGap(10)
            ],
          ),
          body: _getRoleBasedHomePage(context, userrole)
        ),
      ),
    );
  }
  Widget _getRoleBasedHomePage(BuildContext context, String userRole) {
    switch (userRole) {
      case adminRole:
        return _buildWidgetView(context);  // This should call the admin view builder
      case superUserRole:
        return SuperUserDashboardHomepage();  // This should be your superuser page
      case agentRole:
        return AgentDashboardHomepage();
      case technicianRole:
        return TechnicianDashboardHomepage();  // This should be the technician's homepage
      default:
        return Center(child: Text("Unauthorized access or no role found"));
    }
  }

  _buildWidgetView(BuildContext context){
    return
      Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          vGap(40),
          _graphVisualScreen1(context, text: 'Ticket Details'),
          vGap(40),
          _graphVisualScreen2(context, text:"Today's Attendance"),
          vGap(40),
          _graphVisualScreen3(context, text: "AMC Status"),
          vGap(40),
        ],
      ),
    );
  }
  SpeedDial _buildSpeedDial( {required BuildContext context}) {
    return SpeedDial(
      icon: _isDialOpen ? Icons.close : Icons.add,
      activeIcon: Icons.close,
      visible: true,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      // onOpen: () => setState(() => _isDialOpen = true),
      // onClose: () => setState(() => _isDialOpen = false),
      backgroundColor: appColor,
      foregroundColor: Colors.black,
      elevation: 8.0,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.add_home_work),
          backgroundColor: appColor,
          label: 'Field Worker',
          onTap: () => AppBottomSheets.show(context: context, title: 'Field Worker', actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: Text('Technician List'),
              onPressed: ()async {
               customLoader.show();
               await Future.delayed(Duration(seconds: 1));
               Get.toNamed(AppRoutes.technicianListsScreen);
               customLoader.hide();
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Attendance'),
              onPressed: () {
                // Handle option 2
                Get.toNamed(AppRoutes.attendanceScreen);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Expenditure'),
              onPressed: () {
                // Handle option 2
                Get.toNamed(AppRoutes.expenditureScreen);
              },
            ),CupertinoActionSheetAction(
              child: Text('Service Requests'),
              onPressed: () {
                // Handle option 2
                Get.toNamed(AppRoutes.serviceReqScreen);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Track All'),
              onPressed: () async{
                customLoader.show();
                await Future.delayed(Duration(seconds: 2));
                Get.toNamed(AppRoutes.mapView);
                customLoader.hide();
              },
            ),
          ],)
        ),
        SpeedDialChild(
          child: const Icon(Icons.person_pin),
          backgroundColor: appColor,
          label: 'Super user',
          onTap: () => Get.toNamed(AppRoutes.SuperAgentsScreen),
        ),
        SpeedDialChild(
          child: const Icon(Icons.person_pin_circle_sharp),
          backgroundColor: appColor,
          label: 'Services',
          onTap: () =>Get.toNamed(AppRoutes.serviceCategoriesScreen),
        ),
        SpeedDialChild(
          child: const Icon(Icons.list),
          backgroundColor: appColor,
          label: 'CRM',
          onTap: () =>
          AppBottomSheets.show(context: context, title: 'Customer List',
            actions: <CupertinoActionSheetAction>[
                      CupertinoActionSheetAction(
                        child: Text('Customer List'),
                        onPressed: () {
                        Get.toNamed(AppRoutes.customerListScreen);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: Text('Lead List'),
                        onPressed: () {
                          // Handle option 2
                          Get.toNamed(AppRoutes.leadListScreen);
                        },
                      ),
            ],

          )
        ),
      ],
    );
  }


  _graphVisualScreen1(BuildContext context, {required String text}){
    final containerLength = MediaQuery.of(context).size ;
    return GestureDetector(
      onTap: (){
      Get.toNamed(AppRoutes.ticketListScreen);
      },
      child: Container(
          height: containerLength.height*0.99,
          width: Get.width*0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(text, style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: blackColor),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buttonBuildContainer(onTap: (){
                      Get.toNamed(AppRoutes.ticketListCreationScreen);
                    }, text: "Create Ticket " ),
                  )
                ],
              ),
              Expanded(child: GraphViewScreen()),
            ],
          )),
    );
  }
}
_graphVisualScreen2(BuildContext context, {required String text}){
  final containerLength = MediaQuery.of(context).size ;
  return GestureDetector(
    onTap: (){
      Get.toNamed(AppRoutes.technicianListsScreen);
      print("buttton tapped");
    },
    child: Container(
        height: containerLength.height*0.75,
        width: Get.width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(text, style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: blackColor),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buttonBuildContainer(onTap: (){
                    Get.toNamed(AppRoutes.mapView);
                  }, text: "Track All" ),
                )
              ],
            ),
            Expanded(child: AttendenceDetailsMonitorGraph()),
          ],
        )),
  );
}
_graphVisualScreen3(BuildContext context, {required String text}){
  final containerLength = MediaQuery.of(context).size * 1/2;
  return GestureDetector(
    onTap: (){
      // Get.toNamed(AppRoutes.amcScreen);
      print("buttton tapped");
    },
    child: Container(
        height: containerLength.height*0.8,
        width: Get.width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(text, style: MontserratStyles.montserratSemiBoldTextStyle(size: 13,color: blackColor),),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: _buttonBuildContainer(onTap: (){
                //     Get.toNamed(AppRoutes.amcScreen);
                //   }, text: "Manage AMCs" ),
                // )
              ],
            ),
            Expanded(child: AmcStatusMonitorGraph()),
          ],
        )),
  );
}



Widget _buttonBuildContainer({required Function()? onTap, required String text}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
    height: Get.height*0.06,
    width: Get.width*0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
    child: Center(
      child: Text(
        text,
      style: MontserratStyles.montserratSemiBoldTextStyle(size: 13), /*textAlign:TextAlign.center,*/),
    ),
  ),);
}

ImageProvider _getBackgroundImage(String? imageUrl) {
  if (imageUrl != null && imageUrl.isNotEmpty) {
    return NetworkImage(imageUrl);
  } else {
    return AssetImage(userImageIcon);
  }
}

_loginShowPopUpView(HomeScreenController controller,BuildContext context){
  final GlobalKey<State> alertKey = GlobalKey();
  final Controller = Get.put(ProfileViewScreenController());
  // controller.logout();
  return showDialog(context: context, builder: (controller)=>AlertDialog(
    key: alertKey,
    backgroundColor: CupertinoColors.white,
    title: Text('Logout', style: MontserratStyles.montserratBoldTextStyle(size: 25, color: blackColor),),
    content: Text("Are you sure want to Logout", style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: Colors.black),),
    actions: [
      ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Cancel',style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(appColor),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(strokeAlign: BorderSide.strokeAlignCenter)
            ),
          ),
          shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
        ),
      ),
      hGap(20),
      ElevatedButton(
        onPressed: () =>Controller.logout(),
        child: Text('Logout',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(appColor),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
                side: BorderSide(strokeAlign: BorderSide.strokeAlignCenter)
            ),
          ),
          shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
        ),
      )
    ],
  ));
}