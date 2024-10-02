import 'dart:ui';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/Extentions/text_field_extentions.dart';
import 'package:tms_sathi/utilities/validation_auth_ui.dart';
import '../constans/color_constants.dart';
import '../constans/string_const.dart';
import 'common_textFields.dart';
import 'gradient_button.dart';
import 'helper_widget.dart';

class CustomDialogue extends StatelessWidget with FormValidation {
  CustomDialogue(
      {Key? key,
        required this.title,
        required this.onOkTap,
        this.desc,
        this.descCon,
        this.emailCon,
        this.nameCon,
        this.phoneCon,
        this.imageUrl})
      : super(key: key);
  String title = "";
  Function() onOkTap;
  String? imageUrl;
  String? desc = "";
  String? phoneVal = "";

  TextEditingController? nameCon;
  TextEditingController? phoneCon;
  TextEditingController? emailCon;
  TextEditingController? descCon;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
          child: AlertDialog(
            scrollable: true,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: appColor.withOpacity(0.80),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 15.sp,
                      ),
                    ),
                  ),
                ),
                vGap(10),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    title,
                    style:  MontserratStyles.montserratBoldTextStyle(
                        size: 20.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            content: Text(
              desc ?? '',
              style: MontserratStyles.montserratBoldTextStyle(
                  size: 16.sp, color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          ),
        ));
  }

  Widget _hireUsForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vGap(10.sp),
          EntryField(
            title: "Name*",
            validator: (v) {
              if (v == null) {
                return "Enter profile Name";
              }
              if ((nameCon?.text ?? '').trim().isEmpty) {
                return "Enter Profile Name";
              }
              return null;
            },
            errortext: "Please Enter Name",
            controller: nameCon!,
            prefixIcon: Icon(
              Icons.person,
              size: Get.height * .02,
              color: darkBlue,
            ).paddingOnly(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
          ),
          vGap(10.sp),
          EntryField(
            title: "Email*",
            validator: (v) {
              if (v == null || (emailCon?.text ?? '').trim().isEmpty) {
                return "Please Enter Your Email";
              }
              if (!isEmailValid((emailCon?.text ?? "").trim())) {
                return "Please Enter Valid Email";
              }
              return null;
            },
            errortext: "Please Enter Email",
            controller: emailCon!,
            prefixIcon: Icon(
              Icons.email,
              size: Get.width * .02,
              color: darkBlue,
            ).paddingOnly(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
          ),
          vGap(10.sp),
          EntryField(
            title: "Phone*",
            validator: (v) {
              if (v == null) {
                return "Enter profile Phone";
              }
              if ((phoneCon?.text ?? '').trim().isEmpty) {
                return "Enter Profile Name";
              }
              return null;
            },
            errortext: "Please Enter Phone",
            controller: phoneCon!,
            prefixIcon: Container(
                padding: EdgeInsets.only(bottom: 4),
                child: CountryCodePicker(
                    flagWidth: 15.0,
                    initialSelection: 'IN',
                    boxDecoration:
                    const BoxDecoration(color: Colors.transparent),
                    showCountryOnly: true,
                    onChanged: (value) {
                      phoneVal = value.dialCode.toString();
                      // controller.update();
                    })),
          ),
          vGap(10.sp),
          EntryField(
            title: "Description*",
            validator: (v) {
              if (v == null) {
                return "Please Enter Description";
              }
              if ((descCon?.text ?? '').trim().isEmpty) {
                return "Please Enter Description";
              }
              return null;
            },
            errortext: "Please Enter Description",
            controller: descCon!,
            prefixIcon: Icon(
              Icons.description,
              size: Get.width * .02,
              color: darkBlue,
            ).paddingOnly(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
          ),
          vGap(10.sp),
        ],
      ),
    );
  }
}

class CustomDialogueMobile extends StatelessWidget with FormValidation {
  CustomDialogueMobile(
      {Key? key,
        required this.title,
        required this.content,
        required this.onOkTap,
        this.desc,
        this.descCon,
        this.emailCon,
        this.nameCon,
        this.phoneCon,
        this.imageUrl})
      : super(key: key);
  String title = "";
  Function() onOkTap;
  String content = "";
  String? desc = "";
  String? phoneVal = "";

  String? imageUrl = "";

  TextEditingController? nameCon;
  TextEditingController? phoneCon;
  TextEditingController? emailCon;
  TextEditingController? profileCon;
  TextEditingController? descCon;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
          child: AlertDialog(
            scrollable: true,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: darkBlue,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 15.sp,
                      ),
                    ),
                  ),
                ),
                vGap(5),
                imageUrl!.endsWith("preview.png")
                    ? Image.asset(
                  appIcon,
                  color: Colors.white,
                  height: Get.height * .15.sp,
                  width: Get.width * .2.sp,
                  fit: BoxFit.contain,
                )
                    : Image.asset(
                  imageUrl!,
                  height: Get.height * .15.sp,
                  width: Get.width * .2.sp,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0.sp),
                  child: Text(
                    title,
                    style:
                    MontserratStyles.montserratBoldTextStyle(size: Get.height * .04),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            content: Container(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    desc ?? '',
                    style:MontserratStyles.montserratBoldTextStyle(
                        size: Get.height * .02),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),
                  vGap(20.sp),
                  _hireUsForm(),
                  vGap(10.sp),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GradientButton(
                          onTap: onOkTap,
                          name: "Hire",
                        ),
                      ),
                      hGap(5),
                      Expanded(
                        child: GradientButton(
                          onTap: () {
                            Get.back();
                          },
                          name: "Cancel",
                        ),
                      )
                    ],
                  ),
                  vGap(20.sp)
                ],
              ).marginSymmetric(horizontal: 0.sp),
            ),
          ),
        ));
  }

  Widget _hireUsForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vGap(10.sp),
          EntryField(
            title: "Name*",
            validator: (v) {
              if (v == null) {
                return "Enter profile Name";
              }
              if ((nameCon?.text ?? '').trim().isEmpty) {
                return "Enter Profile Name";
              }
              return null;
            },
            errortext: "Please Enter Name",
            controller: nameCon!,
            prefixIcon: Icon(
              Icons.person,
              size: Get.height * .04,
              color: darkBlue,
            ).paddingOnly(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
          ),
          vGap(10.sp),
          EntryField(
            title: "Email*",
            validator: (v) {
              if (v == null || (emailCon?.text ?? '').trim().isEmpty) {
                return "Please Enter Your Email";
              }
              if (!isEmailValid((emailCon?.text ?? "").trim())) {
                return "Please Enter Valid Email";
              }
              return null;
            },
            errortext: "Please Enter Email",
            controller: emailCon!,
            prefixIcon: Icon(
              Icons.email,
              size: Get.height * .04,
              color: darkBlue,
            ).paddingOnly(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
          ),
          vGap(10.sp),
          EntryField(
            title: "Phone*",
            validator: (v) {
              if (v == null) {
                return "Enter Phone No.";
              }
              if ((phoneCon?.text ?? '').trim().isEmpty) {
                return "Enter Phone No.";
              }
              return null;
            },
            errortext: "Please Enter Phone",
            controller: phoneCon!,
            prefixIcon: Container(
                padding: EdgeInsets.only(bottom: 4),
                child: CountryCodePicker(
                    flagWidth: 15.0,
                    initialSelection: 'IN',
                    boxDecoration:
                    const BoxDecoration(color: Colors.transparent),
                    showCountryOnly: true,
                    onChanged: (value) {
                      phoneVal = value.dialCode.toString();
                      // controller.update();
                    })),
          ),
          vGap(10.h),
          EntryField(
            title: "Profile*",
            validator: (v) {
              if (v == null) {
                return "Enter profile Name";
              }
              if ((phoneCon?.text ?? '').trim().isEmpty) {
                return "Enter Profile Name";
              }
              return null;
            },
            errortext: "Please Profile Name",
            controller: phoneCon!,
            prefixIcon: Icon(
              Icons.add,
              size: Get.height * .04,
              color: darkBlue,
            ).paddingOnly(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
          ),
          vGap(10.sp),
          EntryField(
            title: "Description*",
            validator: (v) {
              if (v == null) {
                return "Please Enter Description";
              }
              if ((descCon?.text ?? '').trim().isEmpty) {
                return "Please Enter Description";
              }
              return null;
            },
            errortext: "Please Enter Description",
            controller: descCon!,
            prefixIcon: Icon(
              Icons.description,
              size: Get.height * .04,
              color: darkBlue,
            ).paddingOnly(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
          ),
          vGap(10.sp),
        ],
      ),
    );
  }
}


class dynamicButton extends StatelessWidget {
  dynamicButton(
      {super.key,
        required this.name,
        required this.onTap,
        this.gradient,
        this.color});
  final String name;
  Gradient? gradient;
  Color? color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style:  MontserratStyles.montserratBoldTextStyle(
            size: 22,
          ),
        ),
      ),
    );
  }
}
