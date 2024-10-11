import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/page/plans/controller/pricing_view_controller.dart';
import 'package:tms_sathi/page/plans/price_models.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../constans/color_constants.dart';

class PricingViewScreen extends GetView<PricingViewController>{
  const PricingViewScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return MyAnnotatedRegion(child: GetBuilder<PricingViewController>(
        init: PricingViewController(),builder: (controller)=>CupertinoPageScaffold(navigationBar: CupertinoNavigationBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 25, color: Colors.black,),
        onPressed: () {
          Get.back();
        },),
      backgroundColor: appColor,
      middle: Text('Our Pricing Plans', style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),
    ), child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
      _basePlaneViewScreen(controller, context),
        hGap(30),
        _advancePlaneViewScreen(controller, context),
        hGap(30),
        _premiumPlaneViewScreen(controller,context)
    ],))));
  }

}

_basePlaneViewScreen(PricingViewController controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 80.0),
    child: Column(children: [
      Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: Get.height * 0.7,
            width: Get.width * 0.8,
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
            child: Padding(padding: EdgeInsets.only(top: 100, bottom: 40, left: 20, right: 20),
              child: Container(
                height: Get.height*.06,
                child: Column(
                  children: [
                    vGap(60),
                    Text("Tasks - 50/month", style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                    Text('Customer Data - 100',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black)),
                    Text(' Live Support - NA',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black)),
                    vGap(30),
                    Text('Billed Annually',style: MontserratStyles.montserratMediumTextStyle(size: 25, color: Colors.lightGreen)),
                    vGap(20),
                    Text('Min. 5 Users',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black)),
                    vGap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                      vGap(20),
                      Text('Features Included:', style: MontserratStyles.montserratSemiBoldTextStyle(size: 20, color: Colors.black),),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Job Scheduling & Dispatching', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Dashboard & Insights', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Attendance management', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        )
                        , Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Location Tracking', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                    ],),
                  ],
                ),
              ),),
          ),
          Positioned(
            top: -50,  // Set this to 0 to align with the upper side of the first container
            left: 14,
            child: ClipPath(
              clipper: ExtraWideTopPentagonalClipper(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height: 150,
                width: 300,
                color: Colors.teal,
                  child: Column(children: [
                    Text('Base', style: MontserratStyles.montserratBoldTextStyle(size: 25),),
                    vGap(10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.currency_rupee, color: whiteColor,),
                          Text('400/-Month',style: TextStyle(color: whiteColor,fontSize: 35, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],)
              ),
            ),
          ),
          Positioned(
            bottom: -40,  // Set this to 0 to align with the upper side of the first container
            left: 14,
            child: InkWell(
              onTap: (){
            controller.selectPlan('Base',400);
            controller.startPayment();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height:80,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(child: Text('CHOOSE', style: MontserratStyles.montserratBoldTextStyle(size: 30),),),
              ),
            ),
          ),
        ],
      ),
    ]),
  );
}
_advancePlaneViewScreen(PricingViewController controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 80.0),
    child: Column(children: [
      Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: Get.height * 0.7,
            width: Get.width * 0.8,
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
            child: Padding(padding: EdgeInsets.only(top: 100, bottom: 40, left: 20, right: 20),
              child: Container(
                height: Get.height*.06,
                child: Column(
                  children: [
                    vGap(60),
                    Text("Tasks - 50/month", style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                    Text('Customer Data - 100',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black)),
                    Text(' Live Support - NA',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black)),
                    vGap(30),
                    Text('Billed Annually',style: MontserratStyles.montserratMediumTextStyle(size: 25, color: Colors.lightGreen)),
                    vGap(20),
                    Text('Min. 5 Users',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black)),
                    vGap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        vGap(20),
                        Text('Features Included:', style: MontserratStyles.montserratSemiBoldTextStyle(size: 20, color: Colors.black),),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Complaints Management', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Customer Management', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Expense Management', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        )
                        , Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Job completion report', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Lead Management', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                      ],),

                  ],
                ),
              ),),
          ),
          Positioned(
            top: -50,  // Set this to 0 to align with the upper side of the first container
            left: 14,
            child: ClipPath(
              clipper: ExtraWideTopPentagonalClipper(),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  height: 150,
                  width: 300,
                  color: Colors.lightGreen,
                  child: Column(children: [
                    Text('Advance', style: MontserratStyles.montserratBoldTextStyle(size: 25),),
                    vGap(10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.currency_rupee, color: whiteColor,),
                          Text('500/-Month',style: TextStyle(color: whiteColor,fontSize: 35, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],)
              ),
            ),
          ),
          Positioned(
            bottom: -40,  // Set this to 0 to align with the upper side of the first container
            left: 14,
            child: InkWell(
              onTap: (){
                controller.selectPlan('Advance',500);
                controller.startPayment();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height:80,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(child: Text('CHOOSE', style: MontserratStyles.montserratBoldTextStyle(size: 30),),),
              ),
            ),
          ),
        ],
      ),
    ]),
  );
}
_premiumPlaneViewScreen(PricingViewController controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 80.0),
    child: Column(children: [
      Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: Get.height * 0.7,
            width: Get.width * 0.8,
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
            child: Padding(padding: EdgeInsets.only(top: 100, bottom: 40, left: 20, right: 20),
              child: Container(
                height: Get.height*.06,
                child: Column(
                  children: [
                    vGap(40),
                    Text("Tasks - 50/month", style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                    Text('Customer Data - 100',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black)),
                    Text(' Live Support - NA',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black)),
                    vGap(30),
                    Text('Billed Annually',style: MontserratStyles.montserratMediumTextStyle(size: 25, color: Colors.lightGreen)),
                    vGap(20),
                    Text('Min. 5 Users',style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black)),
                    vGap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        vGap(20),
                        Text('Features Included:', style: MontserratStyles.montserratSemiBoldTextStyle(size: 20, color: Colors.black),),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('User Management', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('AMC Management', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Job Completion Report', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        )
                        , Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Checklist Management', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Path Traveled', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        )
                        ,   Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_sharp, size: 20, color: Colors.green,),
                              hGap(10),
                              Text('Item Inventory', style: MontserratStyles.montserratMediumTextStyle(size: 15, color: Colors.black),),
                            ],
                          ),
                        ),

                      ],),

                  ],
                ),
              ),),
          ),
          Positioned(
            top: -50,  // Set this to 0 to align with the upper side of the first container
            left: 14,
            child: ClipPath(
              clipper: ExtraWideTopPentagonalClipper(),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  height: 150,
                  width: 300,
                  color: Colors.redAccent,
                  child: Column(children: [
                    Text('Primium', style: MontserratStyles.montserratBoldTextStyle(size: 25),),
                    vGap(10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.currency_rupee, color: whiteColor,),
                          Text('400/-Month',style: TextStyle(color: whiteColor,fontSize: 35, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],)
              ),
            ),
          ),
          Positioned(
            bottom: -40,  // Set this to 0 to align with the upper side of the first container
            left: 14,
            child: InkWell(
              onTap: (){
                controller.selectPlan('Premium',600);
                controller.startPayment();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height:80,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),

                child: Center(child: Text('CHOOSE', style: MontserratStyles.montserratBoldTextStyle(size: 30),),),
              ),
            ),
          ),
        ],
      ),
    ]),
  );
}


// Widget buildContainerDetails(BuildContext context){
//   return Padding(padding: EdgeInsets.only(top: 40), child:Column(children: [
//     Text('Features Included:', style: MontserratStyles.montserratSemiBoldTextStyle(size: 20, color: Colors.black),)
//     Tasks - 50/month
//
// Live Support - NA
//     // PricingCard(features: [
//     //   true ,true, true, true,true,true
//     // ])
//   ],) ,);
// }

class ExtraWideTopPentagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    // Further increase the width of the top side of the pentagon
    path.moveTo(0, 0); // Top-left, at the very left edge
    path.lineTo(w, 0); // Top-right, at the very right edge
    path.lineTo(w, h * 0.62); // Right bottom
    path.lineTo(w * 0.5, h); // Bottom center
    path.lineTo(0, h * 0.62); // Left bottom
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/*class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width - 90, 0);
    path.quadraticBezierTo(size.width - 50, size.height / 2, size.width - 90, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}*/

// _basePlaneViewScreen(PricingViewController controller, BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 80.0),
//     child: Column(
//       children: [
//         Stack(
//           children: [
//             // Main container with arrow shape
//             Container(
//               height: Get.height * 0.7,
//               width: Get.width * 0.8,
//               child: ClipPath(
//                 clipper: ArrowClipper(),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: whiteColor,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 1,
//                         blurRadius: 5,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // Positioned child container
//             Positioned(
//               top: 10.32,
//               left: 20,
//               right: 20,
//               child: Container(
//                 height: 200,
//                 width: 100,
//                 color: appColor,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Custom Clipper for Arrow Shape at the Bottom
/*
class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Starting at the top-left corner
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 30); // Move down the left edge
    path.lineTo(size.width / 2 - 20, size.height - 30); // Left side of arrow
    path.lineTo(size.width / 2, size.height); // Arrow point at the bottom center
    path.lineTo(size.width / 2 + 20, size.height - 30); // Right side of arrow
    path.lineTo(size.width, size.height - 30); // Move up the right edge
    path.lineTo(size.width, 0); // Back to the top-right corner

    // Closing the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
*/
