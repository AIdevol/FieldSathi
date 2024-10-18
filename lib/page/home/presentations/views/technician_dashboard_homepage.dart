import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/home/presentations/controllers/technician_dashboard_homepage_controller.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../main.dart';
import '../../../../navigations/navigation.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../widget/drawer_screen.dart';

class TechnicianDashboardHomepage extends GetView<TechnicianDashboardHomepageController>{
   TechnicianDashboardHomepage({super.key});

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<TechnicianDashboardHomepageController>(
      init: TechnicianDashboardHomepageController(),
        builder: (controller)=>
    Scaffold(
      extendBodyBehindAppBar: true,
      key: drawerKey,
      resizeToAvoidBottomInset: true,
      drawer: DrawerScreen(
        dkey: drawerKey,
      ),
      appBar: AppBar(
          backgroundColor: appColor,
          title: Text("TMS_Sathi",style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15)),
          leading: IconButton(
            icon: Icon(FeatherIcons.menu),
            onPressed: () {
              drawerKey.currentState?.openDrawer();
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
                  // backgroundImage: _getBackgroundImage(controller.profileImageUrl.value),
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
                    // _loginShowPopUpView(controller, context);
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
      body: _mainScreen(context, controller),
    )));
  }
}
_mainScreen(BuildContext context, TechnicianDashboardHomepageController controller){
  ListView(children: [
    _mainDataGridView(context, controller)
  ],);
}
_mainDataGridView(BuildContext context,TechnicianDashboardHomepageController controller){
    return GridView.builder(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.amber,
            child: Center(child: Text('$index')),
          );
        });
}