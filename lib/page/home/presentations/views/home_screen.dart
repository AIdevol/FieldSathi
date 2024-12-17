import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/home/presentations/views/technician_dashboard_homepage.dart';
import 'package:tms_sathi/response_models/today_ticket_response_model.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/string_const.dart';
import '../../../../main.dart';
import '../../../../utilities/aniammted.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../Authentications/presentations/controllers/profile_screen_controller.dart';
import '../../widget/Ticket_details_monitor_graph.dart';
import '../../widget/amc_status_monitor_graph.dart';
import '../../widget/attendence_details_monitor_graph.dart';
import '../../widget/bottom_sheets.dart';
import '../../widget/drawer_screen.dart';
import '../controllers/home_screen_controller.dart';


class HomeScreen extends GetView<HomeScreenController> {
  final GlobalKey<ScaffoldState> drawerkey = GlobalKey();
  final userrole = storage.read(userRole);
  bool _isDialOpen = false;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) => Scaffold(
          floatingActionButton: userrole != technicianRole && userrole != salesRole
              ? _buildSpeedDial(context: context)
              : null,
          extendBodyBehindAppBar: false, // Changed to false to avoid layout issues
          key: drawerkey,
          resizeToAvoidBottomInset: true,
          drawer: DrawerScreen(dkey: drawerkey),
          appBar: _buildAppBar(controller),
          body: RefreshIndicator(child: _getRoleBasedHomePage(context,controller,userrole), onRefresh:()async{
            await controller.refereshAllTicket();
          } ),
        ),
      ),
    );
  }

  Widget _getRoleBasedHomePage(BuildContext context,HomeScreenController controller ,String userRole) {
    return Material(
      child: SafeArea(
        child: _buildPageContent(context,controller,userRole),
      ),
    );
  }

  Widget _buildPageContent(BuildContext context,HomeScreenController controller ,String userRole) {
    switch (userRole) {
      case adminRole:
      case superUserRole:
      case agentRole:
        return _buildDashboardView(context,controller);
      case technicianRole:
        return TechnicianDashboardHomepage();
      case salesRole:
        return TechnicianDashboardHomepage();
      default:
        return Center(
          child: Text("Unauthorized access or no role found"),
        );
    }
  }

  Widget _buildDashboardView(BuildContext context, HomeScreenController controller) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildTicketSection(context),
                SizedBox(height: 20),
                _customerRatingView(context),
                SizedBox(height: 20,),
                _todayTicketView(context,controller),
                SizedBox(height: 20,),
                _buildAttendanceSection(context),
                SizedBox(height: 20),
                _buildAmcSection(context),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTicketSection(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1.4,
      child: _buildDashboardCard(
        context: context,
        title: 'Ticket Distribution',
        onTap: () => Get.toNamed(AppRoutes.ticketListScreen),
        actionButton: _buildActionButton(
          text: "Create Ticket",
          onTap: () => Get.toNamed(AppRoutes.ticketListCreationScreen),
        ),
        child: GraphViewScreen(),
      ),
    );
  }

  Widget _buildAttendanceSection(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.99,
      child: _buildDashboardCard(
        context: context,
        title: "Today's Attendance",
        onTap: () => Get.toNamed(AppRoutes.technicianListsScreen),
        actionButton: _buildActionButton(
          text: "Track All",
          onTap: () => Get.toNamed(AppRoutes.mapView),
        ),
        child: AttendanceMonitorDashboard(),
      ),
    );
  }

  Widget _buildAmcSection(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: _buildDashboardCard(
        context: context,
        title: "AMC Status",
        child: AmcStatusBarChart(),
      ),
    );
  }

  Widget _buildDashboardCard({
    required BuildContext context,
    required String title,
    required Widget child,
    VoidCallback? onTap,
    Widget? actionButton,
  }) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20
        // topLeft: Radius.circular(20),
        // bottomRight: Radius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          20
          // topLeft: Radius.circular(20),
          // bottomRight: Radius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20
              // topLeft: Radius.circular(20),
              // bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        size: 13,
                        color: blackColor,
                      ),
                    ),
                    if (actionButton != null) actionButton,
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        text,
        style: MontserratStyles.montserratSemiBoldTextStyle(size: 13),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(HomeScreenController controller) {
    return AnimatedAppBar(
    title: 'FieldSathi',
      actions: [
      IconButton(
        onPressed: () async {
          await Get.toNamed(AppRoutes.notificationsScreen);
        },
        icon: Icon(Icons.notifications_sharp, size: 25),
      ),
      _buildProfileMenu(controller),
      SizedBox(width: 10),
    ],

    );
    /*AppBar(
      backgroundColor: appColor,
      elevation: 4,
      title: Text(
        "FieldSathi",
        style: MontserratStyles.montserratBoldTextStyle(
          color: blackColor,
          size: 15,
        ),
      ),
      leading: IconButton(
        icon: Icon(FeatherIcons.menu),
        onPressed: () => drawerkey.currentState?.openDrawer(),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await Get.toNamed(AppRoutes.notificationsScreen);
          },
          icon: Icon(Icons.notifications_sharp, size: 25),
        ),
        _buildProfileMenu(controller),
        SizedBox(width: 10),
      ],
    );*/
  }

  Widget _buildProfileMenu(HomeScreenController controller) {
    return PopupMenuButton<String>(
      color: appColor,
      offset: Offset(0, 56),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: _getBackgroundImage(controller.profileImageUrl.value),
        ),
      ),
      itemBuilder: (BuildContext context) => [
        _buildPopupMenuItem('Profile', Icons.person, () {
          Get.toNamed(AppRoutes.editProfile);
        }),
        if(userrole == 'admin'|| userrole == 'superuser')
          _buildPopupMenuItem('Account', Icons.account_balance, () {
          Get.toNamed(AppRoutes.accountViewScreen);
        }),
        _buildPopupMenuItem('Pricing Plans', Icons.price_change_rounded, () {
          Get.toNamed(AppRoutes.pricingScreenView);
        }),
        _buildPopupMenuItem('Logout', Icons.exit_to_app, () {
          _loginShowPopUpView(controller, context);
          // _showLogoutDialog(context, controller);
        }),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String text,
      IconData icon,
      VoidCallback onTap,
      ) {
    return PopupMenuItem<String>(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }

  SpeedDial _buildSpeedDial({required BuildContext context}) {
    return SpeedDial(
      icon: _isDialOpen ? Icons.close : Icons.add,
      activeIcon: Icons.close,
      visible: true,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      backgroundColor: appColor,
      foregroundColor: Colors.black,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      children: _buildSpeedDialChildren(context),
    );
  }

  List<SpeedDialChild> _buildSpeedDialChildren(BuildContext context) {
    return [
      SpeedDialChild(
        child: Icon(Icons.add_home_work),
        backgroundColor: appColor,
        label: 'Field Worker',
        onTap: () => _showFieldWorkerOptions(context),
      ),
      SpeedDialChild(
        child: Icon(Icons.person_pin),
        backgroundColor: appColor,
        label: 'Manager',
        onTap: () => Get.toNamed(AppRoutes.SuperAgentsScreen),
      ),
      SpeedDialChild(
        child: Icon(Icons.person_pin_circle_sharp),
        backgroundColor: appColor,
        label: 'Services',
        onTap: () => Get.toNamed(AppRoutes.serviceCategoriesScreen),
      ),
      SpeedDialChild(
        child: Icon(Icons.list),
        backgroundColor: appColor,
        label: 'CRM',
        onTap: () => _showCrmOptions(context),
      ),
    ];
  }

  void _showFieldWorkerOptions(BuildContext context) {
    AppBottomSheets.show(
      context: context,
      title: 'Field Worker',
      actions: [
        _buildBottomSheetAction('Technician List', () async {
          Get.back();
          await Get.toNamed(AppRoutes.technicianListsScreen);
        }),
        _buildBottomSheetAction('Sales', () {
          Get.back();
          Get.toNamed(AppRoutes.salesListScreen);
        }),
        _buildBottomSheetAction('Expenditure', () {
          Get.back();
          Get.toNamed(AppRoutes.expenditureScreen);
        }),
        _buildBottomSheetAction('Material Requests', () {
          Get.back();
          Get.toNamed(AppRoutes.serviceReqScreen);
        }),
        _buildBottomSheetAction('Track All', () async {
          Get.back();
          await Get.toNamed(AppRoutes.mapView);
        }),
      ],
    );
  }

  void _showCrmOptions(BuildContext context) {
    AppBottomSheets.show(
      context: context,
      title: 'Customer List',
      actions: [
        _buildBottomSheetAction('Customer List', () {
          Get.back();
          Get.toNamed(AppRoutes.customerListScreen);
        }),
        _buildBottomSheetAction('Lead List', () {
          Get.back();
          Get.toNamed(AppRoutes.leadListScreen);
        }),
      ],
    );
  }

  CupertinoActionSheetAction _buildBottomSheetAction(
      String text,
      VoidCallback onPressed,
      ) {
    return CupertinoActionSheetAction(
      child: Text(text),
      onPressed: onPressed,
    );
  }

  void _showLogoutDialog(BuildContext context, HomeScreenController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout',
          style: MontserratStyles.montserratBoldTextStyle(
            size: 25,
            color: blackColor,
          ),
        ),
        content: Text(
          "Are you sure want to Logout",
          style: MontserratStyles.montserratSemiBoldTextStyle(
            size: 15,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {} /*controller.logout()*/,
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
            ),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  ImageProvider _getBackgroundImage(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty
        ? NetworkImage(imageUrl)
        : AssetImage(userImageIcon) as ImageProvider;
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

Widget _customerRatingView(BuildContext context) {
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Overall Rating Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Customer Ratings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 24),
                  SizedBox(width: 4),
                  Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),

          // Detailed Ratings
          _buildStarRow('5 Stars', 4.8),
          _buildStarRow('4 Stars', 3.5),
          _buildStarRow('3 Stars', 2.3),
          _buildStarRow('2 Stars', 1.2),
          _buildStarRow('1 Star', 0.8),

          SizedBox(height: 16),

          // Total Reviews
          Text(
            'Based on 1,234 Reviews',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper method to create star rows
Widget _buildStarRow(String label, double stars) {
  int fullStars = stars.floor();
  bool hasHalfStar = (stars - fullStars) >= 0.5;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        SizedBox(width: 8),
        Row(
          children: List.generate(5, (index) {
            if (index < fullStars) {
              return Icon(Icons.star, color: Colors.amber, size: 16);
            } else if (index == fullStars && hasHalfStar) {
              return Icon(Icons.star_half, color: Colors.amber, size: 16);
            } else {
              return Icon(Icons.star_border, color: Colors.amber, size: 16);
            }
          }),
        ),
      ],
    ),
  );
}

Widget _todayTicketView(BuildContext context, HomeScreenController controller) {
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Today's Ticket",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          vGap(20),
          // Replace Expanded with SizedBox or fixed height
          SizedBox(
            height: 300, // Adjust as needed
            child: Obx(() => controller.todayResponseData.isNotEmpty
                ?ListView.builder(
              itemCount: controller.todayResponseData.length,
              itemBuilder: (context, index) {
                final todayData = controller.todayResponseData[index];
                return _todayTicketViewbyResponse(context, todayData);
              },
            )
            :_buildEmptyState()
            )
            ,
          )
        ],
      ),
    ),
  );
}

Widget _todayTicketViewbyResponse(BuildContext context, TodaysTicket todayData) {
  return Card(
    elevation: 3,
    color: whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(FontAwesomeIcons.ticket,size: 30,color: appColor),
          Text(
            todayData.customerDetails?.customerName ?? 'Unknown Customer',
            style: MontserratStyles.montserratBoldTextStyle(
              size: 15,
              color: Colors.black,
            ),
          ),
          vGap(20),
          Row(
            children: [
              Icon(Icons.person),
              Text(
                '${todayData.assignTo?.firstName ?? ''} ${todayData.assignTo?.lastName ?? ''}',
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              )
            ],
          ),
          vGap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${todayData.assignTo!.phoneNumber}',
                style: MontserratStyles.montserratBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                todayData.status ?? 'No Status',
                style: MontserratStyles.montserratBoldTextStyle(
                  size: 15,
                  color: Colors.green,
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
_buildEmptyState() {
  return Center(
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          nullVisualImage,
          width: 300,
          height: 300,
        ),
        Text(
          'No services found',
          style: MontserratStyles.montserratNormalTextStyle(
            // size: 18,
            color: blackColor,
          ),
        ),
      ],
    ),
  );
}