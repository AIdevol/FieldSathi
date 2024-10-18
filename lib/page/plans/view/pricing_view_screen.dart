import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constans/color_constants.dart';
import '../../../utilities/google_fonts_textStyles.dart';
import '../../../utilities/helper_widget.dart';
import '../controller/pricing_view_controller.dart';

class ExtraWideTopPentagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path.moveTo(0, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h * 0.62);
    path.lineTo(w * 0.5, h);
    path.lineTo(0, h * 0.62);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class PricingViewScreen extends GetView<PricingViewController> {
  const PricingViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<PricingViewController>(
        init: PricingViewController(),
        builder: (controller) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 25, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            backgroundColor: appColor,
            middle: Text(
              'Our Pricing Plans',
              style: MontserratStyles.montserratBoldTextStyle(
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Check if screen is wide enough for horizontal layout
              if (constraints.maxWidth > 900) {
                return _buildHorizontalLayout(controller, context, constraints);
              } else {
                return _buildVerticalLayout(controller, context, constraints);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalLayout(
      PricingViewController controller,
      BuildContext context,
      BoxConstraints constraints,
      ) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPricingCard(
            'Base',
            400,
            Colors.teal,
            _baseFeatures,
            controller,
            context,
            constraints,
          ),
          SizedBox(width: 20),
          _buildPricingCard(
            'Advance',
            500,
            Colors.lightGreen,
            _advanceFeatures,
            controller,
            context,
            constraints,
          ),
          SizedBox(width: 20),
          _buildPricingCard(
            'Premium',
            600,
            Colors.redAccent,
            _premiumFeatures,
            controller,
            context,
            constraints,
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalLayout(
      PricingViewController controller,
      BuildContext context,
      BoxConstraints constraints,
      ) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildPricingCard(
              'Base',
              400,
              Colors.teal,
              _baseFeatures,
              controller,
              context,
              constraints,
            ),
            SizedBox(height: 20),
            _buildPricingCard(
              'Advance',
              500,
              Colors.lightGreen,
              _advanceFeatures,
              controller,
              context,
              constraints,
            ),
            SizedBox(height: 20),
            _buildPricingCard(
              'Premium',
              600,
              Colors.redAccent,
              _premiumFeatures,
              controller,
              context,
              constraints,
            ),
            SizedBox(height: 60), // Bottom padding for last card
          ],
        ),
      ),
    );
  }

  Widget _buildPricingCard(
      String planName,
      int price,
      Color color,
      List<String> features,
      PricingViewController controller,
      BuildContext context,
      BoxConstraints constraints,
      ) {
    double cardWidth = constraints.maxWidth > 900
        ? constraints.maxWidth * 0.25
        : constraints.maxWidth * 0.85;

    return Container(
      margin: EdgeInsets.only(top: 80),
      width: cardWidth,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Main Card
          Container(
            decoration: BoxDecoration(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 100), // Space for header
                _buildPlanDetails(),
                Divider(),
                _buildFeaturesList(features),
                SizedBox(height: 80), // Space for button
              ],
            ),
          ),

          // Header Pentagon
          Positioned(
            top: -50,
            child: ClipPath(
              clipper: ExtraWideTopPentagonalClipper(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                width: cardWidth * 0.9,
                height: 150,
                color: color,
                child: Column(
                  children: [
                    Text(
                      planName,
                      style: MontserratStyles.montserratBoldTextStyle(size: 25),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.currency_rupee, color: whiteColor),
                        Text(
                          '$price/-Month',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Choose Button
          Positioned(
            bottom: -40,
            child: InkWell(
              onTap: () {
                controller.selectPlan(planName, price);
                controller.startPayment();
              },
              child: Container(
                width: cardWidth * 0.9,
                height: 80,
                decoration: BoxDecoration(
                  color: color,
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
                    'CHOOSE',
                    style: MontserratStyles.montserratBoldTextStyle(size: 30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanDetails() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Tasks - 50/month",
            style: MontserratStyles.montserratMediumTextStyle(
              size: 15,
              color: Colors.black,
            ),
          ),
          Text(
            'Customer Data - 100',
            style: MontserratStyles.montserratMediumTextStyle(
              size: 15,
              color: Colors.black,
            ),
          ),
          Text(
            'Live Support - NA',
            style: MontserratStyles.montserratMediumTextStyle(
              size: 15,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Billed Annually',
            style: MontserratStyles.montserratMediumTextStyle(
              size: 25,
              color: Colors.lightGreen,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Min. 5 Users',
            style: MontserratStyles.montserratMediumTextStyle(
              size: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(List<String> features) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features Included:',
            style: MontserratStyles.montserratSemiBoldTextStyle(
              size: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          ...features.map(
                (feature) => Padding(
              padding: EdgeInsets.only(left: 16, top: 10),
              child: Row(
                children: [
                  Icon(Icons.check_circle_sharp, size: 20, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      feature,
                      style: MontserratStyles.montserratMediumTextStyle(
                        size: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Define features lists
const _baseFeatures = [
  'Job Scheduling & Dispatching',
  'Dashboard & Insights',
  'Attendance management',
  'Location Tracking',
];

const _advanceFeatures = [
  'Complaints Management',
  'Customer Management',
  'Expense Management',
  'Job completion report',
  'Lead Management',
];

const _premiumFeatures = [
  'User Management',
  'AMC Management',
  'Job Completion Report',
  'Checklist Management',
  'Path Traveled',
  'Item Inventory',
];