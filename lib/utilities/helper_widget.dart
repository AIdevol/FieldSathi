import 'package:appbar_animated/appbar_animated.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constans/color_constants.dart';
import 'google_fonts_textStyles.dart';

Widget hGap(double width) {
  return SizedBox(width: width);
}

Widget vGap(double height) {
  return SizedBox(height: height);
}

Widget divider({Color? color}) {
  return Divider(
    thickness: .1,
    color: color ?? darkBlue.withOpacity(.2),
  ).paddingSymmetric(vertical: 5.sp);
}

String formatDate(String date) {
  if (date == '') {
    return "";
  } else {
    return DateFormat('MM-dd-yy').format(DateTime.parse(date));
  }
}

List<BoxShadow> greyShadow = [
  const BoxShadow(color: Colors.grey, blurRadius: 3),
  const BoxShadow(color: Colors.grey, blurRadius: 3)
];

List<BoxShadow> lightShadow = [
  BoxShadow(color: Colors.grey.shade300, blurRadius: 3),
  BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
];

/*
Widget shimmerEffectWidget(
    {required Widget child, Widget? shimmerWidget, bool showShimmer = true}) {
  return showShimmer
      ? Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.black12,
          child: shimmerWidget ?? child)
      : child;
}
*/

BoxDecoration containerDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8)],
      border: Border.all(color: Colors.deepOrange.withOpacity(.3)));
}

backAppBar(
    {String? title,
      Function? onPress,
      List<Widget>? action,
      Color? appcolor,
      Widget? leading,
      bool? isDark,}) =>
    AppBar(
      backgroundColor:appcolor?? appColor,
      centerTitle: true,
      elevation: 0,
      leading: leading ??
          InkWell(
              child: Container(
                height: 22,
                width: 22,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 17,
                ),
              ),
              onTap: () {
                Get.focusScope!.unfocus();
                // Get.back();
                if (onPress != null) {
                  onPress();
                } else {
                  Get.back();
                }
              }),
      title: Text(
        title ?? "",
        style: MontserratStyles.montserratBoldTextStyle(color: Colors.black),
      ),
    );

class MyAnnotatedRegion extends StatelessWidget {
  Widget child;
  bool? isDark;
  MyAnnotatedRegion({Key? key, required this.child, this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: appColor,
            statusBarIconBrightness: Brightness.dark),
        child: Container(color: Colors.white, child: child));
  }
}

launchURLFun(String? linkUrl) async {
  final Uri url = Uri.parse(linkUrl ?? '');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch ${url}');
  }
}

Widget arrowImage({Color? color, double? size}) {
  return Image.asset(
    "assets/white-arrow.png",
    height: size ?? 120,
    width: size ?? 120,
    fit: BoxFit.contain,
    color: color ?? darkBlue,
    repeat: ImageRepeat.repeatX,
  );
}

Widget transformArrow({Color? color, double? size}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      arrowImage(color: color, size: size),
      Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: arrowImage(color: color, size: size),
      )
    ],
  );
}

BoxDecoration curveDecoration({Color? color}) {
  return BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.elliptical(Get.width * .3, Get.width * .07),
          bottomLeft: Radius.elliptical(
            Get.width * .3,
            Get.width * .07,
          )),
      color: color ?? darkBlue);
}
Widget SVGImage(path,{color}){
  return  SvgPicture.asset(
    path,
    color: color,
  ).paddingAll(12);
}
Widget backIcon({Function()? onBack}){
  return InkWell(
      onTap: onBack??()=>Get.back(),
      child: Container(
          height: 22,
          width: 22,
          child: const Icon(Icons.arrow_back,color: Colors.black,size: 20,)));
}

Widget shimmerEffectWidget(
    {required Widget child, Widget? shimmerWidget, bool showShimmer = true}) {
  return showShimmer
      ? Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.black12,
      child: shimmerWidget ?? child)
      : child;
}

Widget profileBackAppbar(BuildContext context, ColorAnimated colorAnimated) {
  return  AppBar(
    backgroundColor: appColor,
    centerTitle: true,
    elevation: 0,
    leading:
    InkWell(
        child: Container(
          height: 22,
          width: 22,
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 17,
          ),
        ),
        onTap: () {
          Get.focusScope!.unfocus();
          Get.back();
        }),
    title: Text(
      "Profile" ?? "",
      style: MontserratStyles.montserratBoldTextStyle(color: Colors.black),
    ),
  );
}