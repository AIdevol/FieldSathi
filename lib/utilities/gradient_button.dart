import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';

import '../constans/color_constants.dart';

class GradientButton extends StatelessWidget {
  GradientButton(
      {super.key,
        required this.name,
        required this.onTap,
        this.gradient,
        this.color,
        this.btnColor,
      });
  final String name;
  Gradient? gradient;
  Color? color;
  Color? btnColor;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color:btnColor?? appColor, // Button color
      borderRadius:BorderRadius.circular(30) ,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical:13.sp, horizontal:15.sp),
          //alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: gradient ??
                splashGradient2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style:  MontserratStyles.montserratSemiBoldTextStyle(
                size: 14.sp, color: color ?? Colors.black, height: 1.2),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.color, this.textcolor, this.title,this.onTap});
  Color? color;
  Color? textcolor;
  String? title;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: color ?? Colors.grey),
        child: Center(
          child: Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: MontserratStyles.montserratSemiBoldTextStyle(
                color: textcolor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
