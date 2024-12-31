import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';

import '../../../utilities/helper_widget.dart';
import '../controller/pricing_view_controller.dart';


//
// class PricingViewScreen extends GetView<PricingViewController> {
//   const PricingViewScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MyAnnotatedRegion(
//       child: GetBuilder<PricingViewController>(
//         init: PricingViewController(),
//         builder: (controller) => CupertinoPageScaffold(
//           backgroundColor: Color(0xFFF5F7FA),
//           navigationBar: CupertinoNavigationBar(
//               backgroundColor: appColor,
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87),
//               onPressed: () => Get.back(),
//             ),
//             // backgroundColor: Colors.transparent,
//             border: null,
//             middle: Text(
//               'Choose Your Plan',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               if (constraints.maxWidth > 900) {
//                 return _buildHorizontalLayout(controller, context, constraints);
//               } else {
//                 return _buildHorizontalLayout(controller, context, constraints);
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHorizontalLayout(
//       PricingViewController controller,
//       BuildContext context,
//       BoxConstraints constraints,
//       ) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 40),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: _buildPricingCards(controller, context, constraints),
//         ),
//       ),
//     );
//   }
//
//   // Widget _buildVerticalLayout(
//   //     PricingViewController controller,
//   //     BuildContext context,
//   //     BoxConstraints constraints,
//   //     ) {
//   //   return SingleChildScrollView(
//   //     child: Padding(
//   //       padding: EdgeInsets.symmetric(horizontal: 20),
//   //       child: Column(
//   //         children: _buildPricingCards(controller, context, constraints),
//   //       ),
//   //     ),
//   //   );
//   // }
//   //
//   List<Widget> _buildPricingCards(
//       PricingViewController controller,
//       BuildContext context,
//       BoxConstraints constraints,
//       ) {
//     final plans = [
//       PricingPlan(
//         name: 'Basic',
//         price: 400,
//         color: Color(0xFF6C63FF),
//         features: _baseFeatures,
//         popular: false,
//       ),
//       PricingPlan(
//         name: 'Pro',
//         price: 500,
//         color: Color(0xFF00C853),
//         features: _advanceFeatures,
//         popular: true,
//       ),
//       PricingPlan(
//         name: 'Enterprise',
//         price: 600,
//         color: Color(0xFFFF5252),
//         features: _premiumFeatures,
//         popular: false,
//       ),
//     ];
//
//     return plans.map((plan) {
//       return Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: constraints.maxWidth > 900 ? 15 : 0,
//           vertical: constraints.maxWidth > 900 ? 0 : 15,
//         ),
//         child: _buildPricingCard(
//           plan,
//           controller,
//           context,
//           constraints,
//         ),
//       );
//     }).toList();
//   }
//
//   Widget _buildPricingCard(
//       PricingPlan plan,
//       PricingViewController controller,
//       BuildContext context,
//       BoxConstraints constraints,
//       ) {
//     double cardWidth = constraints.maxWidth > 900
//         ? constraints.maxWidth * 0.25
//         : constraints.maxWidth * 0.85;
//
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 300),
//       margin: EdgeInsets.only(top: plan.popular ? 40 : 80),
//       width: cardWidth,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.topCenter,
//         children: [
//           // Popular Badge
//           if (plan.popular)
//             Positioned(
//               top: -20,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: plan.color,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: plan.color.withOpacity(0.3),
//                       blurRadius: 8,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Text(
//                   'MOST POPULAR',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//
//           // Main Card
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 0,
//                   blurRadius: 20,
//                   offset: Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 100),
//                 _buildPlanDetails(plan),
//                 Divider(height: 40),
//                 _buildFeaturesList(plan.features, plan.color),
//                 SizedBox(height: 100),
//               ],
//             ),
//           ),
//
//           // Header Pentagon
//           Positioned(
//             top: -50,
//             child: ClipPath(
//               clipper: ExtraWideTopPentagonalClipper(),
//               child: Container(
//                 width: cardWidth * 0.9,
//                 height: 160,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       plan.color,
//                       plan.color.withOpacity(0.8),
//                     ],
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: plan.color.withOpacity(0.3),
//                       spreadRadius: 0,
//                       blurRadius: 20,
//                       offset: Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       plan.name,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '₹',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           '${plan.price}',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 40,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           '/mo',
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Choose Button
//           Positioned(
//             bottom: -30,
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   controller.selectPlan(plan.name, plan.price);
//                   controller.startPayment();
//                 },
//                 borderRadius: BorderRadius.circular(40),
//                 child: Container(
//                   width: cardWidth * 0.7,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         plan.color,
//                         plan.color.withOpacity(0.8),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(40),
//                     boxShadow: [
//                       BoxShadow(
//                         color: plan.color.withOpacity(0.3),
//                         spreadRadius: 0,
//                         blurRadius: 20,
//                         offset: Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Get Started',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
class ExtraWideTopPentagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    // Smoother pentagon shape with curved corners
    path.moveTo(0, h * 0.1);
    path.quadraticBezierTo(0, 0, w * 0.1, 0);
    path.lineTo(w * 0.9, 0);
    path.quadraticBezierTo(w, 0, w, h * 0.1);
    path.lineTo(w, h * 0.52);
    path.quadraticBezierTo(w, h * 0.62, w * 0.9, h * 0.67);
    path.lineTo(w * 0.6, h * 0.9);
    path.quadraticBezierTo(w * 0.5, h, w * 0.4, h * 0.9);
    path.lineTo(w * 0.1, h * 0.67);
    path.quadraticBezierTo(0, h * 0.62, 0, h * 0.52);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class AutoScrollCards extends StatefulWidget {
  final Widget child;

  const AutoScrollCards({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AutoScrollCards> createState() => _AutoScrollCardsState();
}

class _AutoScrollCardsState extends State<AutoScrollCards> {
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  bool _isScrolling = true;
  bool _userIsScrolling = false;
  static const double scrollSpeed = 0.1; // Pixels per millisecond
  static const Duration scrollPauseTime = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startScrolling() {
    if (!_isScrolling) return;

    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_isScrolling || !mounted || _userIsScrolling) return;

      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        const scrollAmount = scrollSpeed * 50; // 50 is the timer duration

        if (currentScroll >= maxScroll) {
          // When reaching the end, pause briefly and then scroll back to start
          _scrollController.jumpTo(0);
          _pauseScrolling();
        } else {
          _scrollController.animateTo(
            currentScroll + scrollAmount,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  void _pauseScrolling() {
    _isScrolling = false;
    _scrollTimer?.cancel();
    Timer(scrollPauseTime, () {
      if (mounted) {
        setState(() {
          _isScrolling = true;
          _startScrolling();
        });
      }
    });
  }

  void _handleUserScroll(bool isScrolling) {
    _userIsScrolling = isScrolling;
    if (!isScrolling) {
      // Resume auto-scrolling after user stops scrolling
      Timer(scrollPauseTime, () {
        if (mounted && !_userIsScrolling) {
          _startScrolling();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _handleUserScroll(true),
      onPointerUp: (_) => _handleUserScroll(false),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _handleUserScroll(true);
          } else if (notification is ScrollEndNotification) {
            _handleUserScroll(false);
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: widget.child,
        ),
      ),
    );
  }
}
class PricingViewScreen extends GetView<PricingViewController> {
  const PricingViewScreen({super.key});

  // Define fixed card dimensions
  static const double cardWidth = 380.0;
  static const double cardSpacing = 20.0;
  static const double buttonHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<PricingViewController>(
        init: PricingViewController(),
        builder: (controller) =>
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: appColor,
          title: Text(
            'Our Pricing Plans',
            style: MontserratStyles.montserratBoldTextStyle(color: blackColor,size: 20)
          ),
          leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87),
          onPressed: () => Get.back(),
        ),),
        body:  _buildHorizontalLayout(controller, context),)
        /*CupertinoPageScaffold(
          backgroundColor: Color(0xFFF5F7FA),
          navigationBar: CupertinoNavigationBar(
            backgroundColor: appColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87),
              onPressed: () => Get.back(),
            ),
            border: null,
            middle: Text(
              'Choose Your Plan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          child:  _buildHorizontalLayout(controller, context)*//*AutoScrollCards(child: _buildHorizontalLayout(controller, context))*//*,
        ),*/
      ),
    );
  }

  Widget _buildHorizontalLayout(
      PricingViewController controller,
      BuildContext context,
      ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20), // Adjusted padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPricingCards(controller, context),
        ),
      ),
    );
  }

  List<Widget> _buildPricingCards(
      PricingViewController controller,
      BuildContext context,
      ) {
    final plans = [
      PricingPlan(
        name: 'Basic',
        price: 400,
        color: Color(0xFF6C63FF),
        features: _baseFeatures,
        popular: false,
      ),
      PricingPlan(
        name: 'Pro',
        price: 500,
        color: Color(0xFF00C853),
        features: _advanceFeatures,
        popular: true,
      ),
      PricingPlan(
        name: 'Enterprise',
        price: 600,
        color: Color(0xFFFF5252),
        features: _premiumFeatures,
        popular: false,
      ),
    ];

    return plans.asMap().entries.map((entry) {
      return Padding(
        padding: EdgeInsets.only(
          left: entry.key == 0 ? 0 : cardSpacing,
          right: entry.key == plans.length - 1 ? 0 : 0,
        ),
        child: _buildPricingCard(
          plan: entry.value,
          controller: controller,
          context: context,
        ),
      );
    }).toList();
  }

  Widget _buildPricingCard({
    required PricingPlan plan,
    required PricingViewController controller,
    required BuildContext context,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(top: plan.popular ? 40 : 80, bottom: buttonHeight / 2),
      width: cardWidth,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Main Card
          Container(
            width: cardWidth,
            constraints: BoxConstraints(minHeight: 600), // Ensure minimum height
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 100),
                  _buildPlanDetails(plan),
                  Divider(height: 40),
                  _buildFeaturesList(plan.features, plan.color),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Popular Badge


          // Header Pentagon
          Positioned(
            top: -50,
            child: Stack(
              children: [ClipPath(
                clipper: ExtraWideTopPentagonalClipper(),
                child: Container(
                  width: cardWidth * 0.9,
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        plan.color,
                        plan.color.withOpacity(0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: plan.color.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        plan.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${plan.price}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '/mo',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

                if (plan.popular)
                  Positioned(
                    top: 0,
                    left: 0,
                    // right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: plan.color.withOpacity(0.3),
                            width: 2,
                          ),
                        boxShadow: [
                          BoxShadow(
                            color: plan.color.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        'MOST POPULAR',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),]
            ),
          ),

          // Choose Button
          Positioned(
            bottom: -30,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  controller.selectPlan(plan.name, plan.price);
                  controller.startPayment();
                },
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  width: cardWidth * 0.7,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        plan.color,
                        plan.color.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: plan.color.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPlanDetails(PricingPlan plan) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          _buildDetailRow(Icons.task_alt, "50 Tasks per month"),
          SizedBox(height: 12),
          _buildDetailRow(Icons.people, "100 Customer Data"),
          SizedBox(height: 12),
          _buildDetailRow(Icons.support_agent, "24/7 Support"),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: plan.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Billed Annually',
              style: TextStyle(
                color: plan.color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Min. 5 Users',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesList(List<String> features, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features Included',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          ...features.map(
                (feature) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
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

class PricingPlan {
  final String name;
  final int price;
  final Color color;
  final List<String> features;
  final bool popular;

  PricingPlan({
    required this.name,
    required this.price,
    required this.color,
    required this.features,
    required this.popular,
  });
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