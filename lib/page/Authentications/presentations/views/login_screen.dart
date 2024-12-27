import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/login_screen_controller.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import 'package:tms_sathi/Extentions/text_field_extentions.dart';
import '../../../../constans/string_const.dart';
import '../../../../navigations/navigation.dart';
import '../../../../utilities/common_textFields.dart';
import '../controllers/OtpViewController.dart';
import 'otp_view_screen.dart';

class LoginScreen extends GetView<LoginScreenController> {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyAnnotatedRegion(
        child: GetBuilder<LoginScreenController>(builder: (controller) {
          return SafeArea(child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black.withOpacity(.0),
            body: _mainScreen(context),));
        }
        ));
  }

  Widget _mainScreen(BuildContext context){
    return Stack(
      clipBehavior: Clip.none,
      children: [
      Container(
      alignment: Alignment.topCenter,
      height: Get.height,width: Get.width,
      color: appColor,
      child:  Image.asset(appIcon,fit: BoxFit.contain,),
    ),
        Positioned( left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
            top: MediaQuery.of(context).size.height * 0.35,child: _loginTextfields(context) )
      ],
    );
  }
Widget _loginTextfields(BuildContext context){
    return Container(
      height: Get.height* 0.8,
      width: Get.width* 0.5,
      decoration:  BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: appColor.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
        color: whiteColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      child: ListView(
        children: [ Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              vGap(15),
              Text('Login'.tr,style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 25),textAlign: TextAlign.center,),
              vGap(15),
              Text('Enter your login credentials'.tr,style: MontserratStyles.montserratSemiBoldTextStyle(color: Colors.grey, size: 16),textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),_form(context)],),
    );
}
  Widget _form(BuildContext context) {
    return Form(
        key: formGlobalKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              vGap(15),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: appColor.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25)
                ),
                child: CustomTextField(
                  hintText: "Email".tr,
                  controller: controller.emailcontroller,
                  textInputType: TextInputType.emailAddress,
                  // focusNode: controller.phoneFocusNode,
                  onFieldSubmitted: (String? value) {
                    // FocusScope.of(Get.context!)
                    //     .requestFocus(controller.passwordFocusNode);
                  },
                  labletext: "Email".tr,
                  prefix: Icon(FeatherIcons.mail, color: Colors.black,),
                  // validator: (value) {
                  //   return value?.isEmptyField(messageTitle: "Email");
                  // },
                  inputFormatters:[
                    // LengthLimitingTextInputFormatter(10),
                  ],
                ),
              ),
              vGap(30),
              // CustomTextField(
              //   hintText: "Password".tr,
              //   labletext: "Password".tr,
              //   // controller: controller.passwordController,
              //   // obsecureText: controller.obsecurePassword,
              //   validator: (value) {
              //     return value?.validatePassword();
              //   },
              //   prefix: Icon(FeatherIcons.lock, color: blackColor),
              //   suffix: IconButton(
              //       onPressed: () {
              //         // controller.showOrHidePasswordVisibility();
              //       },
              //       icon: const Icon(
              //         // controller.obsecurePassword
              //              Icons.visibility_off,
              //             // : Icons.visibility,
              //         color: Colors.grey,
              //       )),
              //   // focusNode: controller.passwordFocusNode,
              //   onFieldSubmitted: (String? value) {
              //     FocusScope.of(Get.context!).unfocus();
              //   },
              // ),
              // vGap(10),
              // InkWell(
              //   onTap: () {
              //     _openForgotcontainerBottomsheet();
              //     // Get.toNamed(AppRoutes.forgot);
              //   },
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: Container(
              //       height: 50,
              //       child: Text(
              //         "Forgot Password".tr,
              //         style: MontserratStyles.montserratBoldTextStyle(
              //             color: Colors.black54),
              //       ).paddingOnly(top: 10, right: 5, left: 10),
              //     ),
              //   ),
              // ).paddingSymmetric(horizontal: 10),

              InkWell(onTap: ()async{
                if (formGlobalKey.currentState!.validate()) {
                controller.hitloginApicall();
                  // Get.offAllNamed(AppRoutes.homeScreen);
                print('Registration button tapped');
              }},
                child: Container( height: Get.height*0.06,
                width: Get.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: appColor.withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25), color: appColor),
              child: Center(child: Text('Login'.tr,style: MontserratStyles.montserratSemiBoldTextStyle(color: blackColor, size: 18),textAlign: TextAlign.center,)),),),
              vGap(20),
              goToRegisterView(),
            ],

          ),
        ));
  }


  goToRegisterView() {
    return Text.rich(
      TextSpan(
          text: "Don't have an account? ".tr,
          style:
          MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: Colors.black45),
          children: [
            TextSpan(
              text: "Sign Up".tr,
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(AppRoutes.signUp);
                },
              style:MontserratStyles.montserratSemiBoldTextStyle(color: appColor),
            ),
          ]),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }



  Widget _forgotscreen(){
    return Column(children: [Container(child: Image.asset(forgotIcon))],);
  }
}

